SELECT CONCAT("SHOW GRANTS FOR `", user, "`@`", host,
"`; SHOW CREATE USER `", user, "`@`", host, "`;") grants
FROM mysql.user WHERE user = "bob";
