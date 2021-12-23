USE [master]
GO

CREATE DATABASE [CommerceClinic]
GO

USE [CommerceClinic]
GO

BEGIN TRANSACTION

CREATE TABLE [Patients]
(
    [Id]                 INT PRIMARY KEY IDENTITY,
    [FirstName]          NVARCHAR(60)  NULL,
    [SecondName]         NVARCHAR(60)  NULL,
    [MiddleName]         NVARCHAR(60)  NULL,
    [Gender]             BIT           NOT NULL,
    [DateOfBirth]        DATE          NOT NULL,
    [Address]            NVARCHAR(100) NULL,
    [PaymentCredentials] NVARCHAR(100) NOT NULL,
    [InsuranceData]      NVARCHAR(100) NULL
);

CREATE TABLE [StaffCategory]
(
    [Id]          INT PRIMARY KEY IDENTITY,
    [Name]        NVARCHAR(60)  NOT NULL UNIQUE,
    [Description] NVARCHAR(100) NULL,
    [CostRate]    DECIMAL       NOT NULL
);

CREATE TABLE [MedicalStaff]
(
    [Id]         INT PRIMARY KEY IDENTITY,
    [FirstName]  NVARCHAR(60) NULL,
    [SecondName] NVARCHAR(60) NULL,
    [MiddleName] NVARCHAR(60) NULL,
    [Gender]     BIT          NOT NULL,
    [CategoryId] INT          NULL,
    [Degree]     NVARCHAR(60) NULL,
    [Area]       NVARCHAR(60) NOT NULL,
    CONSTRAINT FK_MedicalStaff_To_StaffCategory FOREIGN KEY (CategoryId) REFERENCES [StaffCategory] (Id)
);

CREATE TABLE [Drugs]
(
    [Id]          INT PRIMARY KEY IDENTITY,
    [Name]        NVARCHAR(60)  NOT NULL UNIQUE,
    [Description] NVARCHAR(100) NULL
);

CREATE TABLE [Prescriptions]
(
    [Id]             INT PRIMARY KEY IDENTITY,
    [PatientId]      INT           NOT NULL,
    [MedicalStaffId] INT           NOT NULL,
    [DrugId]         INT           NOT NULL,
    [Description]    NVARCHAR(100) NOT NULL,
    [ExpiresAt]      DATE          NOT NULL,
    CONSTRAINT FK_Prescriptions_To_Patients FOREIGN KEY (PatientId) REFERENCES [Patients] (Id),
    CONSTRAINT FK_Prescriptions_To_MedicalStaff FOREIGN KEY (MedicalStaffId) REFERENCES [MedicalStaff] (Id),
    CONSTRAINT FK_Prescriptions_To_Drugs FOREIGN KEY (DrugId) REFERENCES [Drugs] (Id)
);

CREATE TABLE [TimeSlots]
(
    [Id]   INT PRIMARY KEY IDENTITY,
    [From] DATETIME NOT NULL,
    [To]   DATETIME NOT NULL
);

CREATE TABLE [Bills]
(
    [Id]          INT PRIMARY KEY IDENTITY,
    [Amount]      DECIMAL       NOT NULL,
    [PaymentInfo] NVARCHAR(100) NULL
);

CREATE TABLE [ServiceTypes]
(
    [Id]          INT PRIMARY KEY IDENTITY,
    [Name]        NVARCHAR(60)  NOT NULL UNIQUE,
    [Description] NVARCHAR(100) NULL
);

CREATE TABLE [Services]
(
    [Id]          INT PRIMARY KEY IDENTITY,
    [Name]        NVARCHAR(60)  NOT NULL,
    [Description] NVARCHAR(100) NULL,
    [Price]       DECIMAL       NOT NULL,
    [TypeId]      INT           NOT NULL,
    CONSTRAINT FK_Services_To_ServicesTypes FOREIGN KEY (TypeId) REFERENCES [ServiceTypes] (Id)
);

CREATE TABLE [Referrals]
(
    [Id]             INT PRIMARY KEY IDENTITY,
    [PatientId]      INT           NOT NULL,
    [MedicalStaffId] INT           NOT NULL,
    [ServiceId]      INT           NOT NULL,
    [TimeSlotId]     INT           NOT NULL,
    [Result]         NVARCHAR(100) NULL,
    [BillId]         INT           NULL,
    CONSTRAINT FK_Referrals_To_Patients FOREIGN KEY (PatientId) REFERENCES [Patients] (Id),
    CONSTRAINT FK_Referrals_To_MedicalStaff FOREIGN KEY (MedicalStaffId) REFERENCES [MedicalStaff] (Id),
    CONSTRAINT FK_Referrals_To_Services FOREIGN KEY (ServiceId) REFERENCES [Services] (Id),
    CONSTRAINT FK_Referrals_To_TimeSlots FOREIGN KEY (TimeSlotId) REFERENCES [TimeSlots] (Id),
    CONSTRAINT FK_Referrals_To_Bills FOREIGN KEY (BillId) REFERENCES [Bills] (Id)
);

COMMIT TRANSACTION;


