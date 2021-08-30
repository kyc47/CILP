from rest_framework import viewsets, permissions, generics, status
from myapp.models import User, GetData
from myapp.serializers import UserSerializer
from myapp.serializers import GetDataSerializer
from myapp.serializers import LoginUserSerializer
from myapp.serializers import GetScreenSerializer
from rest_framework.viewsets import ReadOnlyModelViewSet, ModelViewSet
from rest_framework.response import Response
from django.db.models import TextField
from django.db.models.functions import Cast
import uuid

class UserViewSet(viewsets.ModelViewSet):
    serializer_class = UserSerializer

    #
    # def get_queryset(self):
    #     return User.objects.all()

    def perform_create(self, serializer):
        serializer.save()


class LoginAPI(generics.GenericAPIView):
    serializer_class = LoginUserSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid()
        user = serializer.validated_data

        try:
            uid = User.objects.get(user_id=user['user_id'])
            data = User(uid)
            return Response(
                {
                    "uid": str(data.uid.uid),
                },
                status.HTTP_200_OK
            )
        except:
            return Response({
                "result": "Not ID"
            },
                status.HTTP_204_NO_CONTENT
            )


class GetDataViewSet(ModelViewSet):
    queryset = GetData.objects.all()
    serializer_class = GetDataSerializer

class GetScreenViewSet(viewsets.ModelViewSet):
    serializer_class = GetScreenSerializer

    def perform_create(self, serializer):
        serializer.save()
