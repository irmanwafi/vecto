-- 1. Create and select the database
DROP DATABASE IF EXISTS smart_agriculture;
CREATE DATABASE smart_agriculture;
USE smart_agriculture;

-- 2. Create tables

-- Location table
CREATE TABLE Location (
    location_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(100)
);

-- Device table
CREATE TABLE Device (
    device_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    location_id INT NOT NULL,
    device_type VARCHAR(20),
    unit VARCHAR(10),
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

-- Reading table
CREATE TABLE Reading (
    reading_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    device_id INT NOT NULL,
    read_time DATETIME,
    reading_value DECIMAL(5,2),
    FOREIGN KEY (device_id) REFERENCES Device(device_id)
);

-- WeatherLog table (safe column names)
CREATE TABLE WeatherLog (
    weather_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    location_id INT NOT NULL,
    recorded_on DATE,
    weather_condition VARCHAR(20),
    condition_score INT,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

-- 3. Insert mock data

-- Insert location
INSERT INTO Location (name, region) VALUES 
('Seri Tani', 'Kedah');

-- Insert devices
INSERT INTO Device (location_id, device_type, unit) VALUES 
(1, 'temp_sensor', '°C'),
(1, 'moisture_sensor', '%');

-- Insert temperature readings (device_id = 1)
INSERT INTO Reading (device_id, read_time, reading_value) VALUES 
(1, '2025-07-27 08:00:00', 29.1),
(1, '2025-07-27 14:00:00', 30.3),
(1, '2025-07-28 08:00:00', 28.7),
(1, '2025-07-28 14:00:00', 29.2),
(1, '2025-07-29 08:00:00', 27.9),
(1, '2025-07-29 14:00:00', 28.5);

-- Insert moisture readings (device_id = 2)
INSERT INTO Reading (device_id, read_time, reading_value) VALUES 
(2, '2025-07-27 08:00:00', 42.5),
(2, '2025-07-27 14:00:00', 41.8),
(2, '2025-07-28 08:00:00', 43.2),
(2, '2025-07-28 14:00:00', 42.9),
(2, '2025-07-29 08:00:00', 44.0),
(2, '2025-07-29 14:00:00', 43.7);

-- Insert weather data
INSERT INTO WeatherLog (location_id, recorded_on, weather_condition, condition_score) VALUES 
(1, '2025-07-27', 'Sunny', 2),
(1, '2025-07-28', 'Rainy', 1),
(1, '2025-07-29', 'Cloudy', 3);

-- 4. Calculate nutrient index

WITH DailyAvg AS (
  SELECT 
    d.location_id,
    DATE(r.read_time) AS date,
    ROUND(AVG(CASE WHEN d.device_type = 'temp_sensor' THEN r.reading_value END), 2) AS avg_temp,
    ROUND(AVG(CASE WHEN d.device_type = 'moisture_sensor' THEN r.reading_value END), 2) AS avg_moisture
  FROM Reading r
  JOIN Device d ON r.device_id = d.device_id
  GROUP BY d.location_id, DATE(r.read_time)
),

DailyWeather AS (
  SELECT 
    location_id,
    recorded_on AS date,
    condition_score
  FROM WeatherLog
)

SELECT 
  da.date,
  da.avg_temp,
  da.avg_moisture,
  dw.condition_score AS weather_score,
  ROUND((dw.condition_score * da.avg_temp) / da.avg_moisture, 2) AS nutrient_index
FROM DailyAvg da
JOIN DailyWeather dw 
  ON da.location_id = dw.location_id AND da.date = dw.date;
