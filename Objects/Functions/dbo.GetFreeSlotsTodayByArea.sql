USE [CommerceClinic]
GO

CREATE OR ALTER FUNCTION [dbo].[GetFreeSlotsByAreaAndTime](@Area NVARCHAR(50), @Time DATETIME = NULL)
    RETURNS INT
AS
BEGIN
    IF @Time IS NULL
        SET @Time = GETDATE();
    RETURN (SELECT COUNT(*) FROM dbo.vFreeSlots FS
    INNER JOIN dbo.TimeSlots TS ON TS.Id = FS.TimeSlotId
    WHERE FS.Area = @Area AND @Time >= TS.[From] AND @Time <= TS.[To])
END;