# Custom Minecraft 1.21.4 Fabric

Это проект своей отдельной версии Minecraft 1.21.4 для FCL/Android.

Репозиторий **не содержит код, JAR или ресурсы Minecraft от Mojang/Microsoft**.
GitHub собирает только наш runtime-слой изменений. Установщик на устройстве берет уже установленный у пользователя профиль Fabric 1.21.4, локально копирует его в отдельную версию и подключает наш runtime.

## Что получится в FCL

```
.minecraft/versions/Custom-Minecraft-1.21.4-Fabric/
```

В лаунчере это отдельная версия. Ее код изменений хранится в этом репозитории и может менять клиент через Fabric/Mixin.

## Автосборка GitHub

Каждый push в `main` запускает GitHub Actions. Artifact называется:

```
Custom-Minecraft-1.21.4-Fabric
```

Внутри artifact:

```
install-fcl.sh
custom-minecraft-runtime.jar
README-INSTALL.txt
```

## Установка на Android/FCL

Распаковать artifact, перейти в его папку в Termux и выполнить:

```bash
bash install-fcl.sh
```

По умолчанию исходный профиль:

```
/storage/emulated/0/FCL/.minecraft/versions/1.21.4-Fabric
```

Новая версия:

```
/storage/emulated/0/FCL/.minecraft/versions/Custom-Minecraft-1.21.4-Fabric
```

Если исходный профиль называется иначе:

```bash
SOURCE_VERSION="имя-папки-Fabric" bash install-fcl.sh
```

## Где менять игру

Наш Java-код:

```
src/client/java/dev/knight/customminecraft/
```

Mixin-конфигурация:

```
src/main/resources/customminecraft.client.mixins.json
```

Декомпилированные исходники Minecraft можно держать локально как справочник, но они не коммитятся в этот репозиторий.
