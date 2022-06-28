
&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ОтобразитьОписаниеЗадачи", 0.5, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтобразитьОписаниеЗадачи() Экспорт
	
	ДанныеСтроки = Элементы.Список.ДанныеСтроки(Элементы.Список.ТекущаяСтрока);
	Если ДанныеСтроки = Неопределено Тогда
		ВызватьИсключение "Странно";
	КонецЕсли;

	ОписаниеЗадачи = ОписаниеЗадачи(ДанныеСтроки.Описание);
	РМ_MarkdownКлиент.ПриСменеСтраницыПоляКомментария(ЭтаФорма, Элементы.РМ_Страницы_ОписаниеЗадачи,  Элементы.РМ_Страница_Просмотр_ОписаниеЗадачи);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОписаниеЗадачи(Указатель)
	
	Результат = "";
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОписанияВХранилищах.Хранилище
	|ИЗ
	|	РегистрСведений.ОписанияВХранилищах КАК ОписанияВХранилищах
	|ГДЕ
	|	ОписанияВХранилищах.Описание = &Описание";
	
	Запрос.УстановитьПараметр("Описание", Указатель);
	
	ВыборкаДетальныеЗаписи = Запрос.Выполнить().Выбрать();
	Если ВыборкаДетальныеЗаписи.Следующий() Тогда
		Описание = ВыборкаДетальныеЗаписи.Хранилище.Получить();
		Если ЗначениеЗаполнено(Описание) Тогда
			Результат = Описание;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ПараметрыПоляРедактированияОписания = РМ_MarkdownСервер.НовыеПараметрыПоляРедактированияОписания();
	ПараметрыПоляРедактированияОписания.Форма = ЭтотОбъект;
	ПараметрыПоляРедактированияОписания.ГруппаЭлементовТекста = Элементы.ОписаниеЗадачи;
	ПараметрыПоляРедактированияОписания.ПутьКДанным = "ОписаниеЗадачи";
	ПараметрыПоляРедактированияОписания.ПереходВРедактированиеИзПросмотра = Истина;
	РМ_MarkdownСервер.ВставитьПолеРедактированияТекстаНаФорму(ПараметрыПоляРедактированияОписания);

КонецПроцедуры

//@skip-check module-unused-method
&НаКлиенте
Процедура РМ_Подключаемый_ОбработкаКомандыПоляКомментария(Команда)
	
	ДанныеСтроки = Элементы.Список.ДанныеСтроки(Элементы.Список.ТекущаяСтрока);
	Если ДанныеСтроки = Неопределено Тогда
		ВызватьИсключение "Странно";
	КонецЕсли;

	Если Команда.Имя = "РМ_ЗакончитьРедактирование_ОписаниеЗадачи" Тогда
		СохранитьОписание(ДанныеСтроки.Ссылка, ОписаниеЗадачи);
		Элементы.РМ_Страницы_ОписаниеЗадачи.ТекущаяСтраница = Элементы.РМ_Страница_Просмотр_ОписаниеЗадачи;
		РМ_MarkdownКлиент.ПриСменеСтраницыПоляКомментария(ЭтаФорма, Элементы.РМ_Страницы_ОписаниеЗадачи,  Элементы.РМ_Страница_Просмотр_ОписаниеЗадачи);
		
		Элементы.Список.Обновить();
	ИначеЕсли Команда.Имя = "РМ_НачатьРедактирование_ОписаниеЗадачи" Тогда
		// Изменить
		Элементы.РМ_Страницы_ОписаниеЗадачи.ТекущаяСтраница = Элементы.РМ_Страница_Редактирование_ОписаниеЗадачи;
		РМ_MarkdownКлиент.ПриСменеСтраницыПоляКомментария(ЭтаФорма, Элементы.РМ_Страницы_ОписаниеЗадачи, Элементы.РМ_Страница_Редактирование_ОписаниеЗадачи);
	Иначе
		РМ_MarkdownКлиент.ОбработкаКомандыПоляКомментария(ЭтаФорма, Команда);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СохранитьОписание(Задача, ОписаниеЗадачи)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ОписанияПоОбъектам.Описание
	|ИЗ
	|	РегистрСведений.ОписанияПоОбъектам КАК ОписанияПоОбъектам
	|ГДЕ
	|	ОписанияПоОбъектам.Объект = &Объект";
	
	Запрос.УстановитьПараметр("Объект", Задача);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		ИдентификаторЗадачи = Строка(Задача.УникальныйИдентификатор());
		
		ИскомоеОписание = Справочники.Описания.НайтиПоНаименованию(ИдентификаторЗадачи);
		Если ЗначениеЗаполнено(ИскомоеОписание) Тогда
			Описание = ИскомоеОписание;
		Иначе
			НовоеОписание = Справочники.Описания.СоздатьЭлемент();
			НовоеОписание.УстановитьНовыйКод();
			НовоеОписание.Наименование = ИдентификаторЗадачи;
			НовоеОписание.Записать();
			
			Описание = НовоеОписание.Ссылка;
		КонецЕсли;
		
		МенеджерЗаписи = РегистрыСведений.ОписанияПоОбъектам.СоздатьМенеджерЗаписи();
		МенеджерЗаписи.Описание = Описание;
		МенеджерЗаписи.Объект = Задача;
		МенеджерЗаписи.Записать();
	Иначе
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		ВыборкаДетальныеЗаписи.Следующий();

		Описание = ВыборкаДетальныеЗаписи.Описание;
	КонецЕсли;
	
	МенеджерЗаписи = РегистрыСведений.ОписанияВХранилищах.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Описание = Описание;
	МенеджерЗаписи.Хранилище = Новый ХранилищеЗначения(ОписаниеЗадачи, Новый СжатиеДанных(9));
	МенеджерЗаписи.Записать();
	
КонецПроцедуры

//@skip-check module-unused-method
&НаКлиенте
Процедура РМ_Подключаемый_ПриНажатииПоляПросмотраКомментария(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	РМ_MarkdownКлиент.ПриНажатииПоляПросмотраКомментария(ЭтаФорма, Элемент, ДанныеСобытия, СтандартнаяОбработка);
КонецПроцедуры

