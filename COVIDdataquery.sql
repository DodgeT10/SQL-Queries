SELECT *
FROM `covidproject-365611.coviddata.coviddata`
WHERE continent IS NOT NULL
ORDER BY 3,4;

# Select data that we are going to be using 

SELECT  Location, date,total_cases, new_cases,total_deaths, population
FROM `covidproject-365611.coviddata.coviddata` 
WHERE continent IS NOT NULL
ORDER BY 1,2;

# Look at Total Cases Vs Total Deaths
# Shows the likelihood of dying if you contract COVID in your country

SELECT  Location, date,total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM `covidproject-365611.coviddata.coviddata` 
WHERE location = 'South Africa' AND continent IS NOT NULL
ORDER BY 1,2;

# Look at Total Cases vs Population
# Shows what percentage of population got COVID

SELECT  Location, date,population, total_cases,(total_cases/population)*100 AS PercentPopulationInfected
FROM `covidproject-365611.coviddata.coviddata` 
WHERE location = 'South Africa' AND continent IS NOT NULL
ORDER BY 1,2;

# Looking at countries with highest infection rate compared to population

SELECT  Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM `covidproject-365611.coviddata.coviddata` 
-- WHERE location = 'South Africa'
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

# Showing the countries with the highest death count per population

SELECT  Location, MAX(cast(total_deaths AS INT)) AS TotalDeathCount
FROM `covidproject-365611.coviddata.coviddata` 
-- WHERE location = 'South Africa'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotaldeathCount DESC;

# LET'S BREAK THINGS DOWN BY CONTINENT
# Showing continent with the highest death count perpopulation

SELECT  continent, MAX(cast(total_deaths AS INT)) AS TotalDeathCount
FROM `covidproject-365611.coviddata.coviddata` 
-- WHERE location = 'South Africa'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotaldeathCount DESC;

# GLOBAL NUMBERS

SELECT  date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS death_percentage
FROM `covidproject-365611.coviddata.coviddata` 
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

# Global cases, deaths and death percentage

SELECT  SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS death_percentage
FROM `covidproject-365611.coviddata.coviddata` 
WHERE continent IS NOT NULL
ORDER BY 1,2;


# Looking at Total Population vs Vaccinations

SELECT continent, location, date, population, new_vaccinations,
SUM(new_vaccinations) OVER (PARTITION BY location ORDER BY location,date) 
AS RollingPeopleVaccinated 
FROM `covidproject-365611.coviddata.coviddata`
WHERE continent IS NOT NULL;

