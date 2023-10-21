USE queraAlgorithmBootcamp;
GO
-- جدول نمرات کل تمام شرکت کننده ها
SELECT Participant.National_id AS participant_id,Mobile_number,First_name,Last_name,Degree,Register_time, 
(ISNULL(final_exam_score.final_exam_score, 0) + ISNULL(final_HW_score.HWs_score, 0) + ISNULL(final_project_score.project_score, 0)) AS all_scores 
FROM Participant 
FULL OUTER JOIN
(SELECT National_id AS participant_id_1, Exam_score AS final_exam_score FROM Participant) AS final_exam_score
ON Participant.National_id = final_exam_score.participant_id_1
FULL OUTER JOIN 
(SELECT HW_scores.participant_id AS participant_id_2, SUM(HW_scores.score) AS HWs_score 
from (SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, MAX(Final_submissions_hw.Submission_score) AS score 
FROM Final_submissions_hw
 GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores
 GROUP BY HW_scores.participant_id) AS final_HW_score
 ON final_exam_score.participant_id_1 = final_HW_score.participant_id_2
 FULL OUTER join
(SELECT project_scores.participant_id, SUM(project_scores.score) AS project_score 
from (SELECT Final_submissions_project.Submitter_id AS participant_id , Final_submissions_project.Phase_id, MAX(Final_submissions_project.Submission_score) AS score 
FROM Final_submissions_project
GROUP BY Final_submissions_project.Phase_id, Final_submissions_project.Submitter_id) AS project_scores
GROUP BY project_scores.participant_id) AS final_project_score
ON final_HW_score.participant_id_2 = final_project_score.participant_id;

GO
-- انتخاب ۵ نفر برتر بر اساس کل نمرات کسب شده
SELECT TOP 5 Participant.National_id AS participant_id,Mobile_number,First_name,Last_name,Degree,Register_time, 
(ISNULL(final_exam_score.final_exam_score, 0) + ISNULL(final_HW_score.HWs_score, 0) + ISNULL(final_project_score.project_score, 0)) AS all_scores 
FROM Participant 
FULL OUTER JOIN
(SELECT National_id AS participant_id_1, Exam_score AS final_exam_score FROM Participant) AS final_exam_score
ON Participant.National_id = final_exam_score.participant_id_1
FULL OUTER JOIN 
(SELECT HW_scores.participant_id AS participant_id_2, SUM(HW_scores.score) AS HWs_score 
from (SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, MAX(Final_submissions_hw.Submission_score) AS score 
FROM Final_submissions_hw
 GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores
 GROUP BY HW_scores.participant_id) AS final_HW_score
 ON final_exam_score.participant_id_1 = final_HW_score.participant_id_2
 FULL OUTER join
(SELECT project_scores.participant_id, SUM(project_scores.score) AS project_score 
from (SELECT Final_submissions_project.Submitter_id AS participant_id , Final_submissions_project.Phase_id, MAX(Final_submissions_project.Submission_score) AS score 
FROM Final_submissions_project
GROUP BY Final_submissions_project.Phase_id, Final_submissions_project.Submitter_id) AS project_scores
GROUP BY project_scores.participant_id) AS final_project_score
ON final_HW_score.participant_id_2 = final_project_score.participant_id
ORDER BY all_scores DESC;
GO

-- در صورت وجود تابعی با این اسم ابتدا حذف می‌شود تا بعد ساخته شود
DROP PROCEDURE IF EXISTS Get_count_Scores;
GO
-- تعریف تابعی که به عنوان ورودی اسم شرکت کننده را گرفته و در خروجی تعداد تمرین ارسال شده شخص را می دهد.
CREATE PROCEDURE Get_count_ScoresssS
    @participant_id nchar(10)
AS
BEGIN
	SELECT Participant.National_id AS participant_id_1, COUNT(ISNULL(HW_scores.score, 0)) AS HWs_count
    FROM Participant 
    FULL OUTER JOIN 
        (SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, MAX(Final_submissions_hw.Submission_score) AS score 
            FROM Individual_submissions_hw 
            JOIN Final_submissions_hw
            ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id
            GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores
    ON HW_scores.participant_id = Participant.National_id
	WHERE Participant.National_id = @participant_id 
	GROUP BY Participant.National_id
END
GO
EXEC Get_count_ScoresssS @participant_id = '0318960291';
GO

-- در صورت وجود تابعی با این اسم ابتدا حذف می‌شود تا بعد ساخته شود
DROP PROCEDURE IF EXISTS Get_HW_1_2_Scores;
GO
--تابعی که به عنوان ورودی کد ملی شرکت کننده را گرفته و نمرات تمرین اول و دوم را به عنوان خروجی می دهد.
CREATE PROCEDURE Get_HW_1_2_Scores
    @participant_id nchar(10)
AS
BEGIN
	SELECT Participant.National_id AS participant_id_1, SUM(ISNULL(HW_scores.score, 0)) AS score
    FROM Participant 
    FULL OUTER JOIN 
        (SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id,
		MAX(Final_submissions_hw.Submission_score) AS score 
            FROM Individual_submissions_hw 
            JOIN Final_submissions_hw
            ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id
            GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores
    ON HW_scores.participant_id = Participant.National_id
	WHERE Participant.National_id = @participant_id and (Homework_id = N'تمرین یک' or Homework_id = N'تمرین دو')
	GROUP BY Participant.National_id
END
GO
EXEC Get_HW_1_2_Scores @participant_id = '0318960291';
GO

-- در صورت وجود تابعی با این اسم ابتدا حذف می‌شود تا بعد ساخته شود
DROP PROCEDURE IF EXISTS Get_Participant_Scores;
GO

-- تابعی که به عنوان ورودی ک د ملی شرک کننده را گرفته و مجموع نمرات تمرین، پروژه و امتحان فرد را اعلام کند.
CREATE PROCEDURE Get_Participant_Scores
    @participant_id nchar(10)
AS
BEGIN
	SELECT all_scores FROM
    (SELECT Participant.National_id AS participant_id, 
        (ISNULL(final_exam_score.final_exam_score, 0) + ISNULL(final_HW_score.HWs_score, 0) + ISNULL(final_project_score.project_score, 0)) AS all_scores 
    FROM Participant 
    FULL OUTER JOIN
        (SELECT National_id AS participant_id_1, Exam_score AS final_exam_score FROM Participant) AS final_exam_score
    ON Participant.National_id = final_exam_score.participant_id_1
    FULL OUTER JOIN 
        (SELECT HW_scores.participant_id AS participant_id_2, SUM(HW_scores.score) AS HWs_score 
        from (
            SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, MAX(Final_submissions_hw.Submission_score) AS score 
            FROM Individual_submissions_hw 
            JOIN Final_submissions_hw
            ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id
            --WHERE Final_submissions_hw.Submitter_id = @participant_id
            GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores
        GROUP BY HW_scores.participant_id) AS final_HW_score
    ON final_exam_score.participant_id_1 = final_HW_score.participant_id_2
    FULL OUTER JOIN
        (SELECT project_scores.participant_id, SUM(project_scores.score) AS project_score 
        from (
            SELECT Final_submissions_project.Submitter_id AS participant_id , Final_submissions_project.Phase_id, MAX(Final_submissions_project.Submission_score) AS score 
            FROM Final_submissions_project
            GROUP BY Final_submissions_project.Phase_id, Final_submissions_project.Submitter_id) AS project_scores
        GROUP BY project_scores.participant_id) AS final_project_score
    ON final_HW_score.participant_id_2 = final_project_score.participant_id) AS final_table
	WHERE final_table.participant_id = @participant_id
END

EXEC Get_Participant_Scores @participant_id = '3103274061'

GO
-- تعیین سابمیت نهایی برای هر تمرین و پروژه: بر اساس سابمیت های ارسالی، سابمیت با بالاترین نمره به عنوان سابمیت نهایی تعیین می شود.
-- سابمیت‌های نهایی برای تمرین
SELECT I.*
FROM Individual_submissions_hw I
INNER JOIN (
    SELECT Submitter_id, MAX(Submission_score) AS Max_Score
    FROM Individual_submissions_hw
    GROUP BY Submitter_id
) AS S
ON I.Submitter_id = S.Submitter_id AND I.Submission_score = S.Max_Score
GO

-- سابمیت‌های نهایی برای پروژه
SELECT I.*
FROM Individual_submissions_project I
INNER JOIN (
    SELECT Submitter_id, MAX(Submission_score) AS Max_Score
    FROM Individual_submissions_project
    GROUP BY Submitter_id
) AS S
ON I.Submitter_id = S.Submitter_id AND I.Submission_score = S.Max_Score

GO
--درج آزمون نهایی: مشخصات آزمون نهایی مانند تاریخ اجرا و نمره ورودی خواهند بود.
SELECT *, Participant.Exam_score FROM Final_exam
FULL OUTER JOIN Participant
ON Final_exam.Exam_id = Participant.Exam_id
GO
-- انتخاب ۵ نفر اول تمرین بر اساس نمره داده شده به آن‌ها
SELECT TOP 5 Participant.National_id AS participant_id,
SUM(ISNULL(HW_scores.score, 0)) AS HW_score
FROM Participant FULL OUTER JOIN 
(SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, 
MAX(Final_submissions_hw.Submission_score) AS score, 
MAX(Final_submissions_hw.Submission_time) AS Submission_time
FROM Final_submissions_hw  
JOIN Individual_submissions_hw
ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id
GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores
ON HW_scores.participant_id = Participant.National_id
GROUP BY HW_scores.score, Participant.National_id
ORDER BY HW_score DESC;

GO

--انتخاب ۵ نفر اول تمرین بر اساس زمان ارسال آن‌ها
SELECT TOP 5 Participant.National_id AS participant_id,
MAX(HW_scores.Submission_time) AS Submission_time
FROM Participant FULL OUTER JOIN 
(SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, 
MAX(Final_submissions_hw.Submission_score) AS score, 
MAX(Final_submissions_hw.Submission_time) AS Submission_time
FROM Final_submissions_hw  
JOIN Individual_submissions_hw
ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id
GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores
ON HW_scores.participant_id = Participant.National_id
WHERE HW_scores.Submission_time IS NOT NULL
GROUP BY HW_scores.Submission_time, Participant.National_id
ORDER BY HW_scores.Submission_time;

GO

--انتخاب ۵ نفر برتر هر تمرین بر اساس نمره و زمان ارسالی آن‌ها
SELECT TOP 5 Participant.National_id AS participant_id, SUM(ISNULL(HW_scores.score, 0)) AS HW_score,
MAX(HW_scores.Submission_time) AS Submission_time
FROM Participant FULL OUTER JOIN 
(SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, 
MAX(Final_submissions_hw.Submission_score) AS score, 
MAX(Final_submissions_hw.Submission_time) AS Submission_time
FROM Final_submissions_hw  
JOIN Individual_submissions_hw
ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id
GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores
ON HW_scores.participant_id = Participant.National_id
WHERE HW_scores.Submission_time IS NOT NULL
GROUP BY HW_scores.Submission_time, Participant.National_id
ORDER BY HW_score DESC, HW_scores.Submission_time;
GO

-- ساخت تریگر در صورتی که به سابمیت های فردی پروژه اضافه شد جدول سابمیت های نهایی پروژه نیز ‌آپدیت شود.
CREATE TRIGGER trg_AfterInsert_Project
ON Individual_submissions_project
AFTER INSERT AS
BEGIN
   INSERT INTO Final_submissions_project
   SELECT i.*
   FROM inserted i
   LEFT JOIN Final_submissions_project f
      ON f.Submitter_id = i.Submitter_id AND f.Submission_time < i.Submission_time
   WHERE f.Submitter_id IS NULL OR i.Submission_score > f.Submission_score
END;
GO

-- ساخت تریگر در صورتی که به سابمیت های فردی تمرین اضافه شد جدول سابمیت های نهایی تمرین نیز ‌آپدیت شود.
CREATE TRIGGER trg_AfterInsert_HW
ON Individual_submissions_hw
AFTER INSERT AS
BEGIN
   INSERT INTO Final_submissions_hw
   SELECT i.*
   FROM inserted i
   LEFT JOIN Final_submissions_hw f
      ON f.Submitter_id = i.Submitter_id AND f.Submission_time < i.Submission_time
   WHERE f.Submitter_id IS NULL OR i.Submission_score > f.Submission_score
END;
GO
-- ساخت تریگر که در صورتی که به ارسال‌های نهایی پروژه نمره‌ای اضافه شد جدول پذیرفته شدگان در صورت تغییر آپدیت شود
CREATE TRIGGER trg_Final_submissions_project
ON Final_submissions_project
AFTER INSERT
AS
BEGIN
  INSERT INTO Accepted(Accepted_id, All_score)
  SELECT i.Submitter_id, i.Submission_score
  FROM inserted i
  WHERE NOT EXISTS (SELECT 1 FROM Accepted a WHERE a.Accepted_id = i.Submitter_id)
END
GO 

-- ساخت تریگر که در صورتی که به ارسال‌های نهایی تمرین نمره ‌ای اضافه شد جدول پذیرفته شدگان در صورت تغییر آپدیت شود
CREATE TRIGGER trg_Final_submissions_hw
ON Final_submissions_hw
AFTER INSERT
AS
BEGIN
  INSERT INTO Accepted(Accepted_id, All_score)
  SELECT i.Submitter_id, i.Submission_score
  FROM inserted i
  WHERE NOT EXISTS (SELECT 1 FROM Accepted a WHERE a.Accepted_id = i.Submitter_id)
END

