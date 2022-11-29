# Look at data and see what colums we are dealing with 

SELECT  *
FROM `bigquery-public-data.sunroof_solar.solar_potential_by_postal_code` 
LIMIT 10;

# 1) Lets have a look at the difference between count qualified and the number of existing installs

SELECT  state_name, (SUM(count_qualified) - SUM(existing_installs_count)) AS Difference 
FROM `bigquery-public-data.sunroof_solar.solar_potential_by_postal_code`
GROUP BY state_name
ORDER BY Difference DESC
LIMIT 20;

# 2) Average yearly sunlight as a refelction of average kw potential

SELECT  state_name, CEILING(AVG(kw_median)) AS AVG_kw_median, CEILING(AVG(yearly_sunlight_kwh_median)) AS AVG_yearly_sunlight
FROM `bigquery-public-data.sunroof_solar.solar_potential_by_postal_code`
GROUP BY state_name
ORDER BY AVG_yearly_sunlight DESC;

# 3) Lets look at optimimum sunlight in the county containing that zip code (75%) compared to % of buildings that are suitable for solar

SELECT  state_name, CEILING(AVG(yearly_sunlight_kwh_kw_threshold_avg)) AS Min_sunlight_requirement, CEILING(AVG(count_qualified)) AS Buildings_suitable_for_solar
FROM `bigquery-public-data.sunroof_solar.solar_potential_by_postal_code`
WHERE yearly_sunlight_kwh_kw_threshold_avg > 1072
GROUP BY state_name
ORDER BY Buildings_suitable_for_solar DESC
LIMIT 20; 

# 4) Lets look at the Maximum total solar energy generation potential for north/south/east/west -facing roof space in the top 10 regions

SELECT  state_name, FLOOR(MAX(yearly_sunlight_kwh_n)) AS North_Facing,
 FLOOR(MAX(yearly_sunlight_kwh_s)) AS South_Facing,
  FLOOR(MAX(yearly_sunlight_kwh_e)) AS East_Facing,
   FLOOR(MAX(yearly_sunlight_kwh_w)) AS West_Facing
FROM `bigquery-public-data.sunroof_solar.solar_potential_by_postal_code`
GROUP BY state_name
ORDER BY North_Facing DESC
LIMIT 10; 

# 5) Potential Solar capacity related to roof space for panels, 75% of sunlight requirement and building availability

SELECT  COUNT(state_name), count_qualified, FLOOR(yearly_sunlight_kwh_kw_threshold_avg) AS Min_sunlight_requirement, number_of_panels_total
FROM `bigquery-public-data.sunroof_solar.solar_potential_by_postal_code`
GROUP BY count_qualified 
LIMIT 10;


# 6) Average total (75%) sunlight required for solar potential vs total solar energy generation potential for all roof space in that region

SELECT state_name, FLOOR(AVG(yearly_sunlight_kwh_kw_threshold_avg)) AS Min_sunlight_required , FLOOR(AVG(yearly_sunlight_kwh_total)) AS AVG_Potential_for_all_roof_space
FROM `bigquery-public-data.sunroof_solar.solar_potential_by_postal_code`
GROUP BY state_name
ORDER BY Min_sunlight_required DESC
LIMIT 10;