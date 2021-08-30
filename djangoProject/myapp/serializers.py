from myapp.models import User
from myapp.models import GetData, GetScreen
from rest_framework import serializers
from django.contrib.auth import authenticate, get_user_model
from rest_framework import serializers
from rest_framework import serializers


# User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ("user_id",)


class LoginUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('user_id', 'uid')


class GetDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = GetData
        fields = '__all__'


class GetScreenSerializer(serializers.ModelSerializer):
    class Meta:
        model = GetScreen
        fields = '__all__'

# serializer = UserSerizalizer(data=request.POST)
# if serializer.is_valid():
#     serializer.save()
#     return JsonResponse(serializer.data, status=201)
# return JsonResponse(serializer.errors, status=400)
