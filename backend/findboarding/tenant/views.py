from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from .models import Tenant
from .serializers import TenantSerializer ,SavedBoardingsSerializer
from rest_framework.response import Response
from rest_framework import status

class TenantSaveRemoveBoardingView(generics.UpdateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = TenantSerializer
    def get_queryset(self):
        return Tenant.objects.filter(user=self.request.user)

    def perform_update(self, serializer):
        # Associate the authenticated user with the update
        serializer.instance.user = self.request.user
        # Get the list of currently saved boardings for the tenant
        current_saved_boardings = set(serializer.instance.saved_boardings.all())

        # Get the list of boardings sent in the request data
        requested_boardings = set(self.request.data.get('saved_boardings', []))

        # Determine the boardings to add and remove
        boardings_to_add = requested_boardings - current_saved_boardings
        boardings_to_remove = current_saved_boardings - requested_boardings

        # Add new boardings to the tenant's saved boardings
        for boarding_to_add in boardings_to_add:
            serializer.instance.saved_boardings.add(boarding_to_add)

        # Remove boardings that are no longer in the requested list
        for boarding_to_remove in boardings_to_remove:
            serializer.instance.saved_boardings.remove(boarding_to_remove)


        serializer.save()
        return Response({'message': 'Boarding saved successfully.'}, status=status.HTTP_200_OK)
    
class TenantSavedBoardingsView(generics.RetrieveAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = SavedBoardingsSerializer

    def get_object(self):
        return Tenant.objects.get(user=self.request.user)