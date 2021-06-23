SELECT * FROM mysql.user;
# This query outputs the users of the mysql.user database and their pertaining information.

SELECT user, host FROM mysql.user;
# Outputs only the user ID and host from the mysql.user database. This is better to only output the information you need from your database.

SELECT * FROM mysql.help_topic;
# Outputs all columns from the mysql.help_topic database.

SELECT help_topic_id, help_category_id, url FROM mysql.help_topic;
# Only outputs the 3 columns asked for from the database. 