from django.urls import path
from rest_framework.generics import ListCreateAPIView

from order.models import Order
from order.serializers import OrderSerializer
from order.views import OrderView

urlpatterns = [
    path('orders/', OrderView.as_view(), name='orders'),
]
