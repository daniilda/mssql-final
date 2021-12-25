USE [CommerceClinic]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------
-- PURPOSE:    View of free slots
-- Author:     Daniil Kuznetsov (daniilda)
-- DateOfCreation: 08.12.2021
------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER VIEW [dbo].[vFreeSlots]
AS
SELECT MS.Id MedicalStaffId, (MS.FirstName + ' ' + MS.MiddleName + ' ' + MS.SecondName) Name, MS.Area, TS.Id TimeSlotId, TS.[From] StartsAt, TS.[To] Untill
FROM dbo.TimeSlots TS
         CROSS JOIN MedicalStaff MS
WHERE TS.[From] >= GETDATE()
EXCEPT
SELECT MS.Id AS MedicalStaffId,(MS.FirstName + ' ' + MS.MiddleName + ' ' + MS.SecondName) Name,MS.Area,TS.Id AS TimeSlotId,TS.[From] StartsAt,TS.[To] Untill
 FROM dbo.TimeSlots TS
          CROSS JOIN MedicalStaff MS
          INNER JOIN Referrals R ON MS.Id = R.MedicalStaffId
    WHERE R.TimeSlotId = TS.Id
