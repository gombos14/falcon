from django.urls import path, include
from rest_framework.routers import DefaultRouter

from furniture import views


router = DefaultRouter()
router.register(r'furniture', views.FurnitureViewSet, basename='furniture')

urlpatterns = [
    path('', include(router.urls)),
]
