

--1 ЗАДАНИЕ

WITH friends AS (
	SELECT DISTINCT
		IF (user_id = 1, friend_id, user_id) AS friend_id
	FROM
		friendship
	WHERE
		friendship_status = 'FRIENDSHIP'
		AND confirmed_at IS NOT NULL
		AND (user_id = 1 OR friend_id = 1)
)
SELECT
	CONCAT_WS(' ', first_name, last_name),
	COUNT(1) counter
FROM messages m
INNER JOIN friends f ON (
	m.from_user_id = f.friend_id
)
INNER JOIN profiles p ON (
	p.user_id = f.friend_id
)
WHERE
	m.to_user_id = 1
GROUP BY
	m.from_user_id
ORDER BY
	counter DESC
LIMIT 1;

--2 ЗАДАНИЕ

WITH t1 AS (
	SELECT
		user_id
	FROM
		profiles
	ORDER BY
		birth_date DESC
	LIMIT 10
)
SELECT
	COUNT(1)
FROM likes 1
INNER JOIN t1 ON (
	l.entity_id = t1.user_id
	AND l.entity_type_id = 1
);

--3 ЗАДАНИЕ

SELECT
	COUNT(1) AS total,
	p.gender
FROM likes l
INNER JOIN profiles p ON (
	p.user_id = l.from_user_id
)
GROUP BY
	gender
ORDER BY
	total DESC
LIMIT 1;


--4 ЗАДАНИЕ

SELECT
	contact_ws(' ', first_name, last_name) AS full_name,
		count(DISTINCT l.id) + count(DISTINCT m.id) AS overall_activity
	FROM users u 
	INNER JOIN profiles p ON (
		u.id = p.user_id
	)
	LEFT JOIN likes l ON (
		u.id = l.from_user_id
	)
	LEFT JOIN messages m ON (
		u.id = m.from_user_id
	)
	GROUP BY u.id, p.first_name, p.last_name
ORDER BY 
	overall_activity DESC, full_name
LIMIT 10;

