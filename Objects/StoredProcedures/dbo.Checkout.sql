USE [CommerceClinic]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------
-- PURPOSE:    Creates bills
-- Author:     Daniil Kuznetsov (daniilda)
-- DateOfCreation: 08.12.2021
------------------------------------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[CheckOut] @PatientId INT
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    DECLARE @TotalAmount DECIMAL;
    DECLARE @Calculated DECIMAL;
    DECLARE @Referrals TABLE
                       (
                           Id INT
                       );
    INSERT INTO @Referrals
    SELECT Id
    FROM dbo.Referrals
    WHERE Result IS NOT NULL
      AND BillId IS NULL
      AND PatientId = 1

    WHILE (SELECT COUNT(*) FROM @Referrals) > 0
        BEGIN
            SELECT TOP (1) @Calculated = Id FROM @Referrals ORDER BY Id;
            SET @TotalAmount = @TotalAmount + dbo.CalculateByReferral(@Calculated);
        END
    INSERT INTO dbo.Bills (Amount)
    VALUES (@TotalAmount)
    UPDATE dbo.Referrals
    SET BillId = SCOPE_IDENTITY()
    WHERE PatientId = @PatientId
      AND BillId IS NULL;
END;