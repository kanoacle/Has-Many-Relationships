-- getting all users
SELECT *
FROM users;
-- getting posts from user 100
SELECT *
FROM posts
WHERE posts.users_id = 100;
-- getting all posts fields and user 200's first and last name from posts
SELECT posts.*, users.first_name, users.last_name
FROM posts
JOIN users ON posts.users_id = users.id
WHERE posts.users_id = 200;
-- getting all posts fields and username for Norene Schmitt from posts
SELECT posts.*, users.username
FROM posts
JOIN users ON posts.users_id = users.id
WHERE users.first_name = 'Norene'
AND users.last_name = 'Schmitt';
-- getting usernames of users who have posted after 1/1/15
SELECT users.username
FROM posts
JOIN users ON posts.users_id = users.id
WHERE posts.created_at >= timestamp '2015-01-01 00:00:00';
-- getting post title, post content, and username of users who joined before 1/1/15
SELECT posts.title, posts.content, users.username
FROM posts
JOIN users ON posts.users_id = users.id
WHERE users.created_at <= timestamp '2015-01-01 00:00:00';
-- gettin all comments and which post they belong to
SELECT comments.*, posts.title AS "Post Title"
FROM comments
JOIN posts ON comments.posts_id = posts.id;
-- getting post title, post url, and comment body for posts created before 1/1/15
SELECT posts.title AS "post_title", posts.url AS "post_url", comments.body AS "comment_body"
FROM comments
JOIN posts ON comments.posts_id = posts.id
WHERE posts.created_at <= timestamp '2015-01-01 00:00:00';
-- getting post title, post url, and comment body for posts created after 1/1/15
SELECT posts.title AS "post_title", posts.url AS "post_url", comments.body AS "comment_body"
FROM comments
JOIN posts ON comments.posts_id = posts.id
WHERE posts.created_at >= timestamp '2015-01-01 00:00:00';
-- getting post title, post url, and comment body for comments containg 'USB'
SELECT posts.title AS "post_title", posts.url AS "post_url", comments.body AS "comment_body"
FROM comments
JOIN posts ON comments.posts_id = posts.id
WHERE comments.body LIKE '%USB%';
-- getting post title, first and last name of post author, and comment body for posts with comments containing 'matrix'
SELECT posts.title AS "post_title", users.first_name, users.last_name, comments.body AS "comment_body"
FROM comments
JOIN posts ON comments.posts_id = posts.id
JOIN users ON posts.users_id = users.id
WHERE comments.body LIKE '%matrix%';
-- getting first and last name of comment author and comment body where comment body contains 'SSL' and post content contains 'dolorum'
SELECT users.first_name, users.last_name, comments.body AS "comment_body"
FROM posts
JOIN comments ON posts.id = comments.posts_id
JOIN users ON comments.users_id = users.id
WHERE comments.body LIKE '%SSL%'
AND posts.content LIKE '%dolorum%';
-- getting first and last name of post author, post title, username of comment author, and comment body where comment body contains 'SSL' or 'firewall', and the post content contains 'nemo'
SELECT users.first_name AS "post_author_first_name", users.last_name AS "post_author_last_name", posts.title AS "post_title", users.username AS "comment_author_username", comments.body AS "comment_body", posts.content
FROM comments
INNER JOIN posts ON comments.posts_id = posts.id
INNER JOIN users ON comments.users_id = users.id
WHERE posts.content LIKE '%nemo%'
AND (comments.body LIKE '%SSL%'
OR comments.body LIKE '%firewall%');
-- getting post id, post title, and user id of posts where the author commented on his/her own post
SELECT posts.id, posts.title, posts.users_id, comments.users_id
FROM posts
RIGHT JOIN comments ON posts.id = comments.posts_id
WHERE posts.users_id = comments.users_id;
-- getting count of comments on posts that were created after 7/14/15
SELECT count(*)
FROM comments
INNER JOIN posts ON comments.posts_id = posts.id
WHERE comments.created_at >= timestamp '2015-07-14 00:00:00';
-- getting all users who comment about 'programming'
SELECT users.first_name AS "First Name", users.last_name AS "Last Name", users.username
FROM users
JOIN comments ON comments.users_id = users.id
WHERE comments.body LIKE '%programming%';