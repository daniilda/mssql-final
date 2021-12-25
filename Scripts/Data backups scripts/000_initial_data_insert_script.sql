USE [CommerceClinic]
GO

BEGIN TRANSACTION

INSERT INTO dbo.Drugs (Name, Description)
VALUES (N'ранитидин', N'таблетки, покрытые оболочкой'),
       (N'фамотидин', N'таблетки, покрытые оболочкой'),
       (N'омепразол', N'таблетки, покрытые оболочкой'),
       (N'эзомепразол', N'таблетки, покрытые оболочкой'),
       (N'мебеверин', N'таблетки, покрытые оболочкой'),
       (N'платифиллин', N'таблетки, покрытые оболочкой'),
       (N'метоклопрамид', N'таблетки, покрытые оболочкой'),
       (N'ондансетрон', N'таблетки, покрытые оболочкой'),
       (N'урсодезоксихолевая кислота', N'таблетки, покрытые оболочкой'),
       (N'бисакодил', N'таблетки, покрытые оболочкой')

INSERT INTO dbo.StaffCategory (Name, Description, CostRate)
VALUES (N'Категория 1', N'Категория 1', 1),
       (N'Категория 2', N'Категория 2', 1.1),
       (N'Категория 3', N'Категория 3', 1.2),
       (N'Категория 4', N'Категория 4', 1.3),
       (N'Категория 5', N'Категория 5', 1.4)

INSERT INTO dbo.MedicalStaff (FirstName, SecondName, MiddleName, Gender, CategoryId, Degree, Area)
VALUES (N'Даниил', N'Кузнецов', N'Андреевич', 1, 2, 'N-3234KF', N'Хирургия'),
       (N'Даниил', N'Кузнецов', N'Дмитриевич', 1, 3, 'N-134KF', N'Стоматология'),
       (N'Иван', N'Смирнов', N'Сергеевич', 1, 3, NULL, N'Хирургия')

INSERT INTO dbo.ServiceTypes (Name, Description)
VALUES (N'Процедура', N'Процедуры'),
       (N'Анализ', N'Анализы'),
       (N'Операция', N'Операции'),
       (N'Прием', N'Приемы к специалистам')

INSERT INTO dbo.Services (Name, Description, Price, TypeId)
VALUES (N'Стандартный анализ крови', N'Стандартный анализ крови', 109.99, 2),
       (N'Первичный прием', N'Первичный прием у врача', 200, 4),
       (N'Вторичный прием', N'Вторичный прием у врача', 50.99, 4),
       (N'Удаление аппендицита', N'Удаление аппендицита', 16000, 3),
       (N'Прогревание', 'Прогревание', 100, 1)

INSERT INTO dbo.Patients (FirstName, SecondName, MiddleName, Gender, DateOfBirth, Address, PaymentCredentials, InsuranceData)
VALUES (N'Иван', N'Иванов', N'Иванович', 1, CAST('12-12-2000' AS DATE), '-', '3323 4234 4235 4324',
        N'СОГАЗ Страхование - 443#4334')


COMMIT TRANSACTION;