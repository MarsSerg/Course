SET NOCOUNT ON;

IF OBJECT_ID('dbo.BrowseAnketa', 'P') IS NOT NULL DROP PROCEDURE [BrowseAnketA]
GO
CREATE PROCEDURE dbo.BrowseANKETA
AS 
    SET NOCOUNT ON;

    SELECT 
		Id_Anketa,
		Anketa_Name,
		Dateofcreate,
		DATEofLastChange
    FROM 
		Anketa
	ORDER BY
		DateOfCreate
GO

IF OBJECT_ID('dbo.BrowseGroup', 'P')	IS NOT NULL DROP PROCEDURE [BrowseGroup]
GO
CREATE PROCEDURE dbo.BrowseGroup
AS 
    SET NOCOUNT ON;

    SELECT 
		Group_numb,
		Specialization_ID
    FROM 
		GroupNum 
	ORDER BY
		Group_Numb
GO

IF OBJECT_ID('dbo.BrowseGroupSemestre', 'P') IS NOT NULL DROP PROCEDURE [BrowseGroupSemestre]
GO
CREATE PROCEDURE dbo.BrowseGroupSemestre
AS 
    SET NOCOUNT ON;

    SELECT 
		Semestre,
		Group_Numb,
		Subject_ID,
		Teacher_ID,
		Number
    FROM 
		Group_Semestre
	ORDER BY
		Semestre
GO

IF OBJECT_ID('dbo.BrowsePassNumber', 'P') IS NOT NULL DROP PROCEDURE [BrowsePassNumber]
GO
CREATE PROCEDURE dbo.BrowsePassNumber
AS 
    SET NOCOUNT ON;

    SELECT 
		ID_pass_key,
		Id_Student,
		ID_Anketa,
		Number,
		POints
    FROM 
	Pass_numb
	ORDER BY
		Id_Student
GO

IF OBJECT_ID('dbo.BrowseQuestions', 'P') IS NOT NULL DROP PROCEDURE [BrowseQuestions]
GO
CREATE PROCEDURE dbo.BrowseQuestions
AS 
    SET NOCOUNT ON;

    SELECT 
		ID_Quest,
		ID_Anketa,
		Quest_Text
    FROM 
	Question
	ORDER BY
		ID_Quest
GO

IF OBJECT_ID('dbo.BrowseSpecializations', 'P') IS NOT NULL DROP PROCEDURE [BrowseSpecializations]
GO
CREATE PROCEDURE dbo.BrowseSpecializations
AS 
    SET NOCOUNT ON;

    SELECT 
		
		Specialization_ID,
		Name_Specialization
    FROM 
	Specializations
	
GO

IF OBJECT_ID('dbo.BrowseStudent', 'P') IS NOT NULL DROP PROCEDURE [BrowseStudent]
GO
CREATE PROCEDURE dbo.BrowseStudent
AS 
    SET NOCOUNT ON;

    SELECT 
		
		Id_Student,
        Name_Stud,
        Firstname_Stud,
        Lastname_Stud,
        Group_Numb
    FROM 
	Student
	
GO

IF OBJECT_ID('dbo.BrowseSubject', 'P') IS NOT NULL DROP PROCEDURE [BrowseSubject]
GO
CREATE PROCEDURE dbo.BrowseSubject
AS 
    SET NOCOUNT ON;

    SELECT 
		
		Subject_ID,
		Name_of_Subject
    FROM 
	inst_Subject
	
GO

IF OBJECT_ID('dbo.BrowseTeacher', 'P') IS NOT NULL DROP PROCEDURE [BrowseTeacher]
GO
CREATE PROCEDURE dbo.BrowseTeacher
AS 
    SET NOCOUNT ON;

    SELECT 
		
		Teacher_ID,
        Name,
        Surname,
        Lastname
    FROM 
	Teacher
	
GO

/********************************
 *			 Browse Off			*
 ********************************/



IF OBJECT_ID('dbo.CreateAnketa', 'P') IS NOT NULL DROP PROCEDURE [CreateAnketa]
GO
CREATE PROCEDURE dbo.CreateAnketa
	@Id Int,
	@Name Text,
	@Dateofcreate datetime,
	@dateoflastchange datetime
AS 
    SET NOCOUNT ON;

	INSERT INTO Anketa
	(
		ID_Anketa, 
		Anketa_name, 
		DateOfCreate, 
		DateOfLastChange
	)
	SELECT
		@Id,
		@Name,
		@Dateofcreate,
		@dateoflastchange
GO

IF OBJECT_ID('dbo.UpdateAnketa', 'P') IS NOT NULL DROP PROCEDURE [UpdateAnketA]
GO
CREATE PROCEDURE dbo.Updateanketa
	@Id Int,
	@Name Text,
	@Dateofcreate datetime,
	@dateoflastchange datetime
AS 
    SET NOCOUNT ON;

	UPDATE Anketa SET
	ID_Anketa = @Id ,
	Anketa_name = @Name ,
	DateOfCreate = @Dateofcreate ,
	DateOfLastChange = @dateoflastchange 
	
GO

IF OBJECT_ID('dbo.DeleteAnketa', 'P') IS NOT NULL DROP PROCEDURE [DeleteAnketa]
GO
CREATE PROCEDURE dbo.DeleteAnketa
	@Id_ank INT
AS
	DELETE FROM Anketa WHERE ID_Anketa = @Id_ank
GO

/********************************
 *			 Anketa Off			*
 ********************************/

IF OBJECT_ID('dbo.CreateGroup', 'P') IS NOT NULL DROP PROCEDURE [CreateGroup]
GO
CREATE PROCEDURE dbo.CreateGroup
	@Group_numb CHAR (4),
	@Id Char (3)
AS 
    SET NOCOUNT ON;

	INSERT INTO GroupNum
	
	(Group_Numb,
	Specialization_ID
	) 
	SELECT @Group_numb,
	       @Id
GO

IF OBJECT_ID('dbo.UpdateGroup', 'P') IS NOT NULL DROP PROCEDURE [UpdateGroup]
GO
CREATE PROCEDURE dbo.UpdateGroup
	@Group_numb CHAR (4),
	@Id Char (3)
AS 
    SET NOCOUNT ON;

	UPDATE GroupNum SET
		
		Specialization_Id = @Group_numb
	WHERE
		Group_numb = @Group_numb 
GO

IF OBJECT_ID('dbo.DeleteGroup', 'P') IS NOT NULL DROP PROCEDURE [DeleteGroup]
GO
CREATE PROCEDURE dbo.DeleteGroup
	@Id INT
AS
	DELETE FROM GroupNum WHERE Group_numb = @Id
GO

/********************************
 *			 Group Off			*
 ********************************/

IF OBJECT_ID('dbo.CreateGrSem', 'P') IS NOT NULL DROP PROCEDURE [CreateGRsem]
GO
CREATE PROCEDURE dbo.CreateGrSem
	@Semestre INT,
	@Group_numb Char (4),
	@Subject int,
	@Teacher_id Char (3),
	@Number Int
AS 
    SET NOCOUNT ON;

	INSERT INTO Group_Semestre 
	(		
		Semestre,	
		Group_Numb,
		Subject_ID,
		Teacher_ID,
		Number	
	)
	SELECT
		@Semestre,	
		@Group_numb,
		@Subject,
		@Teacher_id,
		@Number
GO

IF OBJECT_ID('dbo.UpdateGrSem', 'P') IS NOT NULL DROP PROCEDURE [UpdategrSem]
GO
CREATE PROCEDURE dbo.UpdateGrSem
    @Semestre INT,
	@Group_numb Char (4),
	@Subject int,
	@Teacher_id Char (3),
	@id int
AS 
    SET NOCOUNT ON;

	UPDATE Group_Semestre SET
		Semestre = @Semestre,
		Group_Numb = @Group_numb,
		Subject_ID = @Subject,
		Teacher_ID = @Teacher_id
		 WHERE
		Number = @Id
GO

IF OBJECT_ID('dbo.DeleteGrSem', 'P') IS NOT NULL DROP PROCEDURE [DeleteGrSem]
GO
CREATE PROCEDURE dbo.DeleteGrSem
	@Id INT
AS
	DELETE FROM Group_Semestre WHERE Number = @Id
GO

/********************************
 *			 Anketa Off			*
 ********************************/

IF OBJECT_ID('dbo.CreatePassNum', 'P') IS NOT NULL DROP PROCEDURE [CreatePassNum]
GO
CREATE PROCEDURE dbo.CreatePassNum
	@ID INT,
	@PassDate datetime,
	@iDstud int,
	@Idquest int,
	@idank int,
	@number int,
	@points char(18)
AS 
    SET NOCOUNT ON;

	INSERT INTO Pass_numb
	(		
		ID_pass_key,
		Pass_date,
		Id_Student,
		ID_Quest,
		ID_Anketa,
		Number,
		POints
	)
	SELECT
	@ID ,
	@PassDate ,
	@iDstud ,
	@Idquest ,
	@idank ,
	@number ,
	@points 
		
GO

IF OBJECT_ID('dbo.UpdatePassnum', 'P') IS NOT NULL DROP PROCEDURE [UpdatepassNum]
GO
CREATE PROCEDURE dbo.UpdatepassNum
   @ID INT,
	@PassDate datetime,
	@iDstud int,
	@Idquest int,
	@idank int,
	@number int,
	@points char(18)
AS 
    SET NOCOUNT ON;

	UPDATE Pass_numb SET
		
		Pass_date = @PassDate,
		Id_Student = @iDstud,
		ID_Quest = @Idquest,
		ID_Anketa = @idank,
		Number = @Number,
		POints = @points
		 WHERE
		ID_pass_key = @ID
GO

IF OBJECT_ID('dbo.DeletePassNum', 'P') IS NOT NULL DROP PROCEDURE [DeletePassNum]
GO
CREATE PROCEDURE dbo.DeletePassNum
	@Id INT
AS
	DELETE FROM Pass_numb WHERe ID_pass_key = @Id
GO

/********************************
 *	 PASS_NUMBER OFF         *
 ********************************/
 
 IF OBJECT_ID('dbo.CreateQuest', 'P') IS NOT NULL DROP PROCEDURE [Createquest]
GO
CREATE PROCEDURE dbo.CreateQuest
	@IDquest INT,
	@idank int,
	@Text text
AS 
    SET NOCOUNT ON;

	INSERT INTO Question
	(		
		ID_Quest,
		ID_Anketa,
		Quest_Text
	)
	SELECT
	@IDquest ,
	@idank ,
	@Text	
GO

IF OBJECT_ID('dbo.UpdateQuest', 'P') IS NOT NULL DROP PROCEDURE [UpdateQuest]
GO
CREATE PROCEDURE dbo.UpdateQuest
 @IDquest INT,
	@idank int,
	@Text text 
AS 
    SET NOCOUNT ON;

	UPDATE Question SET
	 Quest_Text =  @Text,
	 Id_Anketa = @idank
		 WHERE
		ID_Quest = @IDquest
		
GO

IF OBJECT_ID('dbo.DeleteQuest', 'P') IS NOT NULL DROP PROCEDURE [DeleteQuest]
GO
CREATE PROCEDURE dbo.DeleteQuest
	@Id INT
AS
	DELETE FROM Question WHERE ID_Quest = @Id
GO

/********************************
 *	 QUESTION OFF               *
 ********************************/
 
 IF OBJECT_ID('dbo.CreateSpec', 'P') IS NOT NULL DROP PROCEDURE [CreateSpec]
GO
CREATE PROCEDURE dbo.CreateSpec
	@IDspec Char (3),
	@Text text
AS 
    SET NOCOUNT ON;

	INSERT INTO Specializations
	(		
		Specialization_ID,
		
		Name_Specialization
	)
	SELECT
	@IDspec,
	@Text	
GO

IF OBJECT_ID('dbo.UpdateSpec', 'P') IS NOT NULL DROP PROCEDURE [Updatespec]
GO
CREATE PROCEDURE dbo.UpdateSpec
 @IDspec Char (3),
	@Text text
AS 
    SET NOCOUNT ON;

	UPDATE Specializations SET
	 Name_Specialization =  @Text
		 WHERE
	Specialization_ID = @IDspec
		
GO

IF OBJECT_ID('dbo.DeleteSpec', 'P') IS NOT NULL DROP PROCEDURE [DeleteSpec]
GO
CREATE PROCEDURE dbo.DeleteSpec
	@Id INT
AS
	DELETE FROM Specializations WHERE Specialization_ID = @Id
GO

/********************************
 *	 Specialization OFF         *
 ********************************/
 
  IF OBJECT_ID('dbo.CreateStud', 'P') IS NOT NULL DROP PROCEDURE [CreateStud]
GO
CREATE PROCEDURE dbo.CreateStud
	@IDst Int,
	@Name_stud text,
	@first text,
	@last text,
	@GrNum Char (4)
AS 
    SET NOCOUNT ON;

	INSERT INTO Student
	(		
		Id_Student,
		Name_Stud,
		Firstname_Stud,
		Lastname_Stud,
		Group_Numb
	)
	SELECT
	@IDst,
	@Name_stud,
	@first,
	@last,
	@GrNum	
GO

IF OBJECT_ID('dbo.UpdateStud', 'P') IS NOT NULL DROP PROCEDURE [Updatestud]
GO
CREATE PROCEDURE dbo.UpdateStud
     @IDst Int,
	@Name_stud text,
	@first text,
	@last text,
	@GrNum  Char (4)
AS 
    SET NOCOUNT ON;

	UPDATE Student SET
	 Name_Stud = @Name_stud,
	 Firstname_Stud = @first,
	 Lastname_Stud = @last,
	 Group_Numb = @GrNum
	 
		 WHERE
	Id_Student = @IDst	
GO

IF OBJECT_ID('dbo.DeleteStud', 'P') IS NOT NULL DROP PROCEDURE [DeleteStud]
GO
CREATE PROCEDURE dbo.Deletestud
	@Id INT
AS
	DELETE FROM Student WHERE Id_Student = @Id
GO

/********************************
 *	        STUDENT OFF         *
 ********************************/
 
   IF OBJECT_ID('dbo.Createteach', 'P') IS NOT NULL DROP PROCEDURE [Createteach]
GO
CREATE PROCEDURE dbo.Createteach
	@IDtea Int,
	@Name text,
	@first text,
	@last text
AS 
    SET NOCOUNT ON;

	INSERT INTO Teacher
	(		
		Teacher_ID,
		Name,
		Surname,
		Lastname
	)
	SELECT
	@IDtea,
	@Name,
	@first,
	@last	
GO

IF OBJECT_ID('dbo.Updateteach', 'P') IS NOT NULL DROP PROCEDURE [Updateteach]
GO
CREATE PROCEDURE dbo.Updateteach
   @IDtea Int,
	@Name text,
	@first text,
	@last text
AS 
    SET NOCOUNT ON;

	UPDATE Teacher SET
	 Name = @Name,
	 Surname = @first,
	 Lastname = @last
	 
		 WHERE
	Teacher_ID = @IDtea	
GO

IF OBJECT_ID('dbo.DeleteTeach', 'P') IS NOT NULL DROP PROCEDURE [DeleteTeach]
GO
CREATE PROCEDURE dbo.Deleteteach
	@Id INT
AS
	DELETE FROM Teacher WHERE Teacher_ID = @Id
GO

/********************************
 *	        TEACHER OFF         *
 ********************************/
 
    IF OBJECT_ID('dbo.CreateSubj', 'P') IS NOT NULL DROP PROCEDURE [CreateSubj]
GO
CREATE PROCEDURE dbo.Createsubj
	@Id int,
	@Name text
AS 
    SET NOCOUNT ON;

	INSERT INTO Inst_Subject
	(		
		Subject_ID,
		Name_of_Subject
	)
	SELECT
	@ID,
	@Name	
GO

IF OBJECT_ID('dbo.UpdateSubj', 'P') IS NOT NULL DROP PROCEDURE [UpdateSubj]
GO
CREATE PROCEDURE dbo.UpdateSubj
   @Id int,
	@Name text
AS 
    SET NOCOUNT ON;

	UPDATE inst_Subject SET
	 Name_of_Subject = @Name
		 WHERE
	Subject_ID = @Id
GO

IF OBJECT_ID('dbo.DeleteSubj', 'P') IS NOT NULL DROP PROCEDURE [DeleteSubj]
GO
CREATE PROCEDURE dbo.DeleteSubj
	@Id int
AS
	DELETE FROM inst_Subject WHERE Subject_ID = @Id
GO
/********************************
 *	        Subject OFF         *
 ********************************/
 IF OBJECT_ID('dbo.StudSem', 'P') IS NOT NULL DROP PROCEDURE [StudSem]
GO
CREATE PROCEDURE dbo.StudSem 
	@ID_Student int,
	@Sem int
as
SELECT     dbo.Teacher.Teacher_ID, dbo.Teacher.Surname, dbo.Group_Semestre.Semestre, dbo.Groupnum.Group_Numb, dbo.Student.Id_Student, dbo.Group_Semestre.Number
FROM         dbo.Student INNER JOIN
                      dbo.Groupnum ON dbo.Student.Group_Numb = dbo.Groupnum.Group_Numb INNER JOIN
                      dbo.Group_Semestre ON dbo.Groupnum.Group_Numb = dbo.Group_Semestre.Group_Numb INNER JOIN
                      dbo.Teacher ON dbo.Group_Semestre.Teacher_ID = dbo.Teacher.Teacher_ID
                      where dbo.Student.Id_Student = @ID_Student and dbo.Group_Semestre.Semestre = @Sem                           
GO

GRANT EXECUTE ON dbo.StudSem TO AdminAnk
GO



Grant Select on dbo.Question to AdminAnk
go 

Grant Select on dbo.Student to AdminAnk
go 

Grant Select on dbo.Group_semestre to AdminAnk
go 