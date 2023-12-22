from django.urls import path
from authentication import views


urlpatterns = [
    path('', views.index, name='index'),
    path('login/', views.login, name='auth_login'),
    path('register/', views.RegisterView.as_view(), name='auth_register'),
]
