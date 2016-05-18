--SELECT Group_numb FROM Student where id_student = 1

IF OBJECT_ID('dbo.InsertInf', 'P') IS NOT NULL DROP PROCEDURE [InsertInf]
GO
CREATE PROCEDURE dbo.InsertInf
	@CurrentGroupId Int,
	@SelectedTeacherId Int,
	@CurrentSemesterId Int
AS 
    SET NOCOUNT ON;
SELECT 
	Number
FROM 
	Group_Semestre
WHERE 
	Group_Numb = @CurrentGroupId
	AND
	Semestre = @CurrentSemesterId
	AND 
	Teacher_ID = @SelectedTeacherId
	
	
	GRANT EXECUTE ON dbo.InsertInf TO AdminAnk
GO

GRANT Execute ON dbo.Anketa TO AdminAnk
GO