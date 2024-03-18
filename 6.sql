-- Получить список студентов, зачисленных до первого сентября 2012 года на первый курс очной или заочной формы обучения (специальность: 230101). В результат включить:
-- номер группы;
-- номер, фамилию, имя и отчество студента;
-- номер и состояние пункта приказа;
-- Для реализации использовать подзапрос с IN.

SELECT Н_УЧЕНИКИ.ГРУППА, Н_ЛЮДИ.ФАМИЛИЯ, Н_ЛЮДИ.ИМЯ,
Н_ЛЮДИ.ОТЧЕСТВО, Н_УЧЕНИКИ.СОСТОЯНИЕ,
Н_ПЛАНЫ.ДАТА_УТВЕРЖДЕНИЯ AS Приказ
FROM Н_ЛЮДИ
JOIN Н_ОБУЧЕНИЯ ON Н_ЛЮДИ.ИД = Н_ОБУЧЕНИЯ.ЧЛВК_ИД
JOIN Н_УЧЕНИКИ ON Н_ОБУЧЕНИЯ.ЧЛВК_ИД = Н_УЧЕНИКИ.ЧЛВК_ИД
JOIN Н_ПЛАНЫ ON Н_УЧЕНИКИ.ПЛАН_ИД = Н_ПЛАНЫ.ИД
JOIN Н_ФОРМЫ_ОБУЧЕНИЯ ON Н_ПЛАНЫ.ФО_ИД = Н_ФОРМЫ_ОБУЧЕНИЯ.ИД
WHERE EXISTS ( 
	SELECT 1
	FROM Н_ОБУЧЕНИЯ
	JOIN Н_ПЛАНЫ ON Н_УЧЕНИКИ.ПЛАН_ИД = Н_ПЛАНЫ.ИД
	JOIN Н_ФОРМЫ_ОБУЧЕНИЯ ON Н_ПЛАНЫ.ФО_ИД = Н_ФОРМЫ_ОБУЧЕНИЯ.ИД
	WHERE Н_ПЛАНЫ.ДАТА_УТВЕРЖДЕНИЯ < '2012-09-01'
	AND (Н_ФОРМЫ_ОБУЧЕНИЯ.НАИМЕНОВАНИЕ = 'очная' 
	OR Н_ФОРМЫ_ОБУЧЕНИЯ.НАИМЕНОВАНИЕ = 'Заочная')
	AND Н_УЧЕНИКИ.ПРИЗНАК = 'зачисл'
	AND Н_ОБУЧЕНИЯ.ЧЛВК_ИД = Н_ЛЮДИ.ИД 
);