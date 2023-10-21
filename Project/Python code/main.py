import pyodbc

# set up the connection string
# you can run this query on sql server to find your server name: SELECT @@ServerName
# don't run this project in vscode =)
server = 'DESKTOP-4F0IPHD\M'
database = 'queraAlgorithmBootcamp'
cnxn_str = 'DRIVER={SQL Server};SERVER=' + server + ';DATABASE=' + database + ';Trusted_Connection=yes;'

# connect to the database
cnxn = pyodbc.connect(cnxn_str)
cursor = cnxn.cursor()


def run_query(strr, file_name, cursor, cnxn):
    query = strr
    cursor.execute(query)
    rows = cursor.fetchall()
    columns = [column[0] for column in cursor.description]
    print(columns)
    for row in rows:
        print(list(row))
    with open(f'{file_name}.txt', 'w', encoding='utf-8') as file:
        file.write('| ')
        for col in columns:
            file.write(str(col) + ' |')
        file.write('\n')
        for row in rows:
            file.write(str(row) + '\n')
    cursor.close()
    cnxn.close()

# Execute queries
# Q = "SELECT * FROM Company"
# Q = "SELECT * FROM Company"
# Q = "SELECT * FROM Final_exam"
# Q = "SELECT * FROM Final_submission"
# Q = "SELECT * FROM Final_exam"
# Q = "SELECT * FROM Individual_submissions_shw"
# Q = "SELECT * FROM Mentors"
# Q = "SELECT * FROM Participant"
# Q = "SELECT * FROM Project"
# Q = "SELECT * FROM Registered_people"

# ----------------------------------------------------------------------------------------------------------------------
# بالاترین نمره‌ی تمرین اول
# Q = "SELECT MAX(Submission_score) AS MaxScore, Submitter_id FROM Individual_submissions_hw " \
#      "WHERE Homework_id = N'تمرین یک' GROUP BY"  \
#      "Submitter_id;"
# file_name = 'best_scores_of_hw1'

# ----------------------------------------------------------------------------------------------------------------------
# noinspection SqlNoDataSourceInspection
# جدول نمرات کل تمام شرکت کننده ها
# Q = "SELECT Participant.National_id AS participant_id,Mobile_number,First_name,Last_name,Degree,Register_time, \
# (ISNULL(final_exam_score.final_exam_score, 0) + ISNULL(final_HW_score.HWs_score, 0) + \
# ISNULL(final_project_score.project_score, 0)) AS all_scores \
# FROM Participant \
# FULL OUTER JOIN \
# (SELECT National_id AS participant_id_1, Exam_score AS final_exam_score FROM Participant) AS final_exam_score \
# ON Participant.National_id = final_exam_score.participant_id_1 \
# FULL OUTER JOIN \
# (SELECT HW_scores.participant_id AS participant_id_2, SUM(HW_scores.score) AS HWs_score \
# from (SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, \
# MAX(Final_submissions_hw.Submission_score) AS score \
# FROM Final_submissions_hw \
#  GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores \
#  GROUP BY HW_scores.participant_id) AS final_HW_score \
#  ON final_exam_score.participant_id_1 = final_HW_score.participant_id_2 \
#  FULL OUTER join \
# (SELECT project_scores.participant_id, SUM(project_scores.score) AS project_score \
# from (SELECT Final_submissions_project.Submitter_id AS participant_id , Final_submissions_project.Phase_id,\
# MAX(Final_submissions_project.Submission_score) AS score \
# FROM Final_submissions_project \
# GROUP BY Final_submissions_project.Phase_id, Final_submissions_project.Submitter_id) AS project_scores \
# GROUP BY project_scores.participant_id) AS final_project_score \
# ON final_HW_score.participant_id_2 = final_project_score.participant_id;"
# file_name = 'allـparticipantsـscore'

# -----------------------------------------------------------------------------------------------------------------------
# انتخاب ۵ نفر برتر بر اساس کل نمرات کسب شده
# noinspection SqlDialectInspection
# Q = "SELECT TOP 5 Participant.National_id AS participant_id,Mobile_number,First_name,Last_name,Degree,Register_time, \
# (ISNULL(final_exam_score.final_exam_score, 0) + ISNULL(final_HW_score.HWs_score, 0) + \
# ISNULL(final_project_score.project_score, 0)) AS all_scores \
# FROM Participant \
# FULL OUTER JOIN \
# (SELECT National_id AS participant_id_1, Exam_score AS final_exam_score FROM Participant) AS final_exam_score \
# ON Participant.National_id = final_exam_score.participant_id_1 \
# FULL OUTER JOIN \
# (SELECT HW_scores.participant_id AS participant_id_2, SUM(HW_scores.score) AS HWs_score \
# from (SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, \
# MAX(Final_submissions_hw.Submission_score) AS score \
# FROM Final_submissions_hw \
#  GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores \
#  GROUP BY HW_scores.participant_id) AS final_HW_score \
#  ON final_exam_score.participant_id_1 = final_HW_score.participant_id_2 \
#  FULL OUTER join \
# (SELECT project_scores.participant_id, SUM(project_scores.score) AS project_score \
# from (SELECT Final_submissions_project.Submitter_id AS participant_id , Final_submissions_project.Phase_id, \
# MAX(Final_submissions_project.Submission_score) AS score \
# FROM Final_submissions_project \
# GROUP BY Final_submissions_project.Phase_id, Final_submissions_project.Submitter_id) AS project_scores \
# GROUP BY project_scores.participant_id) AS final_project_score \
# ON final_HW_score.participant_id_2 = final_project_score.participant_id \
# ORDER BY all_scores DESC;"
# file_name = 'tops_5_score'

# ----------------------------------------------------------------------------------------------------------------------
# تابعی که به عنوان ورودی اسم شرکت کننده را گرفته و در خروجی تعداد تمرین ارسال شده شخص را می دهد.
# Q = "EXEC Get_count_Scores @participant_id = '0318960291';"
# file_name = 'Get_count_Scores'


# ----------------------------------------------------------------------------------------------------------------------
# تابعی که به عنوان ورودی کد ملی شرکت کننده را گرفته و نمرات تمرین اول و دوم را به عنوان خروجی می دهد.
# Q = "EXEC Get_HW_1_2_Scores @participant_id = '0318960291';"
# file_name = 'Get_HW_1_2_Scores'

# ----------------------------------------------------------------------------------------------------------------------
# تابعی که به عنوان ورودی ک د ملی شرک کننده را گرفته و مجموع نمرات تمرین، پروژه و امتحان فرد را اعلام کند.
# Q = "EXEC Get_Participant_Scores @participant_id = '3103274061'"
# file_name = 'Get_Participant_Scores'

# ----------------------------------------------------------------------------------------------------------------------
# سابمیت های نهایی برای تمرین
# noinspection SqlNoDataSourceInspection
# Q = "SELECT I.* \
# FROM Individual_submissions_hw I \
# INNER JOIN ( \
#     SELECT Submitter_id, MAX(Submission_score) AS Max_Score \
#     FROM Individual_submissions_hw \
#     GROUP BY Submitter_id \
# ) AS S \
# ON I.Submitter_id = S.Submitter_id AND I.Submission_score = S.Max_Score"
# file_name = 'final_HW_submissions'

# ----------------------------------------------------------------------------------------------------------------------
# سابمیت های نهایی برای پروژه
# noinspection SqlNoDataSourceInspection
# Q = "SELECT I.* \
# FROM Individual_submissions_project I \
# INNER JOIN ( \
#     SELECT Submitter_id, MAX(Submission_score) AS Max_Score \
#     FROM Individual_submissions_project \
#     GROUP BY Submitter_id \
# ) AS S \
# ON I.Submitter_id = S.Submitter_id AND I.Submission_score = S.Max_Score"
# file_name = 'final_project_submissions'


# ----------------------------------------------------------------------------------------------------------------------
# درج آزمون نهایی: مشخصات آزمون نهایی مانند تاریخ اجرا و نمره ورودی خواهند بود.
# noinspection SqlNoDataSourceInspection
# Q = "SELECT *, Participant.Exam_score FROM Final_exam \
# FULL OUTER JOIN Participant \
# ON Final_exam.Exam_id = Participant.Exam_id"
# file_name = 'final_exam_details'

# ----------------------------------------------------------------------------------------------------------------------
# انتخاب ۵ نفر اول تمرین بر اساس نمره داده شده به آن‌ها
# noinspection SqlNoDataSourceInspection
# Q = "SELECT TOP 5 Participant.National_id AS participant_id, \
# SUM(ISNULL(HW_scores.score, 0)) AS HW_score \
# FROM Participant FULL OUTER JOIN \
# (SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, \
# MAX(Final_submissions_hw.Submission_score) AS score, \
# MAX(Final_submissions_hw.Submission_time) AS Submission_time \
# FROM Final_submissions_hw  \
# JOIN Individual_submissions_hw \
# ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id \
# GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores \
# ON HW_scores.participant_id = Participant.National_id \
# GROUP BY HW_scores.score, Participant.National_id \
# ORDER BY HW_score DESC;"
# file_name = 'top_5_HWs'

# ----------------------------------------------------------------------------------------------------------------------
# انتخاب ۵ نفر اول تمرین بر اساس زمان ارسال آن‌ها
# noinspection SqlNoDataSourceInspection
# Q = "SELECT TOP 5 Participant.National_id AS participant_id, \
# MAX(HW_scores.Submission_time) AS Submission_time \
# FROM Participant FULL OUTER JOIN \
# (SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, \
# MAX(Final_submissions_hw.Submission_score) AS score, \
# MAX(Final_submissions_hw.Submission_time) AS Submission_time \
# FROM Final_submissions_hw  \
# JOIN Individual_submissions_hw \
# ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id \
# GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores \
# ON HW_scores.participant_id = Participant.National_id \
# WHERE HW_scores.Submission_time IS NOT NULL \
# GROUP BY HW_scores.Submission_time, Participant.National_id \
# ORDER BY HW_scores.Submission_time;"
# file_name = 'top_5_HWs_time'

# ----------------------------------------------------------------------------------------------------------------------
# انتخاب ۵ نفر برتر هر تمرین بر اساس نمره و زمان ارسالی آن‌ها
Q = "SELECT TOP 5 Participant.National_id AS participant_id, SUM(ISNULL(HW_scores.score, 0)) AS HW_score, \
MAX(HW_scores.Submission_time) AS Submission_time \
FROM Participant FULL OUTER JOIN  \
(SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id,  \
MAX(Final_submissions_hw.Submission_score) AS score, \
MAX(Final_submissions_hw.Submission_time) AS Submission_time \
FROM Final_submissions_hw  \
JOIN Individual_submissions_hw \
ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id \
GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores \
ON HW_scores.participant_id = Participant.National_id \
WHERE HW_scores.Submission_time IS NOT NULL \
GROUP BY HW_scores.Submission_time, Participant.National_id \
ORDER BY HW_score DESC, HW_scores.Submission_time;"
file_name = 'top_5_HWs_time_score'

query_Company = run_query(Q, file_name, cursor, cnxn)
