from rest_framework import viewsets

from furniture.models import Furniture
from furniture.serializers import FurnitureSerializer


class FurnitureViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Furniture.objects.all()
    serializer_class = FurnitureSerializer
