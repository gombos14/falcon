from django.db import models


class Furniture(models.Model):
    title = models.CharField(max_length=30)
    description = models.TextField()
    price = models.DecimalField(max_digits=6, decimal_places=2)
    image = models.CharField(max_length=255)


class Discount(models.Model):
    furniture = models.OneToOneField(Furniture, on_delete=models.CASCADE, null=False, blank=False)
    percentage = models.DecimalField(max_digits=6, decimal_places=2)
