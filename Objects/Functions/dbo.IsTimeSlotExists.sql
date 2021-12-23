USE [CommerceClinic]
GO

CREATE OR ALTER FUNCTION [dbo].[IsTimeSlotExist](@From DATETIME, @Duration INT)
    RETURNS BINARY
AS
BEGIN
    IF EXISTS(SELECT *
              FROM TimeSlots TS
              WHERE [From] = @From
                AND [To] = DATEADD(minute, @Duration, @From))
              RETURN 1;
    RETURN 0;
END
GO