FOR each day:
    SELECT AVG(temperature) FROM readings WHERE date = day
    SELECT AVG(moisture) FROM readings WHERE date = day
    SELECT weather_score FROM weather_log WHERE date = day

    nutrient_index = (weather_score * avg_temperature) / avg_moisture

    STORE nutrient_index WITH the date
END