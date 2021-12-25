USE [CommerceClinic]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------
-- PURPOSE:    View of patients per day
-- Author:     Daniil Kuznetsov (daniilda)
-- DateOfCreation: 08.12.2021
------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER VIEW [dbo].[vPatientsPerDay]
AS
SELECT R.MedicalStaffId, CAST(TS.[From] AS DATE) Date, COUNT(*) Amount
FROM dbo.Referrals R
         INNER JOIN dbo.TimeSlots TS ON R.TimeSlotId = TS.Id
GROUP BY CAST(TS.[From] AS DATE), R.MedicalStaffId
