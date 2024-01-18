
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path , include
from authentication.views import OwnerRegistrationView, TenantRegistrationView, UserRegistrationView, UserLoginView, UserLogoutView, UserProfileImageUpdateView, UserUpdateView
from owner import urls as owner_urls
from tenant import urls as tenant_urls
from boarding.views import BoardingHouseListCreateView, BoardingHouseImages
from tenant.views import TenantSaveRemoveBoardingView
urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/auth/register/',UserRegistrationView.as_view(),name = 'user-registration'),
    path('api/auth/login/', UserLoginView.as_view(), name='user-login'),
    path('api/auth/logout/', UserLogoutView.as_view(), name='user-logout'),
    path('api/auth/register/tenant/', TenantRegistrationView.as_view(), name='tenant-registration'),
    path('api/auth/register/owner/', OwnerRegistrationView.as_view(), name='owner-registration'),
    # Include owner app URLs
    path('api/owner/', include(owner_urls)),

    # Include tenant app URLs
    path('api/tenant/', include(tenant_urls)),

    path('api/tenant/save-remove-boarding/',TenantSaveRemoveBoardingView.as_view(),name='tenant-save-remove-boarding'),

    # view all boardings
    path('api/boardings/',BoardingHouseListCreateView.as_view(),name='all-boarding'),
    # view images
    path('api/boardings/<int:pk>/images',BoardingHouseImages.as_view(),name='boarding-images'),

    # Search by university_name or university_faculty
    path('api/boardings/search/', BoardingHouseListCreateView.as_view(), name='search-boarding'),

    #update profile photo
    path('api/user/update-profile-image/', UserProfileImageUpdateView.as_view(), name='update-profile-image'),

    #update user date
    path('api/user/update-user/',UserUpdateView.as_view(), name='update-user')


]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL,document_root = settings.MEDIA_ROOT)
