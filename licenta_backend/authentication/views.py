from django.http import HttpResponse
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from django.contrib.auth.models import User
from authentication.serializers import RegisterSerializer
from rest_framework import generics
from django.contrib.auth import authenticate, login as login_user


class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    permission_classes = (AllowAny,)
    serializer_class = RegisterSerializer


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")


@api_view(['POST'])
@permission_classes([AllowAny])
def login(request):
    username, password = request.POST.get('username'), request.POST.get('password')
    if not username or not password:
        return Response({'error': 'Username or password not provided.'}, status=400)

    user = authenticate(request=request, username=username, password=password)
    if not user:
        return Response({'error': 'Failed to login.'}, status=400)

    login_user(request, user)
    return Response({'user': user.username}, status=200)


@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication])
@permission_classes([IsAuthenticated])
def example_view(request, format=None):
    content = {
        'user': str(request.user),  # `django.contrib.auth.User` instance.
        'auth': str(request.auth),  # None
    }
    return Response(content)
