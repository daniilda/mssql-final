USE [CommerceClinic]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------
-- PURPOSE:    Checks if price is correct
-- Author:     Daniil Kuznetsov (daniilda)
-- DateOfCreation: 08.12.2021
------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER [dbo].[WrongPriceCheckTrigger]
    ON dbo.Services
    AFTER INSERT , UPDATE
    AS
BEGIN
    IF EXISTS(SELECT *
              FROM inserted INS
              WHERE (INS.Price < 0))
        BEGIN
            ROLLBACK TRANSACTION;
            THROW 50010, 'Стоимость не может быть отрицательной', 1;
        END
END
GO