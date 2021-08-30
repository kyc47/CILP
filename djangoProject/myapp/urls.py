# from django.urls import path
# from myapp import views
#
# urlpatterns = [
#     path('snippets/', views.snippet_list),
#     path('snippets/<int:pk>/', views.snippet_detail),
# ]


from django.conf.urls import url
from .views import UserViewSet, GetDataViewSet, LoginAPI, GetScreenViewSet
from django.urls import path, include

api_list = UserViewSet.as_view({"post": "create"})
api_list1 = GetScreenViewSet.as_view({'post': 'create'})
post_list = GetDataViewSet.as_view({
    'post': 'create',
})

urlpatterns = [
    url("^user/$", api_list),
    url("^screen/$", api_list1),
    # path('mouse/', post_list),
    path('sign/', LoginAPI.as_view()),

    # url("^sign/")
    # url("^user/(?P<pk>[0-9]+)/$", user_detail),
]
