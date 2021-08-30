from django.db import models
import uuid
from django.db import models
import uuid
from django.contrib.auth.models import AbstractBaseUser
from django.db import models

# Create your models here.
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

class User(models.Model):
    uid = models.UUIDField(primary_key=True, default=uuid.uuid4)
    user_id = models.CharField(max_length=30, default='')
    lasted_sign = models.DateTimeField(auto_now_add=True)
    password = models.CharField(max_length=30,default='')

# class Post(models.Model):
#     title = models.CharField(max_length=100)
#     content = models.TextField()
#     is_public = models.BooleanField(default=False)
#     create_at = models.DateTimeField(auto_now_add=True)
#     update_at = models.DateTimeField(auto_now=True)
# class Sign(models.Model):
#     id = models.UUIDField(primary_key=True)
#     uid = models.ForeignKey('User', on_delete=models.CASCADE, auto_created=True)
#     signin = models.DateTimeField(auto_now_add=True)
#     signout = models.DateTimeField()
#
#
class GetData(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    uid = models.ForeignKey('User', on_delete=models.CASCADE)
    time = models.DateTimeField(auto_now_add=True)
    data = models.TextField()
#
#
# class GetScreenSize(models.Model):
#     id = models.UUIDField(primary_key=True)
#     uid = models.ForeignKey('User', on_delete=models.CASCADE, auto_created=True)
#     time = models.DateTimeField(auto_now_add=True)
#     interaction = models.CharField(max_length=10)
#     x = models.CharField(max_length=10)
#     y = models.CharField(max_length=10)

class GetScreen(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    uid = models.ForeignKey('User', on_delete=models.CASCADE)
    time = models.DateTimeField(auto_now_add=True)
    x = models.CharField(max_length=30)
    y = models.CharField(max_length=30)
    description = models.CharField(max_length=10)