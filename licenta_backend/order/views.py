from rest_framework import generics
from order.models import Order
from order.serializers import OrderSerializer


class OrderCreateView(generics.ListCreateAPIView):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

    def get_queryset(self):
        pass
