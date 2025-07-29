SELECT 
  DATE(r.read_time) AS date,
  d.location_id,
  ROUND(AVG(CASE WHEN d.device_type = 'temp_sensor' THEN r.reading_value END), 2) AS avg_temp,
  ROUND(AVG(CASE WHEN d.device_type = 'moisture_sensor' THEN r.reading_value END), 2) AS avg_moisture,
  wl.condition_score AS weather_score,
  ROUND((wl.condition_score * 
        AVG(CASE WHEN d.device_type = 'temp_sensor' THEN r.reading_value END)) /
        AVG(CASE WHEN d.device_type = 'moisture_sensor' THEN r.reading_value END), 2) AS nutrient_index
FROM reading r
JOIN device d ON r.device_id = d.device_id
JOIN weatherlog wl 
  ON wl.location_id = d.location_id 
  AND DATE(r.read_time) = wl.recorded_on
GROUP BY d.location_id, DATE(r.read_time), wl.condition_score;
