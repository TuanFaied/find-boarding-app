from rest_framework import serializers
from authentication.models import User
from authentication.serializers import UserSerializer
from owner.models import Owner

class OwnerSerializer(serializers.ModelSerializer):
    user = UserSerializer()

    class Meta:
        model = Owner
        fields = '__all__'
    
    def create(self, validated_data):
        user_data = validated_data.pop('user')
        user = User.objects.create_user(**user_data)
        owner = Owner.objects.create(user=user,**validated_data)

        return owner