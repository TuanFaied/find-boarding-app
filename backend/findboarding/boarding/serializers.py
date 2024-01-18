from rest_framework import serializers
from .models import BoardingHouse ,Image

class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Image
        fields = '__all__'

class BoardingHouseSerializer(serializers.ModelSerializer):
    owner = serializers.StringRelatedField()
    images = ImageSerializer(many=True,read_only=True)
    class Meta:
        model = BoardingHouse
        fields = '__all__'

    
        