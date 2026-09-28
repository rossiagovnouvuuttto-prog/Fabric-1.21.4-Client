CUSTOM MINECRAFT 1.21.4 FABRIC — FCL / ANDROID

Это не архив Minecraft от Mojang/Microsoft.
В комплекте только наш runtime и локальный установщик.

ТРЕБОВАНИЕ
В FCL уже должна быть установлена рабочая версия Fabric для Minecraft 1.21.4.

ОБЫЧНАЯ УСТАНОВКА

1. Распакуй GitHub Actions artifact.
2. Открой Termux.
3. Перейди в распакованную папку.
4. Выполни:

bash install-fcl.sh

По умолчанию установщик ищет:
 /storage/emulated/0/FCL/.minecraft/versions/1.21.4-Fabric

И создаёт:
 /storage/emulated/0/FCL/.minecraft/versions/Custom-Minecraft-1.21.4-Fabric

После установки перезапусти FCL и обнови список версий.

ЕСЛИ ПАПКА FABRIC НАЗЫВАЕТСЯ ИНАЧЕ

SOURCE_VERSION="имя-папки" bash install-fcl.sh

ЕСЛИ FCL ЛЕЖИТ В ДРУГОМ МЕСТЕ

FCL_ROOT="/путь/к/.minecraft" bash install-fcl.sh

КАК ЭТО УСТРОЕНО

Установщик локально копирует уже установленный у тебя профиль Fabric 1.21.4,
даёт копии отдельное имя и помещает наш runtime в её изолированную папку mods.

GitHub не получает и не публикует minecraft.jar, ресурсы или исходный код Mojang.
