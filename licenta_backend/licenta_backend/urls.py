from django.urls import path, include

urlpatterns = [
    path('authentication/', include('authentication.urls')),
    path('furniture/', include('furniture.urls')),
    path('order/', include('order.urls')),
    path('api-auth/', include('rest_framework.urls')),
    path('chat/', include('chat.urls'))
]
