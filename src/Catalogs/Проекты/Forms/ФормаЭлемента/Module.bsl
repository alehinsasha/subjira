
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	РМ_MarkdownСервер.ВставитьПолеРедактированияТекстаНаФорму(ЭтотОбъект, Элементы.ГруппаПредставлениеОписания,
		"ПредставлениеОписания", "ones", Истина);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ДанныеОписания = ОбщегоНазначенияВызовСервера.ДанныеОписания(Объект.Ссылка);
	Описание = ДанныеОписания.Ссылка;
	ПредставлениеОписания = ДанныеОписания.Текст;
	
КонецПроцедуры

&НаКлиенте
Процедура СсылкаНаСистемуУчетаЗадачОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Оповещение = Новый ОписаниеОповещения("ПослеОткрытияСистемыУчетаЗадач", ЭтотОбъект);
	НачатьЗапускПриложения(Оповещение, Объект.СсылкаНаСистемуУчетаЗадач);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеОткрытияСистемыУчетаЗадач(КодВозврата, ДополнительныеПараметры) Экспорт
	
	Если КодВозврата = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПодключитьОбработчикОжидания("ОбновитьПредставлениеОписания", 0.1, Истина);
	
КонецПроцедуры


&НаКлиенте
Процедура ОбновитьПредставлениеОписания() Экспорт
	
	РМ_MarkdownКлиент.ПриСменеСтраницыПоляКомментария(ЭтотОбъект, Элементы.РМ_Страницы_ПредставлениеОписания, Элементы.РМ_Страница_Просмотр_ПредставлениеОписания);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьОписание(Команда)
	
	ЭтоНовый = Объект.Ссылка.Пустая();
	Если ЭтоНовый Тогда
		ПоказатьПредупреждение(, "Это новый элемент, нужно его записать, чтобы изменить его описание.");
		
		Возврат;
	КонецЕсли;
	
	ПараметрыИзмененияОписания = ОбщегоНазначенияКлиент.НовыеПараметрыИзмененияОписания();
	ПараметрыИзмененияОписания.ОбъектОписания = Объект.Ссылка;
	ПараметрыИзмененияОписания.Описание = Описание;
	ПараметрыИзмененияОписания.ФормаВладелец = ЭтотОбъект;
	ПараметрыИзмененияОписания.ОповещениеОбИзменении = Новый ОписаниеОповещения("ПослеИзмененияВыбораОписание", ЭтотОбъект);
	
	ОбщегоНазначенияКлиент.ИзменитьОписание(ПараметрыИзмененияОписания);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьОписание(Команда)
	
	ЭтоНовый = Объект.Ссылка.Пустая();
	Если ЭтоНовый Тогда
		ПоказатьПредупреждение(, "Это новый элемент, нужно его записать, чтобы изменить его описание.");
		
		Возврат;
	КонецЕсли;
	
	ПараметрыВыбораОписания = ОбщегоНазначенияКлиент.НовыеПараметрыВыбораОписания();
	ПараметрыВыбораОписания.ОбъектОписания = Объект.Ссылка;
	ПараметрыВыбораОписания.ФормаВладелец = ЭтотОбъект;
	ПараметрыВыбораОписания.ОповещениеОВыборе = Новый ОписаниеОповещения("ПослеИзмененияВыбораОписание", ЭтотОбъект);

	ОбщегоНазначенияКлиент.ВыбратьОписание(ПараметрыВыбораОписания);
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьОписание(Команда)
	
	ЭтоНовый = Объект.Ссылка.Пустая();
	Если ЭтоНовый Тогда
		ПоказатьПредупреждение(, "Это новый элемент, нужно его записать, чтобы изменить его описание.");
		
		Возврат;
	КонецЕсли;

	ОбщегоНазначенияВызовСервера.УдалитьОписание(Объект.Ссылка);
	ПредставлениеОписания = ОбщегоНазначенияВызовСервера.ДанныеОписания(Объект.Ссылка).Текст;
	ОбновитьПредставлениеОписания();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеИзмененияВыбораОписание(Результат, ДополнительныеПараметры) Экспорт
	
	ПредставлениеОписания = ОбщегоНазначенияВызовСервера.ДанныеОписания(Объект.Ссылка).Текст;
	ОбновитьПредставлениеОписания();
	
КонецПроцедуры

