from django.db import models
from django.contrib.auth import get_user_model
from furniture.models import Furniture

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

    def __str__(self):
        return 'Order %d: %s - %s' % (self.id, self.user, self.furniture.title)

    def save(self, *args, **kwargs):
        wage = self.furniture.price
        if discount := self.furniture.discount:
            wage -= wage * discount.percentage
        self.wage = wage
        super(Order, self).save(*args, **kwargs)
