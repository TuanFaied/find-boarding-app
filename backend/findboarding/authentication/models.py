from django.db import models
from django.contrib.auth.models import AbstractUser
from django.conf import settings
from rest_framework.authtoken.models import Token
# Create your models here.

def default_profile_image():
    return 'profile_images/1.png'

class User(AbstractUser):
    ROLE_CHOICES = (
        ('admin','Admin'),
        ('owner','Owner'),
        ('tenant', 'Tenant'),
    )

    role = models.CharField(max_length=15, choices = ROLE_CHOICES)
    profile_image = models.ImageField(upload_to='profile_images/', default=default_profile_image, null=True, blank=True)
    id = models.AutoField(primary_key=True)
