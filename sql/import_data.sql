USE `flags`;

LOAD DATA LOCAL INFILE "default_data/category.csv"
INTO TABLE category
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, name, description, reference_link);

LOAD DATA LOCAL INFILE "default_data/flag.csv"
INTO TABLE flag
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, name, date_designed, reference_link, description);

LOAD DATA LOCAL INFILE "default_data/flag_category.csv"
INTO TABLE flag_category
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(flag_id, category_id);

LOAD DATA LOCAL INFILE "default_data/characteristic.csv"
INTO TABLE characteristic
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, name, description);

LOAD DATA LOCAL INFILE "default_data/color.csv"
INTO TABLE color
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, name, hex);

LOAD DATA LOCAL INFILE "default_data/intricacy.csv"
INTO TABLE intricacy
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, name, description);

LOAD DATA LOCAL INFILE "default_data/shape_count.csv"
INTO TABLE shape_count
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, name, description);

LOAD DATA LOCAL INFILE "default_data/user.csv"
INTO TABLE user
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(email, username, password_hash, create_ip, create_date, verify_code, verified, public_profile);