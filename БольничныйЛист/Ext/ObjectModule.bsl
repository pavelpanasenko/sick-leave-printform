﻿Функция ЧислоВДенежнойФорме(ЧислоВСтроку)
	СтрокаРубли = НСтр("ru = 'руб.'");
	СтрокаКопейки = НСтр("ru = 'коп.'");
	ЦелаяЧасть = Цел(ЧислоВСтроку);
	ДробнаяЧасть = 100 * (ЧислоВСтроку - ЦелаяЧасть); 
	Возврат "" + ЦелаяЧасть + " " + СтрокаРубли + " " + ДробнаяЧасть + " " + СтрокаКопейки;
КонецФункции


Функция ПодписьГод(Параметр)
	Возврат ПерсонифицированныйУчет.ФормаМножественногоЧисла(НСтр("ru = 'год'"), НСтр("ru = 'года'"), НСтр("ru = 'лет'"), Параметр);
КонецФункции	


Функция ПодписьМесяц(Параметр)
	Возврат ПерсонифицированныйУчет.ФормаМножественногоЧисла(НСтр("ru = 'месяц'"), НСтр("ru = 'месяца'"), НСтр("ru = 'месяцев'"), Параметр);
КонецФункции	


Функция СформироватьПечатнуюФорму(СсылкаНаОбъект, ОбъектыПечати) Экспорт

	ТабДокумент = Новый ТабличныйДокумент;
	ТабДокумент.ИмяПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_БольничныйЛист";
	ТабДокумент.АвтоМасштаб = Истина;
	ТабДокумент.ОриентацияСтраницы = ОриентацияСтраницы.Портрет;
	
	Макет = ПолучитьМакет("Макет");
	
	ОбластьБЛ = Макет.ПолучитьОбласть("Область_БЛ");
	
	Ключи = "пНомерЛН,ПЭтоПервичный,пЭтоДубликат,пНомерПредыдущегоЛН,
			|пНаимЛечебнойОрганизации,пАдресЛечебнойОрганизации,пДатаВыдачи,
			|пОГРН,пФамилия,пИмя,пОтчество,пДатаРождения,пПол,
			|пКодНетр,пДопКод,пКодИзм,пМестоРаботы,пОсновное,пСовм,пСостоитВСлужбеЗанятости,
			|пДата1,пДата2,пНомерПутевки,пОГРНСанатория,
			|пВозрастРодственника1,пВозрастРодственникаЛет1,пВозрастРодственникаМес1,
			|пРодственнаяСвязь1,пФИОРодственника1,
			|пВозрастРодственника2,пВозрастРодственникаЛет2,пВозрастРодственникаМес2,
			|пРодственнаяСвязь2,пФИОРодственника2,
			|пРанниеСрокиДа,пРанниеСрокиНет,
			|пНарушениеРежима,пДатаНарушенияРежима,пСтационарС,пСтационарПо,
			|пДатаНаправленияВМСЭ,пДатаРегистрацииВМСЭ,пДатаОсвидетельствованияВМСЭ,пУстановленаИнвалидность,
			|пБолелС1,пБолелПо1,пДолжностьВрача1,пФИОВрача1,пДолжностьПредВК1,пФИОПредВК1,
			|пБолелС2,пБолелПо2,пДолжностьВрача2,пФИОВрача2,пДолжностьПредВК2,пФИОПредВК2,
			|пБолелС2,пБолелПо3,пДолжностьВрача3,пФИОВрача3,пДолжностьПредВК3,пФИОПредВК3,			
			|пПриступитьКРаботе,пИное,пИноеДата,пНомерПродолженияЛН,
			|пРегистрационныйНомер,пКодПодчиненности,пИНН,пСНИЛС,
			|пУсловияИсчисления,пУсловияИсчисления1,пУсловияИсчисления2,пУсловияИсчисления3,пАктН1,
			|СтажЛет,СтажМесяцев,СтажРасширенныйЛет,СтажРасширенныйМесяцев,пСтраховойСтаж,пНестраховыеПериоды,
			|пПособиеС,пПособиеПо,пСреднийЗаработок,пСреднеДневнойЗаработок,
			|пСуммаПособияЗаСчетРаб,пСуммаПособияЗаСчетСредствФСС,
			|пФИОРуководителя,пФИОГлБух";
	
	
	СтруктураПараметров = Новый Структура(Ключи);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	БольничныйЛист.НомерЛисткаНетрудоспособности КАК пНомерЛН,
		|	БольничныйЛист.НаименованиеМедицинскойОрганизации КАК пНаимЛечебнойОрганизации,
		|	БольничныйЛист.АдресМедицинскойОрганизации КАК пАдресЛечебнойОрганизации,
		|	БольничныйЛист.ДатаВыдачиЛисткаНетрудоспособности КАК пДатаВыдачи,
		|	БольничныйЛист.ОГРНМедицинскойОрганизации КАК пОГРН,
		|	ФизическиеЛица.Фамилия КАК пФамилия,
		|	ФизическиеЛица.Имя КАК пИмя,
		|	ФизическиеЛица.Отчество КАК пОтчество,
		|	ФизическиеЛица.ДатаРождения КАК пДатаРождения,
		|	ФизическиеЛица.ИНН КАК пИНН,
		|	ФизическиеЛица.СтраховойНомерПФР КАК пСНИЛС,
		|	ВЫБОР
		|		КОГДА ФизическиеЛица.Пол = ЗНАЧЕНИЕ(Перечисление.ПолФизическогоЛица.Мужской)
		|			ТОГДА ""М""
		|		ИНАЧЕ ""Ж""
		|	КОНЕЦ КАК пПол,
		|	БольничныйЛист.КодПричиныНетрудоспособности КАК пКодНетр,
		|	БольничныйЛист.ДополнительныйКодПричиныНетрудоспособности КАК пДопКод,
		|	БольничныйЛист.ВторойКодПричиныНетрудоспособности КАК пКодИзм,
		|	БольничныйЛист.Организация.Наименование КАК пМестоРаботы,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ОсновноеМестоРаботы
		|			ТОГДА ""V""
		|		ИНАЧЕ """"
		|	КОНЕЦ КАК пОсновное,
		|	ВЫБОР
		|		КОГДА НЕ БольничныйЛист.ОсновноеМестоРаботы
		|			ТОГДА ""V""
		|		ИНАЧЕ """"
		|	КОНЕЦ КАК пСовм,
		|	БольничныйЛист.ДатаОкончанияПутевки КАК пДата2,
		|	БольничныйЛист.НомерПутевки КАК пНомерПутевки,
		|	БольничныйЛист.ОГРН_Санатория КАК пОГРНСанатория,
		|	БольничныйЛист.НомерПервичногоЛисткаНетрудоспособности КАК пНомерПредыдущегоЛН,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ПредоставленДубликатЛисткаНетрудоспособности
		|			ТОГДА ""V""
		|		ИНАЧЕ """"
		|	КОНЕЦ КАК пЭтоДубликат,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.НомерПервичногоЛисткаНетрудоспособности = """"
		|			ТОГДА ""V""
		|		ИНАЧЕ """"
		|	КОНЕЦ КАК ПЭтоПервичный,
		|	БольничныйЛист.ПоУходуВозрастЛет1 КАК пВозрастРодственникаЛет1,
		|	БольничныйЛист.ПоУходуВозрастЛет2 КАК пВозрастРодственникаЛет2,
		|	БольничныйЛист.ПоУходуВозрастМесяцев1 КАК пВозрастРодственникаМес1,
		|	БольничныйЛист.ПоУходуВозрастМесяцев2 КАК пВозрастРодственникаМес2,
		|	БольничныйЛист.ПоУходуРодственнаяСвязь1 КАК пРодственнаяСвязь1,
		|	БольничныйЛист.ПоУходуРодственнаяСвязь2 КАК пРодственнаяСвязь2,
		|	БольничныйЛист.РодственникЗаКоторымОсуществляетсяУход1 КАК пФИОРодственника1,
		|	БольничныйЛист.РодственникЗаКоторымОсуществляетсяУход2 КАК пФИОРодственника2,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ПоставленаНаУчетВРанниеСрокиБеременности = ЗНАЧЕНИЕ(Перечисление.ПостановкаНаУчетВРанниеСрокиБеременности.Поставлена)
		|				И БольничныйЛист.ПричинаНетрудоспособности = ЗНАЧЕНИЕ(Перечисление.ПричиныНетрудоспособности.ПоБеременностиИРодам)
		|			ТОГДА ""V""
		|		ИНАЧЕ """"
		|	КОНЕЦ КАК пРанниеСрокиДа,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ПоставленаНаУчетВРанниеСрокиБеременности = ЗНАЧЕНИЕ(Перечисление.ПостановкаНаУчетВРанниеСрокиБеременности.НеПоставлена)
		|				И БольничныйЛист.ПричинаНетрудоспособности = ЗНАЧЕНИЕ(Перечисление.ПричиныНетрудоспособности.ПоБеременностиИРодам)
		|			ТОГДА ""V""
		|		ИНАЧЕ """"
		|	КОНЕЦ КАК пРанниеСрокиНет,
		|	БольничныйЛист.ДатаНарушенияРежима КАК пДатаНарушенияРежима,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ДатаНарушенияРежима <> ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		|			ТОГДА ""V""
		|		ИНАЧЕ """"
		|	КОНЕЦ КАК пНарушениеРежима,
		|	БольничныйЛист.ПериодНахожденияВСтационареСРебенкомС КАК пСтационарС,
		|	БольничныйЛист.ПериодНахожденияВСтационареСРебенкомПо КАК пСтационарПо,
		|	БольничныйЛист.ДатаНаправленияВБюроМСЭ КАК пДатаНаправленияВМСЭ,
		|	БольничныйЛист.ДатаОсвидетельствованияМСЭ КАК пДатаОсвидетельствованияВМСЭ,
		|	БольничныйЛист.ДатаРегистрацииДокументовМСЭ КАК пДатаРегистрацииВМСЭ,
		|	БольничныйЛист.ГруппаИнвалидности КАК пУстановленаИнвалидность,
		|	БольничныйЛист.ОсвобождениеДатаНачала1 КАК пБолелС1,
		|	БольничныйЛист.ОсвобождениеДатаНачала2 КАК пБолелС2,
		|	БольничныйЛист.ОсвобождениеДатаНачала3 КАК пБолелС3,
		|	БольничныйЛист.ОсвобождениеДатаОкончания1 КАК пБолелПо1,
		|	БольничныйЛист.ОсвобождениеДатаОкончания2 КАК пБолелПо2,
		|	БольничныйЛист.ОсвобождениеДатаОкончания3 КАК пБолелПо3,
		|	БольничныйЛист.ОсвобождениеДолжностьВрача1 КАК пДолжностьВрача1,
		|	БольничныйЛист.ОсвобождениеДолжностьВрача2 КАК пДолжностьВрача2,
		|	БольничныйЛист.ОсвобождениеДолжностьВрача3 КАК пДолжностьВрача3,
		|	БольничныйЛист.ОсвобождениеДолжностьВрачаПредседателяВК1 КАК пДолжностьПредВК1,
		|	БольничныйЛист.ОсвобождениеДолжностьВрачаПредседателяВК2 КАК пДолжностьПредВК2,
		|	БольничныйЛист.ОсвобождениеДолжностьВрачаПредседателяВК3 КАК пДолжностьПредВК3,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ОсвобождениеФИОВрача1 <> """"
		|			ТОГДА БольничныйЛист.ОсвобождениеФИОВрача1
		|		ИНАЧЕ БольничныйЛист.ОсвобождениеИдентификационныйНомерВрача1
		|	КОНЕЦ КАК пФИОВрача1,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ОсвобождениеФИОВрача2 <> """"
		|			ТОГДА БольничныйЛист.ОсвобождениеФИОВрача2
		|		ИНАЧЕ БольничныйЛист.ОсвобождениеИдентификационныйНомерВрача2
		|	КОНЕЦ КАК пФИОВрача2,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ОсвобождениеФИОВрача3 <> """"
		|			ТОГДА БольничныйЛист.ОсвобождениеФИОВрача3
		|		ИНАЧЕ БольничныйЛист.ОсвобождениеИдентификационныйНомерВрача3
		|	КОНЕЦ КАК пФИОВрача3,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ОсвобождениеФИОВрачаПредседателяВК1 <> """"
		|			ТОГДА БольничныйЛист.ОсвобождениеФИОВрачаПредседателяВК1
		|		ИНАЧЕ БольничныйЛист.ОсвобождениеИдентификационныйНомерВрачаПредседателяВК1
		|	КОНЕЦ КАК пФИОПредВК1,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ОсвобождениеФИОВрачаПредседателяВК2 <> """"
		|			ТОГДА БольничныйЛист.ОсвобождениеФИОВрачаПредседателяВК2
		|		ИНАЧЕ БольничныйЛист.ОсвобождениеИдентификационныйНомерВрачаПредседателяВК2
		|	КОНЕЦ КАК пФИОПредВК2,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.ОсвобождениеФИОВрачаПредседателяВК3 <> """"
		|			ТОГДА БольничныйЛист.ОсвобождениеФИОВрачаПредседателяВК3
		|		ИНАЧЕ БольничныйЛист.ОсвобождениеИдентификационныйНомерВрачаПредседателяВК3
		|	КОНЕЦ КАК пФИОПредВК3,
		|	БольничныйЛист.ПриступитьКРаботеС КАК пПриступитьКРаботе,
		|	БольничныйЛист.НомерЛисткаПродолжения КАК пНомерПродолженияЛН,
		|	БольничныйЛист.НовыйСтатусНетрудоспособного КАК пИное,
		|	БольничныйЛист.ДатаНовыйСтатусНетрудоспособного КАК пИноеДата,
		|	БольничныйЛист.УсловияИсчисленияКод1 КАК пУсловияИсчисления1,
		|	БольничныйЛист.УсловияИсчисленияКод2 КАК пУсловияИсчисления2,
		|	БольничныйЛист.УсловияИсчисленияКод3 КАК пУсловияИсчисления3,
		|	БольничныйЛист.СтажЛет КАК СтажЛет,
		|	БольничныйЛист.СтажМесяцев КАК СтажМесяцев,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.СтажРасширенныйЛет = 0
		|				И БольничныйЛист.СтажРасширенныйМесяцев = 0
		|			ТОГДА БольничныйЛист.СтажЛет
		|		ИНАЧЕ БольничныйЛист.СтажРасширенныйЛет
		|	КОНЕЦ КАК СтажРасширенныйЛет,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.СтажРасширенныйЛет = 0
		|				И БольничныйЛист.СтажРасширенныйМесяцев = 0
		|			ТОГДА БольничныйЛист.СтажМесяцев
		|		ИНАЧЕ БольничныйЛист.СтажРасширенныйМесяцев
		|	КОНЕЦ КАК СтажРасширенныйМесяцев,
		|	БольничныйЛист.ДатаНачалаОплаты КАК пПособиеС,
		|	БольничныйЛист.ДатаОкончанияОплаты КАК пПособиеПо,
		|	ВЫБОР
		|		КОГДА БольничныйЛист.СреднийДневнойЗаработок < БольничныйЛист.МинимальныйСреднедневнойЗаработок
		|			ТОГДА БольничныйЛист.МинимальныйСреднедневнойЗаработок
		|		ИНАЧЕ БольничныйЛист.СреднийДневнойЗаработок
		|	КОНЕЦ КАК пСреднеДневнойЗаработок,
		|	БольничныйЛист.Руководитель КАК пФИОРуководителя,
		|	ВЫБОР
		|		КОГДА ПВРНачисления.КатегорияНачисленияИлиНеоплаченногоВремени = ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛистаЗаСчетРаботодателя)
		|			ТОГДА БольничныйЛистНачисления.Результат
		|		ИНАЧЕ 0
		|	КОНЕЦ КАК пСуммаПособияЗаСчетРаб,
		|	ВЫБОР
		|		КОГДА ПВРНачисления.КатегорияНачисленияИлиНеоплаченногоВремени <> ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛистаЗаСчетРаботодателя)
		|			ТОГДА БольничныйЛистНачисления.Результат
		|		ИНАЧЕ 0
		|	КОНЕЦ КАК пСуммаПособияЗаСчетСредствФСС
		|ИЗ
		|	Документ.БольничныйЛист КАК БольничныйЛист
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ФизическиеЛица КАК ФизическиеЛица
		|		ПО БольничныйЛист.ФизическоеЛицо = ФизическиеЛица.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.БольничныйЛист.Начисления КАК БольничныйЛистНачисления
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ ПланВидовРасчета.Начисления КАК ПВРНачисления
		|			ПО БольничныйЛистНачисления.Начисление = ПВРНачисления.Ссылка
		|		ПО БольничныйЛистНачисления.Ссылка = БольничныйЛист.Ссылка
		|ГДЕ
		|	БольничныйЛист.Ссылка = &СсылкаНаОбъект
		|	И ПВРНачисления.КатегорияНачисленияИлиНеоплаченногоВремени В (ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛиста), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛистаЗаСчетРаботодателя), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоПрофзаболевание), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоНесчастныйСлучайНаПроизводстве), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОтпускПоБеременностиИРодам))";
	
	Запрос.УстановитьПараметр("СсылкаНаОбъект", СсылкаНаОбъект);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если ВыборкаДетальныеЗаписи.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(СтруктураПараметров, ВыборкаДетальныеЗаписи);
	КонецЕсли;
	
	Если (СтруктураПараметров.пВозрастРодственникаЛет1 = 0) И (СтруктураПараметров.пВозрастРодственникаМес1) = 0 Тогда
		СтруктураПараметров.пВозрастРодственника1 = ""
	Иначе
		ПодписьВозрастГод1 = ПодписьГод(СтруктураПараметров.пВозрастРодственникаЛет1);
		ПодписьВозрастМесяц1 = ПодписьМесяц(СтруктураПараметров.пВозрастРодственникаМес1);
		СтруктураПараметров.пВозрастРодственника1 =	"" + СтруктураПараметров.пВозрастРодственникаЛет1 + " "
													+ ПодписьВозрастГод1 + " " 
													+ СтруктураПараметров.пВозрастРодственникаМес1 + " "
													+ ПодписьВозрастМесяц1;
	КонецЕсли;	

	Если (СтруктураПараметров.пВозрастРодственникаЛет2) + (СтруктураПараметров.пВозрастРодственникаМес2) = 0 Тогда
		СтруктураПараметров.пВозрастРодственника2 = ""
	Иначе
		ПодписьВозрастГод2 = ПодписьГод(СтруктураПараметров.пВозрастРодственникаЛет2);
		ПодписьВозрастМесяц2 = ПодписьМесяц(СтруктураПараметров.пВозрастРодственникаМес2);
		СтруктураПараметров.пВозрастРодственника1 =	"" + СтруктураПараметров.пВозрастРодственникаЛет2 + " "
													+ ПодписьВозрастГод2 + " " 
													+ СтруктураПараметров.пВозрастРодственникаМес2 + " "
													+ ПодписьВозрастМесяц2;
	КонецЕсли;
	
	СтруктураПараметров.пУсловияИсчисления = 
	?(СтруктураПараметров.пУсловияИсчисления1 = "", " -- ", СтруктураПараметров.пУсловияИсчисления1);
	СтруктураПараметров.пУсловияИсчисления = СтруктураПараметров.пУсловияИсчисления + 
	?(СтруктураПараметров.пУсловияИсчисления2 = "", " -- ", СтруктураПараметров.пУсловияИсчисления2);
	СтруктураПараметров.пУсловияИсчисления = СтруктураПараметров.пУсловияИсчисления +
	?(СтруктураПараметров.пУсловияИсчисления3 = "", " -- ", СтруктураПараметров.пУсловияИсчисления3);
	
	ТекущаяОрганизация = СсылкаНаОбъект.Организация;
	ДатаСобытия = СсылкаНаОбъект.Дата;
	СписокПоказателей = Новый Массив; 
	СписокПоказателей.Добавить("РегистрационныйНомерФСС");
	СписокПоказателей.Добавить("КодПодчиненностиФСС"); 
	СписокПоказателей.Добавить("КодПодчиненностиФСС");
	СписокПоказателей.Добавить("ФИОРук");
	СписокПоказателей.Добавить("ФИОБух");
	СтруктураОрганизации = ЗарплатаКадрыБазовый.ПолучитьСведенияОбОрганизации(ТекущаяОрганизация,ДатаСобытия,СписокПоказателей);
	СтруктураПараметров.пРегистрационныйНомер = СтруктураОрганизации.РегистрационныйНомерФСС;
	СтруктураПараметров.пКодПодчиненности = СтруктураОрганизации.КодПодчиненностиФСС;
	
	//СтруктураПараметров.пФИОРуководителя = СтруктураОрганизации.ФИОРук; //Руководителя возьмем из документа для интерактивного изменения
	СтруктураПараметров.пФИОГлБух = СтруктураОрганизации.ФИОБух;
	
	//Если есть стаж с учетом нестраховых периодов, то расчитаем эти периоды
	РазностьСтажей 	= УчетПособийСоциальногоСтрахования.ПодсчитатьРазностьСтажейВГодахИМесяцах(СтруктураПараметров.СтажРасширенныйЛет,
	СтруктураПараметров.СтажРасширенныйМесяцев,
	СтруктураПараметров.СтажЛет,
	СтруктураПараметров.СтажМесяцев);
	НестраховыхПериодовЛет 		= РазностьСтажей.РазностьЛет;
	НестраховыхПериодовМесяцев 	= РазностьСтажей.РазностьМесяцев;
	
	Если НестраховыхПериодовЛет > 0 Или НестраховыхПериодовМесяцев > 0 Тогда
		ПодписьЛетНестраховогоСтажа 			= ПодписьГод(НестраховыхПериодовЛет);
		ПодписьМесяцевНестраховогоСтажа 		= ПодписьМесяц(НестраховыхПериодовМесяцев);
		СтруктураПараметров.пНестраховыеПериоды	= ""+ НестраховыхПериодовЛет + " " 
													+ ПодписьЛетНестраховогоСтажа + " " 
													+ НестраховыхПериодовМесяцев + " " 
													+ ПодписьМесяцевНестраховогоСтажа;
	Иначе
		СтруктураПараметров.пНестраховыеПериоды	= "";
	КонецЕсли;
	//
	ПодписьЛетСтажа = ПодписьГод(СтруктураПараметров.СтажРасширенныйЛет);
	ПодписьМесяцевСтажа = ПодписьМесяц(СтруктураПараметров.СтажРасширенныйМесяцев);
	СтруктураПараметров.пСтраховойСтаж = "" + СтруктураПараметров.СтажРасширенныйЛет + " " 
											+ ПодписьЛетСтажа + " "
											+ СтруктураПараметров.СтажРасширенныйМесяцев + " "
											+ ПодписьМесяцевСтажа;
	
	СтруктураПараметров.пПособиеС 	= Формат(СтруктураПараметров.пПособиеС, "ДФ=dd.MM.yyyy");
	СтруктураПараметров.пПособиеПо 	= Формат(СтруктураПараметров.пПособиеПо, "ДФ=dd.MM.yyyy");
	Если Документы.БольничныйЛист.ПолныеПраваНаДокумент() Тогда
		СтруктураПараметров.пСреднеДневнойЗаработок = ЧислоВДенежнойФорме(СтруктураПараметров.пСреднеДневнойЗаработок);
		//Запрос для начислений
		Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
		               |	ВЫБОР
		               |		КОГДА ПВРНачисления.КатегорияНачисленияИлиНеоплаченногоВремени = ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛистаЗаСчетРаботодателя)
		               |			ТОГДА БольничныйЛистНачисления.Результат
		               |		ИНАЧЕ 0
		               |	КОНЕЦ КАК пСуммаПособияЗаСчетРаб,
		               |	ВЫБОР
		               |		КОГДА ПВРНачисления.КатегорияНачисленияИлиНеоплаченногоВремени <> ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛистаЗаСчетРаботодателя)
		               |			ТОГДА БольничныйЛистНачисления.Результат
		               |		ИНАЧЕ 0
		               |	КОНЕЦ КАК пСуммаПособияЗаСчетСредствФСС,
		               |	БольничныйЛистНачисления.Ссылка КАК Ссылка
		               |ИЗ
		               |	Документ.БольничныйЛист.Начисления КАК БольничныйЛистНачисления
		               |		ЛЕВОЕ СОЕДИНЕНИЕ ПланВидовРасчета.Начисления КАК ПВРНачисления
		               |		ПО БольничныйЛистНачисления.Начисление = ПВРНачисления.Ссылка
		               |ГДЕ
		               |	БольничныйЛистНачисления.Ссылка = &СсылкаНаОбъект
		               |	И ПВРНачисления.КатегорияНачисленияИлиНеоплаченногоВремени В (ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛиста), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоЛистаЗаСчетРаботодателя), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоПрофзаболевание), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОплатаБольничногоНесчастныйСлучайНаПроизводстве), ЗНАЧЕНИЕ(Перечисление.КатегорииНачисленийИНеоплаченногоВремени.ОтпускПоБеременностиИРодам))
		               |ИТОГИ
		               |	СУММА(пСуммаПособияЗаСчетРаб),
		               |	СУММА(пСуммаПособияЗаСчетСредствФСС)
		               |ПО
		               |	Ссылка";
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаНачислений = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Если ВыборкаНачислений.Следующий() Тогда
			СтруктураПараметров.пСуммаПособияЗаСчетРаб = ЧислоВДенежнойФорме(ВыборкаНачислений.пСуммаПособияЗаСчетРаб);
			СтруктураПараметров.пСуммаПособияЗаСчетСредствФСС = ЧислоВДенежнойФорме(ВыборкаНачислений.пСуммаПособияЗаСчетСредствФСС);
		КонецЕсли;
		
		Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
		               |	БольничныйЛистСреднийЗаработокФСС.Ссылка КАК Ссылка,
		               |	БольничныйЛистСреднийЗаработокФСС.Сумма КАК Сумма
		               |ИЗ
		               |	Документ.БольничныйЛист.СреднийЗаработокФСС КАК БольничныйЛистСреднийЗаработокФСС
		               |ГДЕ
		               |	БольничныйЛистСреднийЗаработокФСС.Ссылка = &СсылкаНаОбъект
		               |
		               |ОБЪЕДИНИТЬ ВСЕ
		               |
		               |ВЫБРАТЬ
		               |	БольничныйЛистСреднийЗаработокДанныеСтрахователей.Ссылка,
		               |	БольничныйЛистСреднийЗаработокДанныеСтрахователей.Сумма
		               |ИЗ
		               |	Документ.БольничныйЛист.СреднийЗаработокДанныеСтрахователей КАК БольничныйЛистСреднийЗаработокДанныеСтрахователей
		               |ГДЕ
		               |	БольничныйЛистСреднийЗаработокДанныеСтрахователей.Ссылка = &СсылкаНаОбъект
		               |ИТОГИ
		               |	СУММА(Сумма)
		               |ПО
		               |	Ссылка";
		
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаНачислений = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Если ВыборкаНачислений.Следующий() Тогда
			СтруктураПараметров.пСреднийЗаработок = ЧислоВДенежнойФорме(ВыборкаНачислений.Сумма);
		КонецЕсли;
		
	Иначе
		СтруктураПараметров.пСреднеДневнойЗаработок			= "";
		СтруктураПараметров.пСуммаПособияЗаСчетРаб			= "";
		СтруктураПараметров.пСуммаПособияЗаСчетСредствФСС	= "";
		СтруктураПараметров.пСреднийЗаработок				= "";
	КонецЕсли;
		
	ОбластьБЛ.Параметры.Заполнить(СтруктураПараметров);
	ТабДокумент.Вывести(ОбластьБЛ);
	
	Возврат ТабДокумент;
	
КонецФункции	


Процедура Печать(МассивОбъектов, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
		КоллекцияПечатныхФорм, 
		"БольничныйЛист", 
		"Больничный лист", 
		СформироватьПечатнуюФорму(МассивОбъектов[0], ОбъектыПечати) );
КонецПроцедуры // Печать()


Функция ПолучитьТаблицуКоманд()
	Команды = Новый ТаблицаЗначений;
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));//как будет выглядеть описание печ.формы для пользователя
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка")); //имя макета печ.формы
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка")); //ВызовСерверногоМетода
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));
	Возврат Команды;	
КонецФункции


Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
	НоваяКоманда = ТаблицаКоманд.Добавить();
	НоваяКоманда.Представление = Представление; 
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;
КонецПроцедуры


Функция СведенияОВнешнейОбработке() Экспорт
	
	ПараметрыРегистрации = Новый Структура;
	МассивНазначений = Новый Массив;
	МассивНазначений.Добавить("Документ.БольничныйЛист");
	ПараметрыРегистрации.Вставить("Вид", "ПечатнаяФорма");
	ПараметрыРегистрации.Вставить("Назначение", МассивНазначений);
	ПараметрыРегистрации.Вставить("Наименование", "Больничный лист"); //имя под которым обработка будет зарегестрирована в справочнике внешних обработок
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Версия", "1.1"); 
	ПараметрыРегистрации.Вставить("Информация", "Печать формы больничного листа для ЭЛН"); 
	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	ДобавитьКоманду(ТаблицаКоманд, "Больничный лист", "БольничныйЛист", "ВызовСерверногоМетода", Истина, "ПечатьMXL");
	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
	
	Возврат ПараметрыРегистрации;
КонецФункции	