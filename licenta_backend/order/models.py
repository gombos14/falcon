import datetime
import os

from django.db import models
from django.contrib.auth import get_user_model
from django.conf import settings
from furniture.models import Furniture
from pgpt_python.client import PrivateGPTApi

User = get_user_model()


class Order(models.Model):
    PERIOD_CHOICES = (
        ('6', 'six month'),
        ('12', '12 months'),
        ('18', '18 months'),
        ('24', '24 months'),
        ('undetermined', 'undetermined')
    )

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='orders', null=False, blank=False)
    furniture = models.ForeignKey(Furniture, on_delete=models.CASCADE, related_name='orders', null=False, blank=False)
    period = models.CharField(max_length=255, choices=PERIOD_CHOICES, null=False, blank=False, default='undetermined')
    wage = models.DecimalField(max_digits=6, decimal_places=2, null=False, blank=False, default=0)
    renting_starts_at = models.DateField(default=datetime.date.today, null=False, blank=False)

    def __str__(self):
        return 'Order %d: %s - %s' % (self.id, self.user, self.furniture.title)

    def save(self, *args, **kwargs):
        wage = self.furniture.price
        try:
            if discount := self.furniture.discount:
                wage -= wage * discount.percentage
        except Furniture.discount.RelatedObjectDoesNotExist:
            pass
        self.wage = wage
        super(Order, self).save(*args, **kwargs)

        file_name = f'{self.user.id}_order_{self.id}.txt'
        with open(file_name, 'w') as write_file:
            write_file.write(f'Order {self.id} details:\n')
            write_file.write(f'Furniture title: {self.furniture.title}\n')
            write_file.write(f'Renting period: {self.period}\n')
            write_file.write(f'Wage: {self.wage}\n')
            write_file.write(f'Renting starts at: {self.renting_starts_at}')

        client = PrivateGPTApi(base_url=settings.PRIVATE_GPT_URL, timeout=300.0)
        with open(file_name, 'rb') as rf:
            doc_id = client.ingestion.ingest_file(file=rf).data[0].doc_id
            print('File successfully ingested: %s' % doc_id)

        os.remove(file_name)
