from rest_framework import serializers
from authentication.models import User
from authentication.serializers import UserSerializer
from boarding.serializers import BoardingHouseSerializer
from tenant.models import Tenant


class TenantSerializer(serializers.ModelSerializer):
    user = UserSerializer(required=False)
    saved_boardings = BoardingHouseSerializer(many=True, read_only=True)
    
    class Meta:
        model = Tenant
        fields = '__all__'
    
    def create(self, validated_data):
        user_data = validated_data.pop('user')
        user = User.objects.create_user(**user_data)
        tenant = Tenant.objects.create(user=user,**validated_data)

        return tenant
    
# class TenantSaveBoardingSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Tenant
#         fields = ['saved_boardings']

class SavedBoardingsSerializer(serializers.ModelSerializer):
    saved_boardings = BoardingHouseSerializer(many=True, read_only=True)

    class Meta:
        model = Tenant
        fields = '__all__'