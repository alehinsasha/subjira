
Функция ВСекунды(Часов, Минут) Экспорт
	
	Результат = Часов * 60 * 60;
	Результат = Результат + Минут * 60;
	
	Возврат Результат;
	
КонецФункции

Функция ИзСекунд(Секунды) Экспорт
	
	Результат = Новый Структура("Часов,Минут", 0, 0);
	Если Секунды > 0 Тогда
		Результат.Часов = Цел(Секунды / 3600);
		Результат.Минут = Цел((Секунды - Результат.Часов * 3600) / 60);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПредставлениеТрудозатрат(Знач Секунды = 0, Знач Часов = 0, Знач Минут = 0) Экспорт
	
	Результат = "0h";
	
	Если Часов = 0 И Минут = 0 И Секунды > 0 Тогда
		ИзСекунд = ИзСекунд(Секунды);
		Часов = ИзСекунд.Часов;
		Минут = ИзСекунд.Минут;
	КонецЕсли;
	
	Если Часов > 0 И Минут > 0 Тогда
		Результат = СтрШаблон("%1h %2m", Часов, Прав("00" + Минут, 2));
	ИначеЕсли Часов > 0 Тогда
		Результат = СтрШаблон("%1h", Часов);
	ИначеЕсли Минут > 0 Тогда
		Результат = СтрШаблон("%1m", Прав("00" + Минут, 2));
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПредставлениеТрудозатратСКД(Секунды) Экспорт
	
	Результат = 0;
	
	Если ТипЗнч(Секунды) = Тип("Число") Тогда
		Результат = ПредставлениеТрудозатрат(Секунды);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ТолькоЦифры(Знач Код) Экспорт
	
	Результат = "";
	УбираемЛидирующиеНули = Истина;
	
	Код = СокрЛП(Код);
	Пока Не ПустаяСтрока(Код) Цикл
		ТекущийСимвол = Лев(Код, 1);
		Код = Сред(Код, 2);
		Если СтрНайти("0123456789", ТекущийСимвол) Тогда
			Если УбираемЛидирующиеНули Тогда
				Если ТекущийСимвол = "0" Тогда
					Продолжить;
				Иначе
					УбираемЛидирующиеНули = Ложь;
				КонецЕсли;
			КонецЕсли;
			
			Результат = СтрШаблон("%1%2", Результат, ТекущийСимвол);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ОкруглитьМинутыВДате(Дата) Экспорт
	
	Год = Год(Дата);
	Месяц = Месяц(Дата);
	День = День(Дата);
	Час = Час(Дата);
	Минута = Округлить(Минута(Дата), 5);
	
	Результат = Дата(Год, Месяц, День, Час, Минута, 0);
	Возврат Результат;
	
КонецФункции

Функция Округлить(Число, Точность = 0) Экспорт
	
	Если Не ЗначениеЗаполнено(Число) 
		Или Точность <= 0 Тогда
		Возврат Число
	КонецЕсли;
	
	Множитель  		= Число / Точность;
	ЦелыйМножитель 	= Цел(Множитель);
	
	Если Множитель = ЦелыйМножитель Тогда
		Результат = Число;
	Иначе
		Результат = Точность * Окр(Множитель);
		
		Если Результат < 55 Тогда
			Результат = Точность * (ЦелыйМножитель + 1);
		ИначеЕсли Результат > 55 Тогда
			Результат = 0;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПредставлениеЗамера(Замер) Экспорт
	
	Возврат ОбщегоНазначенияВызовСервера.ПредставлениеЗамера(Замер);
	
КонецФункции
