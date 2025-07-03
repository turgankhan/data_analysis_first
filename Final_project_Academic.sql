

# TASK 1

  CREATE DATABASE users_adverts;
  
  
    USE users_adverts;
    
    
    CREATE TABLE users(
	date DATE,
    user_id VARCHAR(40),
    view_adverts INT);
    
    
	# SUBTASK 1
  
    SELECT COUNT(distinct user_id) as counter_unique
    FROM users
    WHERE date between '2023-11-07' and ' 2023-11-15';
    
    
    # SUBTASK 2
    
    SELECT user_id, SUM(view_adverts) as total_view
    FROM users
    GROUP BY user_id
    ORDER BY total_view DESC
    LIMIT 1;
   
    
    
    
    # SUBTASK 3
SELECT date
FROM (
    SELECT date,
           SUM(view_adverts) / COUNT(DISTINCT user_id) AS avg_views
    FROM users
    GROUP BY date
    HAVING COUNT(DISTINCT user_id) > 500
) AS t
ORDER BY avg_views DESC
LIMIT 1;

    # SUBTASK 4
    
    
	SELECT user_id, (MAX(date)-MIN(date)) as LT
    FROM users
    GROUP BY user_id
    ORDER BY LT DESC;
   
   
   # SUBTASK 5
   
   # for all users
	SELECT user_id, ROUND(SUM(view_adverts)/COUNT(date),2) as avg_per_day
    FROM users 
    GROUP BY user_id
    HAVING COUNT(date) > 5; 
   
   
   # top user
	SELECT user_id, ROUND(SUM(view_adverts)/COUNT(date),2) as avg_per_day
    FROM users 
    GROUP BY user_id
    HAVING COUNT(date) > 5
    ORDER BY avg_per_day DESC
    LIMIT 1;
    
    
    
# TASK 2


	 CREATE DATABASE  mini_project;
	 
	 USE mini_project;
     
     
	 CREATE TABLE T_TAB1(
	ID INT UNIQUE,
	GOODS_TYPE VARCHAR(20),
	QUANTITY INT,
	AMOUNT INT,
	SELLER_NAME VARCHAR(20) 
	 );
	 
	 
	 SELECT * FROM T_TAB1;
	 
	 INSERT INTO T_TAB1 (ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME)
	 VALUES (1,'MOBILE PHONE',2,400000,'MIKE'),
	(2,'KEYBOARD',1, 10000, 'MIKE' ),
	(3,'MOBILE PHONE', 1,50000, 'JANE'),
	(4,'MONITOR',1,110000,'JOE'),
	(5,'MONITOR',2,80000,'JANE'),
	(6,'MOBILE PHONE',1,130000,'JOE'),
	(7,'MOBILE PHONE',1,60000,'ANNA'),
	(8,'PRINTER',1,90000,'ANNA'),
	(9,'KEYBOARD',2,10000,'ANNA'),
	(10,'PRINTER',1,80000,'MIKE');

	CREATE TABLE T_TAB2(
	ID INT UNIQUE,
	NAME VARCHAR(20),
	SALARY INT,
	AGE INT
	);

 INSERT INTO T_TAB2 (ID,NAME,SALARY,AGE)
 VALUES (1,'ANNA',110000,27),
 (2,'JANE',80000,25),
 (3,'MIKE',120000,25),
 (4,'JOE',70000,24),
 (5,'RITA',120000,29);
 
 SELECT * FROM T_TAB2;
 
 
 # SUBTASK 1
 # 4 уникальные категории
	SELECT DISTINCT GOODS_TYPE FROM T_TAB1;
	SELECT COUNT(DISTINCT GOODS_TYPE) FROM T_TAB1;



# SUBTASK 2

# answer: '5', '640000'


	SELECT SUM(QUANTITY) as total_q,SUM(AMOUNT) as total_sum FROM T_TAB1
	WHERE GOODS_TYPE = 'MOBILE PHONE'
	GROUP BY GOODS_TYPE;

# SUBTASK 3 

# answer: 3

	SELECT NAME 
	FROM T_TAB2
	WHERE SALARY > 100000;
    
# SUBTASK 4

SELECT MIN(AGE),MAX(AGE), MIN(SALARY), MAX(SALARY) 
FROM T_TAB2;


# SUBTASK 5 

SELECT GOODS_TYPE, AVG(QUANTITY)
FROM T_TAB1
WHERE GOODS_TYPE = 'KEYBOARD' OR GOODS_TYPE = 'PRINTER'
GROUP BY GOODS_TYPE;

# SUBTASK 6

SELECT SELLER_NAME, SUM(AMOUNT)
FROM T_TAB1
GROUP BY SELLER_NAME;

# SUBTASK 7

SELECT t2.NAME, t.GOODS_TYPE,t.QUANTITY,t.AMOUNT,t2.SALARY,
(SELECT AGE FROM T_TAB2 WHERE NAME ='MIKE') as MIKEs_age
 FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name = t.seller_name;

# SUBTASK 8 
# 1 сотрудник

SELECT NAME FROM T_TAB2
WHERE NAME NOT IN (SELECT SELLER_NAME FROM T_TAB1);

# SUBTASK 9

# 3 сотрудника

SELECT NAME, SALARY FROM T_TAB2
WHERE AGE < 26;

# SUBTASK 10

# 0 потому что Рита отсутствует в первой таблице 

SELECT * FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA';



