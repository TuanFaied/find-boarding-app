from django.db import models
from authentication.models import User
# Create your models here.

class Owner(models.Model):
    user = models.OneToOneField(User,on_delete = models.CASCADE,related_name="owner_account")
    

    
