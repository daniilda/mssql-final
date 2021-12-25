USE [CommerceClinic]
GO

CREATE OR ALTER FUNCTION [dbo].[CalculateByReferral](@ReferralId INT)
    RETURNS DECIMAL
AS
BEGIN
    DECLARE @DegreeCoefficient DECIMAL = 1.1;
    DECLARE @Price DECIMAL = 0;
    DECLARE @CategoryCoefficient DECIMAL = 0;
    SELECT @CategoryCoefficient = SC.CostRate
    FROM Referrals R
             INNER JOIN dbo.MedicalStaff MS ON MS.Id = R.MedicalStaffId
             INNER JOIN dbo.StaffCategory SC ON MS.CategoryId = SC.Id
    WHERE R.Id = @ReferralId
    SELECT @Price = S.Price
    FROM Referrals R
             INNER JOIN Services S ON R.ServiceId = S.Id
    WHERE R.Id = @ReferralId

    IF EXISTS(SELECT *
              FROM MedicalStaff MS
                       INNER JOIN Referrals R ON MS.Id = R.MedicalStaffId
              WHERE R.Id = @ReferralId
                AND Degree IS NOT NULL)
        RETURN @Price * @CategoryCoefficient;
    RETURN @Price * @CategoryCoefficient * @DegreeCoefficient;
END
GO