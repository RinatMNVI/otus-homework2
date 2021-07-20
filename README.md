### Задание №2

Последовательность запуска:
1. helm install postgres bitnami/postgresql -f ./userservice-chart/pg-values.yml
2. helm install userservice ./userservice-chart

Миграция происходит в момент запуска из самого приложения (использован liquibase)

В случае если приложение не стартануло и в логах видно сообщение `Waiting for changelog lock...`
, то нужно зайти на поду postgres и удалить из бд users все таблицы и перезапустить приложение.

[Коллекция postman](./OtusHomework2.postman_collection.json)