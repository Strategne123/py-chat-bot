import vk_api
from vk_api.longpoll import VkLongPoll, VkEventType
import random
from time import gmtime, strftime
import wikipedia

def write_msg(user_id, random_id,message):
    vk.method('messages.send', {'user_id': user_id, 'random_id':random_id,'message': message})

wikipedia.set_lang("RU")
# API-ключ созданный ранее !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Ниже введите свой токен
token = ""
# Авторизуемся как сообщество
vk = vk_api.VkApi(token=token)
# Работа с сообщениями
longpoll = VkLongPoll(vk)

# Основной цикл
for event in longpoll.listen():
    # Если пришло новое сообщение
    if event.type == VkEventType.MESSAGE_NEW:
        # Если оно имеет метку для меня( то есть бота)
        if event.to_me:
            # Сообщение от пользователя
            request = event.text
            if request == "привет" or request == "Привет":
                write_msg(event.user_id,event.random_id, "Привет!")
            elif request == "пока" or request == "Пока":
                write_msg(event.user_id,event.random_id, "Пока((")
            elif "правда" in request.lower():
                s = ["да","нет"]
                meesage = random.choice(s)
                write_msg(event.user_id,event.random_id, meesage)
            elif request == "время":
                write_msg(event.user_id, event.random_id, str(strftime("%Y-%m-%d %H:%M:%S", gmtime())))
            elif event.text == 'Википедия' or event.text == 'Вики' or event.text == 'википедия' or event.text == 'вики' or event.text == 'Wikipedia' or event.text == 'wikipedia' or event.text == 'Wiki' or event.text == 'wiki':  # если нам пришло сообщение с текстом Википедия или Вики или ... или wiki
                if event.from_user:  # Если написали в KC
                    write_msg(event.user_id, event.random_id, "Запрос!")
            else:
                write_msg(event.user_id,event.random_id, "Не поняла вашего ответа...")
