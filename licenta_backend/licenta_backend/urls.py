from django.urls import path, include

urlpatterns = [
    path('authentication/', include('authentication.urls')),
    path('furniture/', include('furniture.urls')),
    path('api-auth/', include('rest_framework.urls'))
]
