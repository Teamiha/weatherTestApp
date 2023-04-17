# WeatherApp
A project based on https://openweathermap.org
A weather application.
The user selects the city of interest and gets the current temperature.

## Implementation
- MVP with code interface layout.
- Adherence to SOLID principles and protocol-oriented.
- From openweather on request comes JSON, from which the data is taken. (URLSession)
- The data are also cached, and in case of a lack of internet, the last saved values will be shown. (CoreData)
- The list of cities is created based on tableView. (TableView)
- Also in the application has the ability to filter the list of cities, through the search bar.

------------------------------------

Проект на основе https://openweathermap.org
Приложение для узнавания погоды.
Пользователь выбирает интересующий его город, и получает текущую температуру.

## Реализация 
- MVP с вёрсткой интерфейса кодом. 
- Соблюдение принципов SOLID и протоколо-ориентированность.
- От openweather по запросу приходит JSON, из которого достаются данные. (URLSession)
- Данные также кешируются, и в случае отсутствия интернета, будут показаны последние сохранённые значения. (CoreData)
- Список городов создан на основе tableView. (TableView)
- Так же в приложении есть возможность фильтрации списка городов, через строку поиска. 
