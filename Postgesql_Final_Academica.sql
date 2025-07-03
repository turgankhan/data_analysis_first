SELECT * FROM audiobooks;

SELECT * FROM audio_cards;

SELECT * FROM listenings LIMIT 100;


-- TASK 1 
-- Кол-во пользователей добавивших книгу Coraline
SELECT COUNT(DISTINCT l.user_id) 
FROM listenings l
JOIN audiobooks a ON a.uuid = l.audiobook_uuid
WHERE a.title = 'Coraline'; 




-- Кол-во пользователей добавивших книгу Coraline и прослушавших больше 10%


SELECT COUNT(DISTINCT ac.user_id)
FROM listenings l
JOIN audiobooks a ON a.uuid = l.audiobook_uuid
JOIN audio_cards ac ON ac.user_id = l.user_id AND ac.audiobook_uuid = l.audiobook_uuid
WHERE a.title = 'Coraline' and ac.progress/a.duration > 0.1; 

SELECT COUNT(DISTINCT ac.user_id) AS users_added_Coraline, COUNT(DISTINCT users_listened.user_id) AS users_listened_more_than_10_percent_of_Coraline
FROM audio_cards ac
JOIN audiobooks ab ON ac.audiobook_uuid = ab.uuid
LEFT JOIN (SELECT l.user_id, l.audiobook_uuid
FROM listenings l
JOIN audiobooks ab ON l.audiobook_uuid = ab.uuid
WHERE ab.title = 'Coraline'
GROUP BY l.user_id, ab.duration, l.audiobook_uuid
HAVING SUM(l.position_to - l.position_from) > 0.1 * ab.duration)
AS users_listened ON ac.user_id = users_listened.user_id
WHERE ab.title = 'Coraline';
-- TASK 2

SELECT l.os_name, a.title, COUNT(DISTINCT l.user_id) as total_user_count, ROUND(SUM((position_to-position_from)*speed_multiplier)::numeric/3600.0,2) as hours_listened
FROM listenings l
JOIN audiobooks a ON l.audiobook_uuid = a.uuid
WHERE is_test = 0
GROUP BY l.os_name, a.title;



-- TASK 3

SELECT a.title, COUNT(DISTINCT l.user_id) as total_user_count
FROM listenings l
JOIN audiobooks a ON l.audiobook_uuid = a.uuid
WHERE is_test = 0
GROUP BY  a.title
ORDER BY total_user_count DESC
LIMIT 1;


-- TASK 4



SELECT 
  a.title,
  COUNT(CASE WHEN ac.state = 'finished' THEN 1 END) AS finished_count,
  COUNT(CASE WHEN ac.state = 'listening' THEN 1 END) AS listening_count,
  ROUND(
    COUNT(CASE WHEN ac.state = 'finished' THEN 1 END) * 1.0 /
    NULLIF(COUNT(CASE WHEN ac.state = 'listening' THEN 1 END),0), 2
  ) AS finish_ratio
FROM audiobooks a
JOIN audio_cards ac ON a.uuid = ac.audiobook_uuid
GROUP BY a.title
ORDER BY finish_ratio DESC;



-- TOP 1 by finish rate
SELECT 
  a.title,
  COUNT(CASE WHEN ac.state = 'finished' THEN 1 END) AS finished_count,
  COUNT(CASE WHEN ac.state = 'listening' THEN 1 END) AS listening_count,
  ROUND(
    COUNT(CASE WHEN ac.state = 'finished' THEN 1 END) * 1.0 /
    NULLIF(COUNT(CASE WHEN ac.state = 'listening' THEN 1 END), 0), 2
  ) AS finish_ratio
FROM audiobooks a
JOIN audio_cards ac ON a.uuid = ac.audiobook_uuid
GROUP BY a.title
ORDER BY finish_ratio DESC
LIMIT 1;


SELECT ab.title, COUNT(*) AS completed_count
FROM listenings l
JOIN audiobooks ab ON l.audiobook_uuid = ab.uuid
WHERE l.position_to = ab.duration
GROUP BY ab.title
ORDER BY completed_count DESC
LIMIT 1;
