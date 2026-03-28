from django.urls import path
from .views import  chat_page, chatbot_response

app_name='chatbot'

urlpatterns = [
    path("chatpage/", chat_page, name="chat_page"),
    path('chatbot/',chatbot_response, name='chatbot_response'),
    # path("whatsapp/", whatsapp_bot, name="whatsapp_bot"),
    # path("get-response/", get_bot_response, name="get_bot_response"),
]
