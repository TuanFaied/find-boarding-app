# Create your models here.
from django.db import models
from authentication.models import User


class BoardingHouse(models.Model):
    owner = models.ForeignKey(User, on_delete=models.CASCADE, related_name='boarding_houses')
    address = models.CharField(max_length=255)
    rent = models.DecimalField(max_digits=10, decimal_places=2)
    number_of_rooms = models.IntegerField()
    capacity_of_people = models.IntegerField()
    university_name = models.CharField(max_length=255)
    university_faculty = models.CharField(max_length=255)
    university_location = models.CharField(max_length=1000)
    location = models.CharField(max_length=1000)
    id = models.AutoField(primary_key=True)
    phone_number = models.CharField(max_length = 15, null=True)


class Image(models.Model):
    image = models.ImageField(upload_to='boarding_images/', null=True, blank=True)
    boarding_house = models.ForeignKey(BoardingHouse, on_delete=models.CASCADE)
    
