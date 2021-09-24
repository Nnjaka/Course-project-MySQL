-- Создаем и выбираем БД
DROP DATABASE IF EXISTS booking;
CREATE DATABASE booking;
USE booking;

-- Создаем таблицу с основными данными о пользователе
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE  NOT NULL,
 	password_hash VARCHAR(100) NOT NULL, 
	phone BIGINT UNSIGNED UNIQUE NOT NULL
);
	
-- Создаем таблицу для фотографий
DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    filename VARCHAR(255),
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Создаем таблицу с дополнительными данными о пользователе
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id BIGINT UNSIGNED NOT NULL,
	title ENUM ('Mr', 'Ms', 'Mrs'),
	display_name VARCHAR(50) NOT NULL COMMENT 'Имя на сайте',
	date_of_birth DATE,
	nationality VARCHAR(255),
	gender CHAR(1),
	country VARCHAR(100),
    address VARCHAR(255),
	media_id BIGINT UNSIGNED NOT NULL COMMENT 'Фотография профиля',
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW(),
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

-- Создаем таблицу с типами недвижимости
DROP TABLE IF EXISTS type_of_property;
CREATE TABLE type_of_property (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	desсription TEXT COMMENT 'Описание типа недвижимости'
);

-- Создаем таблицу с объектамии недвижимости
DROP TABLE IF EXISTS property;
CREATE TABLE property (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	type_of_property_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(255) NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	country VARCHAR(100) NOT NULL,
	postcode VARCHAR(100) NOT NULL,
	address VARCHAR(255) NOT NULL,
	guest TINYINT NOT NULL COMMENT 'Количество гостей',
	property_size SMALLINT NOT NULL COMMENT 'Площадь недвижимости',
	check_in_from TIME COMMENT 'Время заезда (с...)',
	check_in_until TIME COMMENT 'Время заезда (до...)',
	check_out_from TIME COMMENT 'Время отъезда (с...)',
	check_out_until TIME COMMENT 'Время отъезда (до...)',
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW(),
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (type_of_property_id) REFERENCES type_of_property(id),
	FOREIGN KEY (media_id) REFERENCES media(id)
);

-- Создаем таблицу с типами комнат
DROP TABLE IF EXISTS room_type;
CREATE TABLE room_type (
	id SERIAL PRIMARY KEY,
	name ENUM ('Bedroom', 'Living room', 'Other')
);

-- Создаем таблицу со спальными местами
DROP TABLE IF EXISTS beds;
CREATE TABLE beds (
 	id SERIAL PRIMARY KEY,
 	name VARCHAR(255),
 	desсription TEXT COMMENT 'Описание типа спальных мест: односпальная кровать, двуспальная и т.д.'
);

-- Создаем таблицу с комнатами
DROP TABLE IF EXISTS rooms;
CREATE TABLE rooms (
	id SERIAL PRIMARY KEY,
	property_id BIGINT UNSIGNED NOT NULL,
	room_type_id BIGINT UNSIGNED NOT NULL,
	bed_id BIGINT UNSIGNED NOT NULL,
	bathrooms TINYINT,
	
	FOREIGN KEY (property_id) REFERENCES property(id),
	FOREIGN KEY (room_type_id) REFERENCES room_type(id),
	FOREIGN KEY (bed_id) REFERENCES beds (id)
);

-- Создаем таблицу с дополнительными удобствами
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
	parking ENUM ('Yes, free', 'Yes, paid', 'No') DEFAULT 'No' COMMENT 'Парковка',
	languages VARCHAR(255) COMMENT 'Язык, на котором говорит персонал',
	smoking BOOL DEFAULT 0 COMMENT 'Курение разрешено',
	pets BOOL DEFAULT 0 COMMENT 'Можно с животными',
	children BOOL DEFAULT 0 COMMENT 'Можно с детьми',
	parties BOOL DEFAULT 0 COMMENT 'Можно проводить вечеринки/мероприятия',
	
	FOREIGN KEY (property_id) REFERENCES property(id)
);

-- Создаем таблиицу с заказами
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW(),
	
	FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
	order_id BIGINT UNSIGNED NOT NULL,
	property_id BIGINT UNSIGNED NOT NULL,
	start_date DATE NOT NULL,
	finish_date DATE NOT NULL,
	guest TINYINT NOT NULL COMMENT 'Количество гостей',

	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (property_id) REFERENCES property(id)
);

-- Создаем таблицу с отзывами
DROP TABLE IF EXISTS rewiew;
CREATE TABLE rewiew (
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

	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (property_id) REFERENCES property(id)
);

