from django.shortcuts import render
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from .models import Owner
from boarding.serializers import BoardingHouseSerializer
from boarding.models import BoardingHouse, Image
# Create your views here.

class BoardingHouseListCreateView(generics.ListCreateAPIView):
    permission_classes =[IsAuthenticated]

    def get_queryset(self):
        user_instance = self.request.user
        if user_instance.is_authenticated and user_instance.role == 'owner':
            return BoardingHouse.objects.filter(owner=user_instance)
        else:
            return BoardingHouse.objects.none()
    
    serializer_class = BoardingHouseSerializer

    def perform_create(self, serializer):
        boarding_house = serializer.save(owner=self.request.user)

        images_data = self.request.FILES.getlist('images')
        for image_data in images_data:
            Image.objects.create(image=image_data,boarding_house=boarding_house)


class BoardingHouseUpdateDeleteView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = BoardingHouseSerializer
    def get_queryset(self):
        # Only allow updates/deletes for boardings owned by the logged-in owner
        user_instance = self.request.user
        if user_instance.is_authenticated and user_instance.role == 'owner':
            # Fetch the owner account associated with the user
            owner_account = user_instance.owner_account
            return BoardingHouse.objects.filter(owner=user_instance)
        else:
            # If not an owner or not authenticated, return an empty queryset
            return BoardingHouse.objects.none()

    def perform_update(self, serializer):
        serializer.save(owner = self.request.user)
    
