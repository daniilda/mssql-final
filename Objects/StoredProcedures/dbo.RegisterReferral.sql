USE [CommerceClinic]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------
-- PURPOSE:    Registers a new referrals
-- Author:     Daniil Kuznetsov (daniilda)
-- DateOfCreation: 08.12.2021
------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[RegisterReferral] @PatientId INT, @DoctorId INT, @ServiceId INT, @Time DATETIME
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    DECLARE @TimeSlot INT;
    SELECT @TimeSlot = FS.TimeSlotId
    FROM dbo.vFreeSlots FS
    WHERE FS.StartsAt = @Time
      AND FS.MedicalStaffId = @DoctorId
    IF NOT EXISTS(SELECT * FROM dbo.Patients P WHERE P.Id = @PatientId)
        THROW 50006, 'No patient found', 1;
    IF NOT EXISTS(SELECT * FROM dbo.MedicalStaff MS WHERE MS.Id = @DoctorId)
        THROW 50007, 'No medical personal found', 1;
    IF NOT EXISTS(SELECT * FROM dbo.Services S WHERE S.Id = @ServiceId)
        THROW 50008, 'No service found', 1;
    IF @TimeSlot IS NULL
        THROW 50005, 'No free time slots on this time', 1;

    INSERT INTO dbo.Referrals (PatientId, MedicalStaffId, ServiceId, TimeSlotId)
    VALUES (@PatientId, @DoctorId, @ServiceId, @TimeSlot);
END;