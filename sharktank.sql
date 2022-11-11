SELECT * FROM sharktank.dbo.data1;

--Total Number of Episodes

SELECT COUNT(DISTINCT [Ep# No#]) FROM sharktank.dbo.data1;
SELECT MAX([Ep# No#]) FROM sharktank.dbo.data1;

--Total Number of Pitches

SELECT COUNT(Brand) FROM sharktank.dbo.data1;

--Total Number of Pitches That Got Funding

SELECT COUNT([Amount Invested lakhs]) FROM sharktank.dbo.data1
WHERE [Amount Invested lakhs] > 0;

SELECT SUM(a.converted_or_not) AS converted_pitches, COUNT(Brand) AS total_pitches FROM
(SELECT Brand, Idea, [Amount Invested lakhs], CASE WHEN [Amount Invested lakhs]>0 THEN 1 ELSE 0 END AS converted_or_not FROM sharktank.dbo.data1) a;

--Total Converted Percentage

SELECT (CAST(SUM(a.converted_or_not) AS FLOAT)/ CAST(COUNT(Brand) AS FLOAT))*100 FROM
(SELECT Brand, Idea, [Amount Invested lakhs], CASE WHEN [Amount Invested lakhs]>0 THEN 1 ELSE 0 END AS converted_or_not FROM sharktank.dbo.data1) a;

--Total Number of Male and Female Participants

SELECT a.male_participants, a.female_participants,(a.female_participants/a.male_participants)*100 AS gender_ratio FROM
(SELECT SUM(Male) AS male_participants, SUM(Female) AS female_participants FROM sharktank.dbo.data1) a

--Total Invested Amount

SELECT SUM([Amount Invested lakhs]) AS total_invested_amount FROM sharktank.dbo.data1;

--Average Equity Taken

SELECT AVG([Equity Taken %]) AS average_equity_taken FROM sharktank.dbo.data1
WHERE [Equity Taken %] > 0;

--Highest Deal Taken

SELECT MAX([Amount Invested lakhs]) AS Highest Deal FROM sharktank.dbo.data1;

--HIghest Equity Taken

SELECT MAX([Equity Taken %]) AS max_equity_taken FROM sharktank.dbo.data1;

--All the pitches that has atleast one women contestant

SELECT Brand, Female, Idea FROM sharktank.dbo.data1
WHERE Female > 0;

SELECT COUNT(Brand) FROM sharktank.dbo.data1
WHERE Female > 0;

SELECT SUM(a.Female_Presence) FROM
(SELECT Female, CASE WHEN Female > 0 Then 1 ELSE 0 END AS Female_Presence
FROM sharktank.dbo.data1) a;

--Pitches that are converted and have atleast one woman in it.

SELECT COUNT(Brand) AS Female_pitches_converted FROM sharktank.dbo.data1
WHERE [Amount Invested lakhs] > 0
AND Female >0;

--Average Team Members

SELECT AVG([Team members]) FROM sharktank.dbo.data1;

--Average Amount Invested for Succesful Deal

SELECT AVG([Amount Invested lakhs]) FROM sharktank.dbo.data1
WHERE Deal != 'No Deal';

--Age group particpated in Sharktank india the most

SELECT [Avg age], COUNT([Avg age]) AS counts FROM sharktank.dbo.data1
GROUP BY [Avg age]
ORDER BY counts DESC;

--The location from where most number of pitches came

SELECT [Location], COUNT([Location]) AS counts
FROM sharktank.dbo.data1
GROUP BY [Location]
ORDER BY counts DESC;

--Sector from which most number of deals came

SELECT Sector, COUNT(Sector) AS counts FROM sharktank.dbo.data1
GROUP BY Sector
ORDER BY counts DESC;

--Partner Deals

SELECT Partners, COUNT(Partners) AS partner_count FROM sharktank.dbo.data1 
WHERE Partners !='-'
GROUP BY partners
ORDER BY partner_count DESC;

--Making The Matrix of Sharks

--Total Number of Deals Ashneer Was Present

SELECT 'Ashneer' AS sharkkey,COUNT([Ashneer Amount Invested]) AS Ashneel_Episode_Count FROM sharktank.dbo.data1
WHERE [Ashneer Amount Invested] IS NOT NULL;

--Number Of Pitches Ashneer Invested

SELECT 'Ashneer' AS sharkkey,COUNT([Ashneer Amount Invested]) AS Ashneel_Invested_Count FROM sharktank.dbo.data1
WHERE [Ashneer Amount Invested] > 0;

--Total Amount Invested and Avg Equity By Ashneel

SELECT 'Ashneer' AS sharkkey,SUM([Ashneer Amount Invested]) AS Ashneel_Total_Amount_Invested, AVG([Ashneer Equity Taken %]) AS Avg_Equity_Ashneer FROM sharktank.dbo.data1
WHERE [Ashneer Amount Invested] > 0;

--Ashneer Matrix

SELECT c.sharkkey, c.Ashneer_Episode_Count,c.Ashneer_Invested_Count, d.Ashneer_Total_Amount_Invested, d.Avg_Equity_Ashneer FROM
(SELECT a.sharkkey, a.Ashneer_Episode_Count,b.Ashneer_Invested_Count FROM
(SELECT 'Ashneer' AS sharkkey,COUNT([Ashneer Amount Invested]) AS Ashneer_Episode_Count FROM sharktank.dbo.data1
WHERE [Ashneer Amount Invested] IS NOT NULL) a

INNER JOIN

(SELECT 'Ashneer' AS sharkkey,COUNT([Ashneer Amount Invested]) AS Ashneer_Invested_Count FROM sharktank.dbo.data1
WHERE [Ashneer Amount Invested] > 0) b

ON a.sharkkey = b.sharkkey ) c

INNER JOIN

(SELECT 'Ashneer' AS sharkkey,SUM([Ashneer Amount Invested]) AS Ashneer_Total_Amount_Invested, AVG([Ashneer Equity Taken %]) AS Avg_Equity_Ashneer FROM sharktank.dbo.data1
WHERE [Ashneer Amount Invested] > 0) d

ON c.sharkkey = d.sharkkey

--Total Number of Deals Namita Was Present

SELECT COUNT([Namita Amount Invested]) FROM sharktank.dbo.data1
WHERE [Namita Amount Invested] IS NOT NULL;

--Number Of Pitches Namita Invested

SELECT COUNT([Namita Amount Invested]) FROM sharktank.dbo.data1
WHERE [Namita Amount Invested] > 0;

--Total Amount Invested and Avg Equity By Namita

SELECT SUM([Namita Amount Invested]), AVG([Namita Equity Taken %]) FROM sharktank.dbo.data1
WHERE [Namita Amount Invested] > 0;

--Namita Matrix

SELECT c.sharkkey, c.Namita_Episode_Count, c.Namita_Invested_Count,d.Namita_Total_Amount_Invested,d.Avg_Equity_Namita FROM
(SELECT a.sharkkey,a.Namita_Episode_Count,b.Namita_Invested_Count FROM
(SELECT 'Namita' AS sharkkey, COUNT([Namita Amount Invested]) AS Namita_Episode_Count FROM sharktank.dbo.data1
WHERE [Namita Amount Invested] IS NOT NULL) a

INNER JOIN

(SELECT 'Namita' AS sharkkey,COUNT([Namita Amount Invested]) AS Namita_Invested_Count FROM sharktank.dbo.data1
WHERE [Namita Amount Invested] > 0)b

ON a.sharkkey = b.sharkkey) c

INNER JOIN

(SELECT 'Namita' AS sharkkey,SUM([Namita Amount Invested]) AS Namita_Total_Amount_Invested, AVG([Namita Equity Taken %]) AS Avg_Equity_Namita FROM sharktank.dbo.data1
WHERE [Namita Amount Invested] > 0) d

ON c.sharkkey = d.sharkkey;

--Anupam Matrix

SELECT c.sharkkey, c.Anupam_Episode_Count, c.Anupam_Invested_Count,d.Anupam_Total_Amount_Invested,d.Avg_Equity_Anupam FROM
(SELECT a.sharkkey,a.Anupam_Episode_Count,b.Anupam_Invested_Count FROM
(SELECT 'Anupam' AS sharkkey, COUNT([Anupam Amount Invested]) AS Anupam_Episode_Count FROM sharktank.dbo.data1
WHERE [Anupam Amount Invested] IS NOT NULL) a

INNER JOIN

(SELECT 'Anupam' AS sharkkey,COUNT([Anupam Amount Invested]) AS Anupam_Invested_Count FROM sharktank.dbo.data1
WHERE [Anupam Amount Invested] > 0)b

ON a.sharkkey = b.sharkkey) c

INNER JOIN

(SELECT 'Anupam' AS sharkkey,SUM([Anupam Amount Invested]) AS Anupam_Total_Amount_Invested, AVG([Anupam Equity Taken %]) AS Avg_Equity_Anupam FROM sharktank.dbo.data1
WHERE [Anupam Amount Invested] > 0) d

ON c.sharkkey = d.sharkkey;

--Vineeta Matrix

SELECT c.sharkkey, c.Vineeta_Episode_Count, c.Vineeta_Invested_Count,d.Vineeta_Total_Amount_Invested,d.Avg_Equity_Vineeta FROM
(SELECT a.sharkkey,a.Vineeta_Episode_Count,b.Vineeta_Invested_Count FROM
(SELECT 'Vineeta' AS sharkkey, COUNT([Vineeta Amount Invested]) AS Vineeta_Episode_Count FROM sharktank.dbo.data1
WHERE [Vineeta Amount Invested] IS NOT NULL) a

INNER JOIN

(SELECT 'Vineeta' AS sharkkey,COUNT([Vineeta Amount Invested]) AS Vineeta_Invested_Count FROM sharktank.dbo.data1
WHERE [Vineeta Amount Invested] > 0)b

ON a.sharkkey = b.sharkkey) c

INNER JOIN

(SELECT 'Vineeta' AS sharkkey,SUM([Vineeta Amount Invested]) AS Vineeta_Total_Amount_Invested, AVG([Vineeta Equity Taken %]) AS Avg_Equity_Vineeta FROM sharktank.dbo.data1
WHERE [Vineeta Amount Invested] > 0) d

ON c.sharkkey = d.sharkkey;

--Aman Matrix

SELECT c.sharkkey, c.Aman_Episode_Count, c.Aman_Invested_Count,d.Aman_Total_Amount_Invested,d.Avg_Equity_Aman FROM
(SELECT a.sharkkey,a.Aman_Episode_Count,b.Aman_Invested_Count FROM
(SELECT 'Aman' AS sharkkey, COUNT([Aman Amount Invested]) AS Aman_Episode_Count FROM sharktank.dbo.data1
WHERE [Aman Amount Invested] IS NOT NULL) a

INNER JOIN

(SELECT 'Aman' AS sharkkey,COUNT([Aman Amount Invested]) AS Aman_Invested_Count FROM sharktank.dbo.data1
WHERE [Aman Amount Invested] > 0)b

ON a.sharkkey = b.sharkkey) c

INNER JOIN

(SELECT 'Aman' AS sharkkey,SUM([Aman Amount Invested]) AS Aman_Total_Amount_Invested, AVG([Aman Equity Taken %]) AS Avg_Equity_Aman FROM sharktank.dbo.data1
WHERE [Aman Amount Invested] > 0) d

ON c.sharkkey = d.sharkkey;

--COMBINED MATRIX

--Ashneer Matrix

SELECT c.sharkkey, c.Ashneer_Episode_Count,c.Ashneer_Invested_Count, d.Ashneer_Total_Amount_Invested, d.Avg_Equity_Ashneer FROM
(SELECT a.sharkkey, a.Ashneer_Episode_Count,b.Ashneer_Invested_Count FROM
(SELECT 'Ashneer' AS sharkkey,COUNT([Ashneer Amount Invested]) AS Ashneer_Episode_Count FROM sharktank.dbo.data1
WHERE [Ashneer Amount Invested] IS NOT NULL) a

INNER JOIN

(SELECT 'Ashneer' AS sharkkey,COUNT([Ashneer Amount Invested]) AS Ashneer_Invested_Count FROM sharktank.dbo.data1
WHERE [Ashneer Amount Invested] > 0) b

ON a.sharkkey = b.sharkkey ) c

INNER JOIN

(SELECT 'Ashneer' AS sharkkey,SUM([Ashneer Amount Invested]) AS Ashneer_Total_Amount_Invested, AVG([Ashneer Equity Taken %]) AS Avg_Equity_Ashneer FROM sharktank.dbo.data1
WHERE [Ashneer Amount Invested] > 0) d

ON c.sharkkey = d.sharkkey 

UNION

--Namita Matrix

SELECT c.sharkkey, c.Namita_Episode_Count, c.Namita_Invested_Count,d.Namita_Total_Amount_Invested,d.Avg_Equity_Namita FROM
(SELECT a.sharkkey,a.Namita_Episode_Count,b.Namita_Invested_Count FROM
(SELECT 'Namita' AS sharkkey, COUNT([Namita Amount Invested]) AS Namita_Episode_Count FROM sharktank.dbo.data1
WHERE [Namita Amount Invested] IS NOT NULL) a

INNER JOIN

(SELECT 'Namita' AS sharkkey,COUNT([Namita Amount Invested]) AS Namita_Invested_Count FROM sharktank.dbo.data1
WHERE [Namita Amount Invested] > 0)b

ON a.sharkkey = b.sharkkey) c

INNER JOIN

(SELECT 'Namita' AS sharkkey,SUM([Namita Amount Invested]) AS Namita_Total_Amount_Invested, AVG([Namita Equity Taken %]) AS Avg_Equity_Namita FROM sharktank.dbo.data1
WHERE [Namita Amount Invested] > 0) d

ON c.sharkkey = d.sharkkey

UNION

--Vineeta Matrix

SELECT c.sharkkey, c.Vineeta_Episode_Count, c.Vineeta_Invested_Count,d.Vineeta_Total_Amount_Invested,d.Avg_Equity_Vineeta FROM
(SELECT a.sharkkey,a.Vineeta_Episode_Count,b.Vineeta_Invested_Count FROM
(SELECT 'Vineeta' AS sharkkey, COUNT([Vineeta Amount Invested]) AS Vineeta_Episode_Count FROM sharktank.dbo.data1
WHERE [Vineeta Amount Invested] IS NOT NULL) a

INNER JOIN

(SELECT 'Vineeta' AS sharkkey,COUNT([Vineeta Amount Invested]) AS Vineeta_Invested_Count FROM sharktank.dbo.data1
WHERE [Vineeta Amount Invested] > 0)b

ON a.sharkkey = b.sharkkey) c

INNER JOIN

(SELECT 'Vineeta' AS sharkkey,SUM([Vineeta Amount Invested]) AS Vineeta_Total_Amount_Invested, AVG([Vineeta Equity Taken %]) AS Avg_Equity_Vineeta FROM sharktank.dbo.data1
WHERE [Vineeta Amount Invested] > 0) d

ON c.sharkkey = d.sharkkey

UNION

--Aman Matrix

SELECT c.sharkkey, c.Aman_Episode_Count, c.Aman_Invested_Count,d.Aman_Total_Amount_Invested,d.Avg_Equity_Aman FROM
(SELECT a.sharkkey,a.Aman_Episode_Count,b.Aman_Invested_Count FROM
(SELECT 'Aman' AS sharkkey, COUNT([Aman Amount Invested]) AS Aman_Episode_Count FROM sharktank.dbo.data1
WHERE [Aman Amount Invested] IS NOT NULL) a

INNER JOIN

(SELECT 'Aman' AS sharkkey,COUNT([Aman Amount Invested]) AS Aman_Invested_Count FROM sharktank.dbo.data1
WHERE [Aman Amount Invested] > 0)b

ON a.sharkkey = b.sharkkey) c

INNER JOIN

(SELECT 'Aman' AS sharkkey,SUM([Aman Amount Invested]) AS Aman_Total_Amount_Invested, AVG([Aman Equity Taken %]) AS Avg_Equity_Aman FROM sharktank.dbo.data1
WHERE [Aman Amount Invested] > 0) d

ON c.sharkkey = d.sharkkey;

--TOP 3 Startups that got highest investment from each sector

SELECT a.* FROM
(SELECT Brand, Sector, [Amount Invested lakhs], RANK() OVER(PARTITION BY Sector ORDER BY [Amount Invested lakhs] DESC) AS rnk FROM sharktank.dbo.data1) a
WHERE rnk < 4;
