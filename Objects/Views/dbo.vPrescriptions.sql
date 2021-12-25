USE [CommerceClinic]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------
-- PURPOSE:    View of prescriptions
-- Author:     Daniil Kuznetsov (daniilda)
-- DateOfCreation: 08.12.2021
------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER VIEW [dbo].[vPrescriptions]
AS
SELECT MS.Id AS                                       MedicalStaffId,
       (MS.FirstName + MS.MiddleName + MS.SecondName) MedicalStaffName,
       PT.Id AS                                       PatientId,
       (PT.FirstName + PT.MiddleName + PT.SecondName) PatientName,
       D.Id AS DrugId,
       D.Name DrugName,
       D.Description DrugDescription,
       P.Description Prescription,
       P.ExpiresAt
FROM dbo.Prescriptions P
         INNER JOIN dbo.MedicalStaff MS ON P.MedicalStaffId = MS.Id
         INNER JOIN dbo.Drugs D ON P.DrugId = D.Id
         INNER JOIN dbo.Patients PT ON P.PatientId = PT.Id