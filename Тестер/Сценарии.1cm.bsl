﻿// Метод возвращает массив сценариев.
// Метод возвращает только незахваченные сценарии.
// Метод возвращает только сценарии, тип которых = Сценарий. Методы, папки и библиотеки пропускаются.
// В качестве примера использования может служить сценарий автоматического запуска всех помещенных
// в репозиторий тестов.
//
// Параметры:
// Имя: Наименование приложения. Пример: "ERP2"
// Исключения: Массив строк-путей к исключаемым из списка сценариям
//
// Возврат:
// Массив ссылок на справочник тестов

возврат получить ( _.Имя, _.Исключения );

&НаСервере
Функция получить ( Приложение, Исключения )

	с = "
	|выбрать разрешенные Сценарии.Ссылка как Сценарий
	|из Справочник.Scenarios как Сценарии
	|где не Сценарии.ПометкаУдаления
	|и Сценарии.Type = значение ( Enum.Scenarios.Scenario )
	|и Сценарии.Application.Description = &Приложение
	|и Сценарии.Path не в ( &Исключения )
	|и Сценарии.Path не подобно ""Корзина%""
	|упорядочить по Сценарии.Path + Сценарии.Наименование
	|";
	з = новый Запрос ( с );
	з.УстановитьПараметр ( "Приложение", Приложение );
	з.УстановитьПараметр ( "Исключения", Исключения );
	возврат з.Выполнить ().Выгрузить ().ВыгрузитьКолонку ( "Сценарий" );

КонецФункции