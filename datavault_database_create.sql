CREATE USER 'datavault'@'%' IDENTIFIED BY 'datavault';
GRANT ALL PRIVILEGES ON *.* TO 'datavault'@'%';
FLUSH PRIVILEGES;
CREATE DATABASE datavault CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
