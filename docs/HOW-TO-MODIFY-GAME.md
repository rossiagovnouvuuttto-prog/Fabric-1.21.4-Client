# Как менять свою версию игры

Исходники Minecraft 1.21.4, которые были декомпилированы локально, используются как справочник.

Изменения игры пишутся в:

```
src/client/java/dev/knight/customminecraft/
```

Для изменения существующих классов Minecraft используется Mixin. Конфигурация уже подключена:

```
src/main/resources/customminecraft.client.mixins.json
```

Новый mixin нужно добавить в пакет:

```
dev.knight.customminecraft.mixin
```

и вписать его имя в массив `client` файла `customminecraft.client.mixins.json`.

После push в `main` GitHub Actions собирает новый artifact. Его можно поставить поверх предыдущей кастомной версии командой:

```bash
bash install-fcl.sh
```

Перед заменой установщик автоматически делает резервную копию предыдущей кастомной версии.
