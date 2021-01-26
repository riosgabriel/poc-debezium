from django.db import models


# Create your models here.
class Item(models.Model):
    description = models.CharField(max_length=200)
    price = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        db_table = "items"


class Order(models.Model):
    items = models.ManyToManyField(Item)

    class Meta:
        db_table = "orders"
