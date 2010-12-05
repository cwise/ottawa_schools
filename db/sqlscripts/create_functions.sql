DELIMITER $$

DROP FUNCTION IF EXISTS Distance $$

CREATE FUNCTION Distance (lat1 FLOAT, lng1 FLOAT, lat2 FLOAT, lng2 FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
	DECLARE distance FLOAT;

	SET distance = (6371 * acos(cos(radians(lat1)) * cos(radians(lat2)) * cos(radians(lng2) - radians(lng1) ) + sin(radians(lat1)) * sin(radians(lat2))));

	RETURN distance;
END; 
$$

DELIMITER ;