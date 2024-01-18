from django.shortcuts import render
from rest_framework import generics
from boarding.serializers import BoardingHouseSerializer, ImageSerializer
from boarding.models import BoardingHouse, Image
from django.shortcuts import get_object_or_404
# Create your views here.

class BoardingHouseListCreateView(generics.ListCreateAPIView):
    serializer_class = BoardingHouseSerializer

    def get_queryset(self):
        # Return all boardings without filtering based on the owner
        university_name = self.request.query_params.get('university_name', None)
        university_faculty = self.request.query_params.get('university_faculty', None)

        queryset = BoardingHouse.objects.all()

        if university_name and university_faculty:
            queryset = queryset.filter(university_name=university_name, university_faculty=university_faculty)
        elif university_name:
            queryset = queryset.filter(university_name=university_name)
        elif university_faculty:
            queryset = queryset.filter(university_faculty=university_faculty)

        return queryset

    def perform_create(self, serializer):
        # Set the owner of the boarding to the logged-in user
        serializer.save(owner=self.request.user)
       
class BoardingHouseImages(generics.ListAPIView):
    serializer_class = ImageSerializer

    def get_queryset(self):
        boarding_house_id = self.kwargs['pk']
        return Image.objects.filter(boarding_house_id=boarding_house_id)
    
class BoardingHouseDetailView(generics.RetrieveAPIView):
    serializer_class = BoardingHouseSerializer

    def get_object(self):
        # Retrieve the parameters from the URL (assuming they are part of the URL pattern)
        university_name = self.kwargs['university_name']
        university_faculty = self.kwargs['university_faculty']

        # Use the filter method to get the BoardingHouse based on university_name and university_faculty
        queryset = BoardingHouse.objects.filter(
            university_name=university_name,
            university_faculty=university_faculty
        )

        # If the object is not found, raise a 404 error
        obj = get_object_or_404(queryset)
        
        return obj