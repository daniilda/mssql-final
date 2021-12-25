USE [CommerceClinic]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------
-- PURPOSE:    Checks if date is correct
-- Author:     Daniil Kuznetsov (daniilda)
-- DateOfCreation: 08.12.2021
------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER [dbo].[NotDateInPastCheckTrigger]
    ON dbo.Prescriptions
    AFTER INSERT , UPDATE
    AS
BEGIN
    IF EXISTS(SELECT *
              FROM inserted INS
              WHERE (INS.ExpiresAt < CAST(GETDATE() AS DATE)))
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50010, 'Нельзя выписать рецепт в прошлое', 1;
        END
END
GO