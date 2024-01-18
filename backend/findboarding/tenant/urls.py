from django.urls import path
from .views import TenantSaveRemoveBoardingView,TenantSavedBoardingsView

urlpatterns = [
    path('save-remove-boarding/<int:pk>/', TenantSaveRemoveBoardingView.as_view(), name='tenant-save-remove-boarding'),
    path('saved-boardings/', TenantSavedBoardingsView.as_view(), name='tenant-saved-boardings'),
]