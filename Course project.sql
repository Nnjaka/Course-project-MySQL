/* Создаем и выбираем БД*/
DROP DATABASE IF EXISTS booking;
CREATE DATABASE booking;
USE booking;


/*Создаем необходимые таблицы и наполняем их данными*/
-- Создаем таблицу с основными данными о пользователе и заполняем ее данными
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE  NOT NULL,
 	password_hash VARCHAR(100) NOT NULL, 
	phone BIGINT UNSIGNED UNIQUE NOT NULL,
	
	INDEX users_firstname_lastname_idx(firstname, lastname)
);

INSERT INTO `users` VALUES 
	(1,'Axel','Raynor','ondricka.florine@example.net','16980010c7222d6476ff428ef9fe17eb0bac5417',89254416711),
	(2,'Devan','Batz','uhammes@example.net','96627fc357bcbb3887eadcec19530f8762df90cb',89051827872),
	(3,'Rupert','Donnelly','hleuschke@example.com','21fcc17dbe4626b074cd073d45d215b5ae2a5664',85870526181),
	(4,'Adelia','Kris','billy.dubuque@example.net','ca1f550f25c12754c49a8747f23ef5520dcfb5c2',88827081988),
	(5,'Verla','Rath','dee.hickle@example.com','0d4b098ba152b6e850a59cad0b4b04c01b3319e4',87102696495),
	(6,'Carlo','Blanda','yhegmann@example.org','d5e61cfbd1432952b44f153a1c987b2ad8f7729f',88716015270),
	(7,'Filomena','Beer','qschoen@example.com','743ff609abe39a6aea32d153f4fd1e1601d137da',82827094332),
	(8,'King','Osinski','nikolaus.loyce@example.net','89a165d25ab7857f393750a70dd5afe77eaa235c',88185949539),
	(9,'Cielo','Vandervort','steve95@example.net','d7ce93eabe1df8fe1b9a1518dd6f2017bdd482bf',89758036606),
	(10,'Jany','Kemmer','halie13@example.net','0387bc990d090e2d93be09c0bcf537d7426d7abb',87292329361);

	
-- Создаем таблицу для фотографий и заполняем ее данными
DROP TABLE IF EXISTS photos;
CREATE TABLE photos(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    filename VARCHAR(255) UNIQUE,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    INDEX photos_user_id_idx(user_id),
    
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO `photos` VALUES 
	(1,1,'id',NULL,'2015-12-06 12:42:50','2006-12-11 21:40:52'),
	(2,2,'voluptas',NULL,'1986-07-04 13:22:38','2001-11-14 07:04:29'),
	(3,3,'dolorem',NULL,'2001-10-06 03:02:29','1993-08-06 11:44:19'),
	(4,4,'vero',NULL,'1975-10-23 06:44:48','2008-03-26 22:52:37'),
	(5,5,'dolor',NULL,'2010-07-29 01:13:26','2001-09-05 12:49:14'),
	(6,6,'non',NULL,'1987-09-15 15:30:29','2001-08-16 20:39:45'),
	(7,7,'ex',NULL,'1987-03-31 04:55:46','1972-08-02 03:14:15'),
	(8,8,'praesentium',NULL,'1977-11-04 07:21:38','1978-04-29 21:09:40'),
	(9,9,'voluptatem',NULL,'2020-07-25 13:07:48','1988-06-18 03:03:02'),
	(10,10,'consectetur',NULL,'1998-04-25 01:36:01','2008-08-18 11:50:55');


-- Создаем таблицу с дополнительными данными о пользователе и заполняем ее данными
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id BIGINT UNSIGNED NOT NULL,
	title ENUM ('Mr', 'Ms', 'Mrs'),
	display_name VARCHAR(50) UNIQUE NOT NULL COMMENT 'Имя на сайте',
	date_of_birth DATE,
	nationality VARCHAR(255),
	gender CHAR(1),
	country VARCHAR(100),
    address VARCHAR(255),
	photo_id BIGINT UNSIGNED NOT NULL COMMENT 'Фотография профиля',
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW(),
    
    INDEX profiles_user_id_idx(user_id),
    INDEX profiles_photo_id_idx(photo_id),
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (photo_id) REFERENCES photos(id)
);

INSERT INTO `profiles` VALUES 
	(1,'Mrs','exercitationem','1996-10-26','Russian','f','Russia','76332 Jenkins River\nNorth Justonburgh, PA 69837',1,'1986-03-20 23:17:40','2009-09-20 10:17:28'),
	(2,'Mr','in','2001-06-15','French','m','France','29046 Bartoletti Shoals\nHomenickland, TN 05899-5087',2,'1971-08-03 13:29:38','2002-08-04 19:48:55'),
	(3,'Mr','illum','1975-10-20','Russian','m','Russia','7601 Ullrich Lane\nBrownview, ID 81388',3,'1997-04-26 01:11:30','2011-06-05 18:02:54'),
	(4,'Ms','iure','2001-10-26','French','f','France','54202 Thad Plains Suite 950\nPort Elwin, IL 03124',4,'1996-07-16 00:38:07','1992-07-06 03:42:31'),
	(5,'Mrs','alias','1971-10-03','German','f','Germany','938 Ziemann Drives\nNorth Briceton, DE 30918',5,'2021-09-07 18:09:46','2010-06-30 09:44:42'),
	(6,'Mrs','saepe','1974-07-22','Russian','f','Russia','574 Melody Trail Apt. 804\nVellaberg, WI 70211-3006',6,'1972-10-25 04:59:36','2013-12-02 12:16:46'),
	(7,'Mr','doloremque','1998-02-21','German','m','Germany','89043 Streich Point Suite 105\nAlfredfort, NY 72999-4360',7,'1978-09-25 18:21:02','2004-02-14 00:02:21'),
	(8,'Ms','sit','1991-04-17','German','f','Germany','4338 Moore Brooks\nHuelstown, IN 24487-0494',8,'2020-10-21 06:47:25','2000-02-21 04:26:35'),
	(9,'Mr','voluptas','1986-06-25','Spanish','m','Spain','309 Keaton Turnpike\nHyattmouth, NM 69569',9,'1993-05-15 20:17:10','1989-11-17 01:15:40'),
	(10,'Mrs','a','1982-01-22','Russian','f','Russia','838 Wehner Curve\nPort Pabloside, ME 13640',10,'1975-07-17 06:17:40','1978-08-13 09:46:27');


-- Создаем таблицу с типами недвижимости и заполняем ее данными
DROP TABLE IF EXISTS types_of_property;
CREATE TABLE types_of_property (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) UNIQUE,
	desсription TEXT COMMENT 'Описание типа недвижимости'
);

INSERT INTO `types_of_property` VALUES 
	(1,'Apartment','Furnished and self-catering accommodation, where guests rent the entire place'),
	(2,'Home','Properties like apartments, holiday homes, villas, etc.'),
	(3,'Hotel, B&Bs, and more','Properties like hotels, B&Bs, guest houses, hostels, aparthotels, etc.'),
	(4,'Alternative places','Properties like boats, campsites, luxury tents, etc.');


-- Создаем таблицу с объектамии недвижимости и заполняем ее данными
DROP TABLE IF EXISTS property;
CREATE TABLE property (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	type_of_property_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(255) UNIQUE NOT NULL,
	description TEXT NOT NULL,
	photo_id BIGINT UNSIGNED NOT NULL,
	town VARCHAR(100) NOT NULL,
	postcode VARCHAR(100) NOT NULL,
	address VARCHAR(255) NOT NULL,
	guest TINYINT NOT NULL COMMENT 'Количество гостей',
	property_size SMALLINT NOT NULL COMMENT 'Площадь недвижимости',
	check_in_from TIME NOT NULL COMMENT 'Время заезда (с...)',
	check_in_until TIME NOT NULL COMMENT 'Время заезда (до...)',
	check_out_from TIME NOT NULL COMMENT 'Время отъезда (с...)',
	check_out_until TIME NOT NULL COMMENT 'Время отъезда (до...)',
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW(),
	
    INDEX property_user_id_idx(user_id),
    INDEX property_type_of_property_id_idx(type_of_property_id),
    INDEX property_photo_id_idx(photo_id),
	INDEX property_town_idx(town),
    
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (type_of_property_id) REFERENCES types_of_property(id),
	FOREIGN KEY (photo_id) REFERENCES photos(id)
);

INSERT INTO `property` VALUES 
	(1,1,1,'recusandae','Quibusdam consequatur quae commodi hic assumenda suscipit illum natus. Accusantium voluptate facilis ut aut eos sit temporibus.',1,'Moscow','679','81423 Kirlin Run Apt. 514\nChanellestad, KS 41538-9468',0,32767,'10:00:00','12:00:54','15:27:36','17:39:02','1980-01-16 18:15:00','1977-11-21 00:24:03'),
	(2,2,2,'earum','Quia est quis consequuntur expedita hic deleniti cumque. Ratione voluptas iusto facere vel tempora. Rem qui nesciunt laboriosam assumenda nobis molestiae animi natus. Quisquam sed debitis ducimus minima ducimus animi quia. Quia est facilis delectus qui.',2,'Moscow','896','6278 Kallie Village Suite 343\nPort Carolannefurt, NE 32430-4930',0,5868,'08:46:44','23:58:56','06:54:17','09:27:13','1975-05-25 09:05:12','2005-09-03 11:06:57'),
	(3,3,3,'dolores','Quae quos iure dolorum sunt earum. Illum dolorum libero nihil. Eveniet illo esse quae et molestiae fuga. Quam accusantium adipisci debitis laborum repellendus culpa.',3,'Paris','599','21708 Coleman Street Apt. 049\nNitzscheberg, LA 67570-4119',0,32767,'07:40:01','23:34:32','08:30:05','21:15:18','1971-08-28 17:58:41','2003-07-22 02:51:30'),
	(4,4,1,'molestias','Aut veniam dolorem deleniti suscipit. Voluptatibus magnam ducimus nisi.',4,'Paris','235','6958 Wilfrid Parkways\nLake Elliot, OH 68434-3306',0,32767,'13:57:23','00:30:54','02:15:04','08:52:22','1976-06-12 22:39:45','2019-04-17 02:19:39'),
	(5,5,2,'provident','Ullam maiores fugit et aliquam ea quia quos. Sit quis et corrupti soluta.',5,'Moscow','852','053 Roxanne Corners Apt. 552\nLake Wyatt, NV 99093-8424',0,32767,'12:01:08','11:53:49','03:05:00','17:12:44','2014-10-10 13:39:03','2010-09-29 23:09:17'),
	(6,6,3,'sunt','Sapiente error quidem assumenda libero quia. Ipsam autem minima quo perspiciatis enim tempore. Culpa et voluptatem omnis voluptatem nesciunt doloremque. Voluptas odio pariatur molestiae sequi quisquam molestiae qui quas.',6,'Moscow','823','7111 Toy Forest Suite 186\nBernhardville, NE 71156',0,64,'23:10:19','07:35:41','13:52:34','15:25:24','2001-07-20 12:44:55','1975-08-12 11:59:39'),
	(7,7,1,'temporibus','Voluptatum omnis at soluta. Modi velit non odit libero. Doloribus voluptates ab veritatis perspiciatis aliquid.',7,'Paris','900','01172 Alyson Spur\nGrahambury, MS 29250',0,32767,'00:24:35','22:33:35','13:19:44','11:22:35','2015-02-13 14:26:11','1998-08-22 00:48:52'),
	(8,8,2,'dolore','Occaecati enim tempora est quam deserunt ea. Corrupti doloribus non incidunt non. Ullam dolorem asperiores eum nobis laboriosam corporis quibusdam.',8,'Moscow','978','766 Ratke Square\nAlexzanderburgh, MD 39737',0,2136,'02:11:39','09:48:05','06:29:08','19:20:18','1978-11-06 06:16:55','2010-01-27 10:13:41'),
	(9,9,3,'laborum','Similique quo dolorum quia alias mollitia. A magnam occaecati voluptatum. Assumenda maxime quo qui dicta. Est eveniet amet iste nemo voluptates.',9,'Berlin','673','619 Maurice Stream\nHershelton, CO 20465-9105',0,32767,'15:26:23','04:07:15','15:32:47','16:29:24','2000-08-30 13:02:27','1998-11-18 15:38:02'),
	(10,10,1,'et','Iste ipsam deserunt laboriosam voluptatum ratione doloremque et. Dolore maiores rerum et non rem et in. Ipsum itaque eos beatae qui. Ducimus hic occaecati iste quaerat harum.',10,'Paris','349','68574 Nikolaus Canyon Suite 678\nReannamouth, MO 95023-4352',0,32767,'13:25:35','05:18:05','10:35:22','15:22:50','1991-05-10 02:05:54','2012-09-18 17:10:34');


-- Создаем таблицу с типами комнат и заполняем ее данными
DROP TABLE IF EXISTS room_types;
CREATE TABLE room_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO `room_types` VALUES 
	(1,'Bedroom'),
	(2,'Living room'),
	(3,'Other');


-- Создаем таблицу со спальными местами и заполняем ее данными
DROP TABLE IF EXISTS beds;
CREATE TABLE beds (
 	id SERIAL PRIMARY KEY,
 	name VARCHAR(255) UNIQUE NOT NULL,
 	desсription TEXT COMMENT 'Описание типа спальных мест: односпальная кровать, двуспальная и т.д.'
);

INSERT INTO `beds` VALUES 
	(1,'Single bed','90 - 130 cm wide'),
	(2,'Double bed','31 - 150 cm wide'),
	(3,'Large bed (King size)','151 - 180 cm wide'),
	(4,'Extra-large double bed (Super-king size)','181 - 210 cm wide'),
	(5,'Bunk bed','Variable size'),
	(6,'Sofa bed','Variable size'),
	(7,'Futon Mat','Variable size');


-- Создаем таблицу с комнатами и заполняем ее данными
DROP TABLE IF EXISTS rooms;
CREATE TABLE rooms (
	id SERIAL PRIMARY KEY,
	property_id BIGINT UNSIGNED NOT NULL,
	room_type_id BIGINT UNSIGNED NOT NULL,
	bed_id BIGINT UNSIGNED NOT NULL,
	bathrooms TINYINT,
	
	INDEX rooms_property_id_idx(property_id),
	INDEX rooms_room_type_id_idx(room_type_id),
	INDEX rooms_bed_id_idx(bed_id),
	      
	FOREIGN KEY (property_id) REFERENCES property(id),
	FOREIGN KEY (room_type_id) REFERENCES room_types(id),
	FOREIGN KEY (bed_id) REFERENCES beds(id)
);

INSERT INTO `rooms` VALUES 
	(1,1,1,1,1),
	(2,2,2,2,1),
	(3,3,3,3,2),
	(4,4,1,4,1),
	(5,5,2,5,2),
	(6,6,3,6,3),
	(7,7,1,7,1),
	(8,8,2,1,1),
	(9,9,3,2,2),
	(10,10,3,3,1);


-- Создаем таблицу с дополнительными удобствами и заполняем ее данными
DROP TABLE IF EXISTS facilities;
CREATE TABLE facilities (
	property_id BIGINT UNSIGNED NOT NULL,
	air_conditioning BOOL DEFAULT 0 COMMENT 'Кондиционер',
	heating BOOL DEFAULT 0 COMMENT 'Отопление',
	free_wifi BOOL DEFAULT 0 COMMENT 'Бесплатный WiFi',
	electric_vehicle_charging_station BOOL DEFAULT 0 COMMENT 'Бесплатный WiFi',
	kitchen BOOL DEFAULT 0 COMMENT 'Кухня',
	kitchenette BOOL DEFAULT 0 COMMENT 'Мини-кухня',
	washing_machine BOOL DEFAULT 0 COMMENT 'Стиральная машина',
	flat_screen_TV BOOL DEFAULT 0 COMMENT 'Телевизор с плоским экраном',
	swimming_pool BOOL DEFAULT 0 COMMENT 'Бассейн',
	hot_tub BOOL DEFAULT 0 COMMENT 'Гидромассажная ванна',
	minibar BOOL DEFAULT 0 COMMENT 'Мини-бар',
	sauna BOOL DEFAULT 0 COMMENT 'Сауна',
	balcony BOOL DEFAULT 0 COMMENT 'Балкон',
	garden_view BOOL DEFAULT 0 COMMENT 'Вид на сад',
	terrace BOOL DEFAULT 0 COMMENT 'Терраса',
	view_from_window BOOL DEFAULT 0 COMMENT 'Вид из окна',
	breakfast BOOL DEFAULT 0 COMMENT 'Завтрак',
	parking ENUM ('Free', 'Paid', 'No') DEFAULT 'No' COMMENT 'Парковка',
	languages VARCHAR(255) COMMENT 'Язык, на котором говорит персонал',
	smoking BOOL DEFAULT 0 COMMENT 'Курение разрешено',
	pets BOOL DEFAULT 0 COMMENT 'Можно с животными',
	children BOOL DEFAULT 0 COMMENT 'Можно с детьми',
	parties BOOL DEFAULT 0 COMMENT 'Можно проводить вечеринки/мероприятия',
	
	INDEX facilities_property_id_idx(property_id),
	
	FOREIGN KEY (property_id) REFERENCES property(id)
);

INSERT INTO `facilities` VALUES 
	(1,1,0,0,1,0,0,0,0,1,0,0,1,1,1,1,0,0,'Free','english',0,0,1,0),
	(2,1,1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,'Paid','english',0,0,0,0),
	(3,0,1,0,1,0,1,1,1,1,1,1,1,0,0,1,0,1,'No','english',0,1,1,1),
	(4,0,0,1,1,0,1,1,1,0,1,0,1,0,1,1,0,0,'Free','russian',0,0,0,0),
	(5,0,1,1,1,0,0,0,1,0,0,1,0,0,0,0,0,1,'No','english',1,0,1,0),
	(6,1,1,0,1,0,1,1,1,0,0,1,0,1,1,0,1,0,'Free','russian',0,1,0,1),
	(7,1,0,1,0,1,0,0,0,1,1,1,1,0,0,1,1,0,'Free','russian',0,1,1,0),
	(8,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,'Free','russian',0,1,1,0),
	(9,1,0,0,0,0,1,1,1,1,1,0,0,1,0,0,1,1,'No','russian',0,1,0,1),
	(10,1,0,0,1,1,1,1,1,1,1,1,0,1,0,1,1,0,'Paid','russian',0,1,0,1);


-- Создаем таблиицу с заказами и заполняем ее данными
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW(),
	
    INDEX orders_user_id_idx(user_id),
    
	FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO `orders` VALUES 
	(1,1,'1976-02-26 22:32:22','2013-08-03 19:19:18'),
	(2,2,'1999-05-16 18:29:03','1982-02-24 13:42:38'),
	(3,3,'1986-01-04 16:30:31','1998-03-31 16:30:42'),
	(4,4,'2015-07-23 14:54:54','1983-05-28 03:52:06'),
	(5,5,'2007-08-29 01:27:40','2013-05-02 19:20:57'),
	(6,6,'1988-08-22 19:10:55','2012-08-14 07:35:00'),
	(7,7,'1997-07-29 04:24:40','2008-09-18 05:01:14'),
	(8,8,'2012-11-03 05:24:11','2004-03-17 11:10:55'),
	(9,9,'1971-04-21 21:34:33','1998-08-31 14:08:06'),
	(10,10,'2000-05-21 02:21:12','2018-08-18 15:55:16');


-- Создаем таблиицу с детялями заказов и заполняем ее данными
DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
	id SERIAL PRIMARY KEY,
	order_id BIGINT UNSIGNED NOT NULL,
	property_id BIGINT UNSIGNED NOT NULL,
	start_date DATE NOT NULL,
	finish_date DATE NOT NULL,
	guest TINYINT NOT NULL COMMENT 'Количество гостей',

	INDEX order_details_order_id_idx(order_id),
	INDEX order_details_property_id_idx(property_id),
	INDEX order_details_start_date_finish_date_idx(start_date, finish_date),
	
	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (property_id) REFERENCES property(id)
);

INSERT INTO `order_details` VALUES 
	(1,1,1,'2017-04-15','2019-09-10',2),
	(2,2,2,'1994-06-28','2013-09-24',3),
	(3,3,3,'1986-04-03','2002-03-10',1),
	(4,4,4,'1997-10-12','2011-08-13',2),
	(5,5,5,'1986-10-28','2019-03-06',2),
	(6,6,6,'2021-09-20','2021-09-30',3),
	(7,7,7,'1982-10-20','2009-09-14',4),
	(8,8,8,'1990-06-03','2012-12-10',1),
	(9,9,9,'2001-08-18','2008-07-29',1),
	(10,10,10,'2017-08-05','2018-05-02',1);


-- Создаем таблицу с отзывами и заполняем ее данными
DROP TABLE IF EXISTS rewiews;
CREATE TABLE rewiews (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	property_id BIGINT UNSIGNED NOT NULL,
	location TINYINT NOT NULL COMMENT 'Оценка за расположение',
	staff TINYINT NOT NULL COMMENT 'Оценка за персонал',
	ratio TINYINT NOT NULL COMMENT 'Оценка за соотношение цена/качество',
	clean  TINYINT NOT NULL COMMENT 'Оценка за чистоту',
	comfort  TINYINT NOT NULL COMMENT 'Оценка за комфорт',
	facilities  TINYINT NOT NULL COMMENT 'Оценка за удобства',
	wireless_internet TINYINT NOT NULL COMMENT 'Оценка за бесплатный wi-fi',
	message TEXT,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW(),

    INDEX rewiews_user_id_idx(user_id),
	INDEX rewiews_property_id_idx(property_id),

	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (property_id) REFERENCES property(id)
);

INSERT INTO `rewiews` VALUES 
	(1,1,1,4,4,1,5,5,9,1,'Molestiae architecto autem aut in. Sunt adipisci fuga cupiditate nobis. Ratione odit sit doloremque est qui occaecati ex.','1973-06-02 12:54:12','1974-09-23 08:04:04'),
	(2,2,2,1,4,10,5,10,5,5,'Suscipit perspiciatis sed fugit ipsa quos atque. Molestiae culpa consequatur iste tempora dolores cum atque. Quae sed eos ab aliquid sunt quam unde. Minus molestias quidem sapiente non autem autem qui.','1972-06-23 15:36:06','1993-07-06 22:35:28'),
	(3,3,3,7,4,7,3,5,4,4,'Explicabo non rerum voluptates est necessitatibus. Illo tempora et repudiandae voluptas ut dolorem. Placeat nobis cupiditate consequatur repellendus. Omnis vero expedita aliquam et corporis explicabo deleniti.','1994-02-07 00:38:18','1999-07-14 21:13:00'),
	(4,4,4,9,2,6,1,10,5,4,'Totam et fuga molestiae deleniti qui officiis. Dolor maiores in earum assumenda ut similique adipisci. Quas autem sit tenetur aliquid sit. Aspernatur laudantium excepturi qui non veritatis odit optio.','2021-02-23 02:46:41','2013-02-06 07:21:10'),
	(5,5,5,2,4,6,6,4,2,6,'Occaecati id aliquid et eaque facere beatae. Molestias vitae nihil vitae. Autem quidem omnis possimus non ratione molestiae repudiandae. Minus maxime quasi unde et.','2010-05-13 09:11:20','1993-10-20 00:30:44'),
	(6,6,6,3,8,5,1,3,6,5,'Distinctio unde error voluptatibus. Aliquam eum voluptatem nemo eos. Omnis totam qui ut quaerat corrupti.','2003-05-08 08:24:13','1992-06-08 00:16:20'),
	(7,7,7,2,6,6,7,8,9,10,'Modi beatae earum a totam tempore modi dolores. Velit maxime sint fuga sunt possimus fuga. Deleniti quo est soluta expedita quia ut laudantium.','1975-06-29 22:13:41','2009-05-03 07:06:56'),
	(8,8,8,7,1,7,10,10,7,9,'Dignissimos ducimus et et suscipit. Eligendi et id consequuntur aperiam tenetur nulla. Consequatur reprehenderit est consequatur in temporibus quaerat. Placeat exercitationem nihil quae laboriosam. Et aut sed hic et ut sit eveniet.','1998-12-01 02:06:23','2003-03-01 02:42:40'),
	(9,9,9,3,6,1,7,5,9,6,'Perferendis quae expedita autem reprehenderit est dolores. Molestias tempore soluta molestias eum sapiente dolore. Et est autem voluptatem iste odit amet in enim. Enim dolore in nisi est porro earum iure.','2016-06-18 08:17:50','2002-03-06 06:05:28'),
	(10,10,10,2,1,3,7,8,9,10,'Debitis aut est velit ea dolorum ut earum velit. Rerum nihil eius minus officia quaerat adipisci perferendis. Distinctio quibusdam dolore omnis et veritatis vero harum. Amet ipsum et facere vero modi.','1987-01-20 01:49:08','1980-12-28 17:17:29');


-- Создаем таблицу с данными по оплате и заполняем ее данными
DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
	id SERIAL PRIMARY KEY,
	property_id BIGINT UNSIGNED NOT NULL,
	bank_card BOOL DEFAULT 0 COMMENT 'Возможность оплаты банковской картой',
	price INT UNSIGNED COMMENT 'Цена за ночь',
	discount decimal(3,2) COMMENT 'Размер скидки',
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW(),

    INDEX payments_property_id_idx(property_id),
    INDEX payments_bank_card_idx(bank_card),
	INDEX payments_price_idx(price),

	FOREIGN KEY (property_id) REFERENCES property(id)	
);

INSERT INTO `payments` VALUES 
	(1,1,0,2200,0.05,'2017-04-15','2019-09-10'),
	(2,2,0,5500,0.00,'1994-06-28','2013-09-24'),
	(3,3,1,1450,0.00,'1986-04-03','2002-03-10'),
	(4,4,0,2350,0.10,'1997-10-12','2011-08-13'),
	(5,5,1,6000,0.00,'1986-10-28','2019-03-06'),
	(6,6,1,1750,0.05,'1984-09-20','2017-03-05'),
	(7,7,0,3200,0.00,'1982-10-20','2009-09-14'),
	(8,8,0,2600,0.05,'1990-06-03','2012-12-10'),
	(9,9,1,1300,0.00,'2001-08-18','2008-07-29'),
	(10,10,0,5550,0.20,'2017-08-05','2018-05-02');



/*Формируем выборку объектов недвижимости в г.Москва с рейтингом по каждому объекту, свободных в период с 25.09.2021 по 29.09.2021, в которых возможно размещение с животными*/
-- Создаем хранимую функцию для подсчета совокупного рейтинга по объекту недвижимости исходя из оценок по различным критериям
DROP FUNCTION IF EXISTS final_rating;

-- Переназначаем признак окончания запроса  
DELIMITER //

-- Создаем функцию 
CREATE FUNCTION final_rating (id INT)
RETURNS decimal(3,1) READS SQL DATA
BEGIN 
	DECLARE rating decimal(3,1);

	SELECT 
		(AVG(location)+AVG(staff)+AVG(ratio)+AVG(clean)+AVG(comfort)+AVG(facilities)+AVG(wireless_internet))/7 
	INTO rating
	FROM rewiews
	GROUP BY property_id
	HAVING property_id = id;

	RETURN rating;
END//	

-- Переназначаем признак окончания запроса  
DELIMITER ;


/* Создаем запрос, который позволяет сформировать выборку объектов недвижимости, находящихся в Москве 
и в которых возможно размещение с животными c 25.09.2021 по 29.09.2021*/
-- Объявляем переменные с необходимыми датами заезда и отъезда
SET @start_date := '2021-09-25';
SET @finish_date := '2021-09-29';

-- Формируем запрос (используем вложенные запросы и JOIN)
SELECT 
	p.id,
	p.town,
	p.name,
	p.description,
	final_rating(id) AS rating,
	IF(f.pets = 1, 'Можно с животными', 'С животными нельзя') AS pets,
	(SELECT 
		IF(((@start_date > start_date  AND @start_date < finish_date) OR (@finish_date > start_date  AND @finish_date < finish_date)), 'Даты заняты', 'Даты свободны') AS free_date
	FROM order_details AS o
	WHERE o.property_id = p.id) AS free_dates
FROM property AS p 
JOIN facilities AS f
ON p.id = f.property_id 
WHERE p.town = 'Moscow' AND f.pets = 1 
ORDER BY rating DESC;	



/*Сформируем представление, в котором высчитывается срендняя стоимость объектов недвижимости по различным городам, предсталенным на сайте */
CREATE OR REPLACE VIEW avg_price AS
SELECT
	p.town,
	AVG(pm.price) AS average_price
FROM property AS p
	JOIN payments AS pm 
		ON p.id = pm.property_id
GROUP BY p.town;


/*Сформируем представление, в котором высчитывается возраст владельцев недвижимости в г.Париж*/
CREATE OR REPLACE VIEW owner_age_paris AS
SELECT 
	p.name AS property_name,
	CONCAT(u.firstname,' ',u.lastname) AS owner,
	TIMESTAMPDIFF(YEAR, pf.date_of_birth, NOW()) AS age
FROM order_details AS od 
	JOIN property AS p
		ON od.property_id = p.id 
	JOIN users AS u
		ON p.user_id = u.id 
	JOIN profiles AS pf 
		ON u.id = pf.user_id 
WHERE p.town = 'Paris';



/*Создаем триггер, который будет проверять даты заезда и выезда в таблице с деталями заказа (выезд не может быть раньше заезда)*/
-- Переназначаем признак окончания запроса  
DELIMITER //

-- Создаем триггер, который будет проверять данные при вставке данных в таблицу order_details
CREATE TRIGGER check_date_insert BEFORE INSERT ON order_details
FOR EACH ROW 
BEGIN 
	IF NEW.start_date > NEW.finish_date THEN 
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Date error';
	END IF;
END//

-- Создаем триггер, который будет проверять данные при обновлении данных в таблицу order_details
CREATE TRIGGER check_date_update BEFORE UPDATE ON order_details
FOR EACH ROW 
BEGIN 
	IF NEW.start_date > NEW.finish_date THEN 
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Date error';
	END IF;
END//

-- Переназначаем признак окончания запроса  
DELIMITER ;

-- Проверяем работоспособность триггера при вставке новых данных (первый запрос должен вызвать ошибку, второй - верный)
INSERT INTO order_details VALUES
	(11,1,5,'2021-04-15','2021-04-10',2);

INSERT INTO order_details VALUES
	(11,1,5,'2021-04-15','2021-04-20',2);

-- Проверяем работоспособность триггера при обновлении данных (первый запрос должен вызвать ошибку, второй - верный)
UPDATE order_details
SET start_date = '2021-04-15', finish_date = '2021-04-10'
WHERE id = 1;

UPDATE order_details
SET start_date = '2021-04-15', finish_date = '2021-04-20'
WHERE id = 1;


