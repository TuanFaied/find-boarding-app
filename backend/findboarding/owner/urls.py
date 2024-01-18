from django.urls import path
from .views import BoardingHouseListCreateView, BoardingHouseUpdateDeleteView

urlpatterns = [
    path('boarding-houses/', BoardingHouseListCreateView.as_view(), name='owner-boarding-houses-list-create'),
    path('boarding-houses/<int:pk>/', BoardingHouseUpdateDeleteView.as_view(), name='owner-boarding-houses-update-delete'),
]