from django.urls import path
from chat import views


urlpatterns = [
    path('prompt/', views.privategpt_response_view, name='chat-prompt'),
]
