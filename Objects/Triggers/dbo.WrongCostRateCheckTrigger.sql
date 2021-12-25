USE [CommerceClinic]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------
-- PURPOSE:    Checks if CostRate is Correct
-- Author:     Daniil Kuznetsov (daniilda)
-- DateOfCreation: 08.12.2021
------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER [dbo].[WrongCostRateCheckTrigger]
    ON dbo.StaffCategory
    AFTER INSERT , UPDATE
    AS
BEGIN
    IF EXISTS(SELECT *
              FROM inserted INS
              WHERE (INS.CostRate < 1))
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50011, 'Коэфицент НЕ должен быть < 1', 1;
        END
END
GO