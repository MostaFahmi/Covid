-------------DATA EXPLORATION---------------------
-------------------------------------------------
-----------------------------------------------
--Select *
--FROM CovidDeaths
-- WHERE  continent IS NOT NULL
--Order by 3


--Select *
--FROM CovidVaccination
--Order by 3,4


-- Exploring Total Cases vs Total Deaths and Death Probability
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 [Death Percentage]
FROM CovidDeaths
Order by 1,2

-- Exploring Total Cases vs Total Deaths and Death Probability in Egypt
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 [Death Percentage]
FROM CovidDeaths
WHERE location = 'Egypt'
Order by 1,2

-- Exploring The Top 3 Locations With Highst Death Probabilty
-- Where The Total Cases are Higher Than The Average

SELECT TOP 3 location, 
MAX([Death Percentage]) as [Highest Death Percentage]
FROM
(
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 [Death Percentage]
FROM CovidDeaths
WHERE  continent IS NOT NULL
) as temp
Where total_cases > (SELECT AVG(total_cases)
					 FROM CovidDeaths
					 )
Group by location
Order by [Highest Death Percentage] Desc


-- Exploring the infection rate to the population in Countries
---Total Cases vs Population

SELECT location, population, MAX(total_cases) [Highest No. of Cases], MAX(total_cases/population)*100 [Infection Rate]
FROM CovidDeaths
WHERE  continent IS NOT NULL
--AND location = 'Egypt'
Group by location,population
Order by 4 Desc


-- Exploring Total Deaths to the Population by Countries

SELECT location, population, 
MAX(CAST(total_deaths as float)) [Highest No. of Deaths] , 
MAX(CAST(total_deaths as float)/population)*100 [Death Rate]
FROM CovidDeaths
WHERE  continent IS NOT NULL
--AND location = 'Egypt'
Group by location,population
Order by 4 Desc




-- LET'S BREAK IT DOWN BY CONTINENTS --

-- Exploring Total Deaths to the Population by Continents


SELECT continent, SUM(population) [Total Population], 
MAX(CAST(total_deaths as float)) [Highest No. of Deaths] , 
MAX(CAST(total_deaths as float)/population)*100 [Death Rate]

FROM CovidDeaths
WHERE  continent IS NOT NULL
Group by continent
Order by 4 Desc

-- Ranking Countries within the Continents by Infection Rate

SELECT *,
Dense_Rank()over(partition by continent order by [Infection Rate] desc) as Country_Rank
FROM
(
SELECT continent, location, population, 
MAX(total_cases) [Highest No. of Cases], 
MAX(total_cases/population)*100 [Infection Rate]
FROM CovidDeaths
WHERE  continent IS NOT NULL
AND total_cases IS NOT NULL
Group by continent, location,population
) as temptable
Order by 1 



-- Looking at Egypt Rank in Africa

SELECT *
FROM
(
SELECT *,
Dense_Rank()over(partition by continent order by [Infection Rate] desc) as Country_Rank
FROM
(
SELECT continent, location, population, 
MAX(total_cases) [Highest No. of Cases], 
MAX(total_cases/population)*100 [Infection Rate]
FROM CovidDeaths
WHERE  continent IS NOT NULL
AND total_cases IS NOT NULL
Group by continent, location,population
) as temptable
) temptable2
WHERE location = 'Egypt'



-- rolling up Continents with Countries by total deaths

SELECT continent, location, SUM(CAST(total_deaths as Float)) as Total_Deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
AND total_deaths IS NOT NULL
Group by rollup(continent,location)

-- WINDOWING Countries within Continents by Total Cases
SELECT *,
		Previous_Country = Lag([Total Cases]) over(partition by continent order by [Total Cases]),
		The_Prev_Country = Lag(location) over(partition by continent order by [Total Cases]),
		Next_Country = Lead([Total Cases]) over(partition by continent order by [Total Cases]),
		The_Next_Country = Lead(location) over(partition by continent order by [Total Cases])
FROM
(
SELECT continent, location, MAX(total_cases) as [Total Cases]
FROM CovidDeaths
WHERE continent IS NOT NULL
AND total_cases IS NOT NULL
Group by continent, location
) temp

-- TEMP Table for Cumulative Cases and Deaths calculations

Drop Table If Exists #CumulatedTable
Create Table #CumulatedTable
(
Continent varchar(50),
Country varchar(50),
Date date,
Population float,
New_Cases int,
New_Deaths int,
Cumulative_Cases float,
Cumulative_Deaths float,
)
Insert into #CumulatedTable
SELECT continent, location, date, population, new_cases,new_deaths,
Cumlative_Cases = SUM(new_cases) over(partition by location order by location,date),
Cumlative_Deaths = SUM(new_deaths) over(partition by location order by location,date)
FROM CovidDeaths
WHERE continent IS NOT NULL

-- Use the Temp Table to Calculate Running Cases & Deaths to Population
SELECT Continent,Country,Date,Population, Cumulative_Cases,Cumulative_Cases, 
(Cumulative_Cases/Population)*100 [Cases Ratio],
(Cumulative_Deaths/Population)*100 [Deaths Ratio]
FROM #CumulatedTable
Order by Country,Date




-- Creating VIEW includes Deaths & Vaccination Tables

Alter View VDeaths_Vaccinations
AS
SELECT dth.continent,dth.location,dth.date,dth.population, vac.new_vaccinations
FROM CovidDeaths dth
JOIN CovidVaccination vac
ON vac.date=dth.date and vac.location = dth.location


-- CTE to calculate Vaccinated to Population Ratio

With CumulatedVaccination ( continent, location,date, population, New_Vaccinations, Cumulative_New_Vaccination)
as
(
SELECT continent, location,date, population, New_Vaccinations, 
Cumulative_New_Vaccination = SUM(Convert(float,New_Vaccinations)) over(Partition by location order by location,date) 
FROM VDeaths_Vaccinations
WHERE continent IS NOT Null
AND New_vaccinations IS NOT NULL
)
SELECT *, (Cumulative_New_Vaccination/population) *100 as [Vaccinated_Ratio]
FROM CumulatedVaccination











 







