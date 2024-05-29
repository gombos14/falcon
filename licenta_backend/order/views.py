from rest_framework import generics
from order.models import Order
from order.serializers import OrderSerializer, OrderCreateSerializer


class OrderView(generics.ListCreateAPIView):
    queryset = Order.objects.all()

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return OrderCreateSerializer
        return OrderSerializer
