from django.db import models
from authentication.models import User
from boarding.models import BoardingHouse
# Create your models here.

class Tenant(models.Model):
    user = models.OneToOneField(User,on_delete = models.CASCADE,related_name="tenant_account")
    saved_boardings = models.ManyToManyField(BoardingHouse, related_name='tenants', blank=True)
