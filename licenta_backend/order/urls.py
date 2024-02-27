from django.urls import path
from rest_framework.generics import ListCreateAPIView

from order.models import Order
from order.serializers import OrderSerializer


urlpatterns = [
    path('orders/', ListCreateAPIView.as_view(queryset=Order.objects.all(), serializer_class=OrderSerializer),
         name='orders'),
]
