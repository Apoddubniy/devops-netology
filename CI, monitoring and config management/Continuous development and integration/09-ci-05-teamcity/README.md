## Ответ на домашнее задание к 09-05 «Teamcity»  


1. Создайте новый проект в teamcity на основе fork.
![Skrin](files/01-01.jpg)
2. Сделайте autodetect конфигурации.
![Skrin](files/02-01.jpg)
3. Сохраните необходимые шаги, запустите первую сборку master.
![Skrin](files/03-01.jpg)
4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`.
5. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.
6. В pom.xml необходимо поменять ссылки на репозиторий и nexus.
7. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.
![Skrin](files/07-01.jpg)
8. Мигрируйте `build configuration` в репозиторий.  
#### [Ссылка на папку](TeamCity_ExampleTeamcity)
9. Создайте отдельную ветку `feature/add_reply` в репозитории.
10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.
11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.
12. Сделайте push всех изменений в новую ветку репозитория.
13. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.
![Skrin](files/13-01.jpg)
14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.  
`Вот тут как всегда запутался, прыгая с ветки на ветку. Есть лишние комиты, но результат почти правильный.`   
15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.
16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.
![Skrin](files/16-01.jpg)
17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.
![Skrin](files/17-01.jpg)
18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.
#### [Ссылка на папку 2](TeamCity_ExampleTeamcity2)
19. В ответе пришлите ссылку на репозиторий.
#### [Ссылка на репозиторий](https://github.com/Apoddubniy/example-teamcity.git)