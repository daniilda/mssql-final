USE [CommerceClinic]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------
-- PURPOSE:    Procedure generate n - number or "timeslots" with x - interval on day - z
-- Author:     Daniil Kuznetsov (daniilda)
-- DateOfCreation: 08.12.2021
------------------------------------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[CreateTimeSlots] @date DATE,
                                                    @interval INT
AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;

    DECLARE @WorkDayStart INT = 9; -- amount of hours from 00:00 to the beginning of the working day
    DECLARE @MinuteCounter INT = 480; -- minutes in one work day
    DECLARE @BeginningOfDay DATETIME = DATEADD(hour, @WorkDayStart, CAST(@date AS DATETIME));

    IF @interval < 0 OR @interval % 5 > 0
        THROW 70002, 'Wrong interval, must be % 5', 1;
    IF ([dbo].IsTimeSlotExist(@BeginningOfDay, @interval) = 1)
        THROW 70001 ,'This time slot is already exists' ,1;

    WHILE (@MinuteCounter > 0)
        BEGIN
            IF @MinuteCounter < @interval
                BEGIN
                    INSERT INTO TimeSlots ([From], [To])
                    VALUES (DATEADD(minute, 480 - @MinuteCounter, @BeginningOfDay),
                            DATEADD(minute, 480, @BeginningOfDay))
                    SET @MinuteCounter = 0;
                END;
            ELSE
                BEGIN
                    INSERT INTO TimeSlots ([From], [To])
                    VALUES (DATEADD(minute, 480 - @MinuteCounter, @BeginningOfDay),
                            DATEADD(minute, 480 - @MinuteCounter + @interval, @BeginningOfDay))
                    SET @MinuteCounter = @MinuteCounter - @interval
                END;
        END
END;
GO