from rest_framework import serializers

from order.models import Order
from furniture.serializers import FurnitureSerializer


class OrderSerializer(serializers.ModelSerializer):
    furniture = FurnitureSerializer()

    class Meta:
        model = Order
        fields = ['id', 'user', 'furniture', 'period', 'wage', 'renting_starts_at']


class OrderCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ['user', 'furniture', 'period']
