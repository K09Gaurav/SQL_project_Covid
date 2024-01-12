-- Practcing basic sql select query
-- Ordered in ascending order according to Country name and then date
select * from SQL_COVID..Deaths Order by location, date;
select * from SQL_COVID..Vaccine Order by location, date;

-- noticed that a few records had NULL as the Continent 
select * 
from SQL_COVID..Deaths 
where continent IS NOT NULL
Order by location, date;

select * 
from SQL_COVID..Vaccine 
where continent IS NOT NULL
Order by location, date;



--Too much Data to work with shortlisting a few Data to work with
select continent, location, date, population, total_cases, new_cases, total_deaths 
from SQL_COVID..Deaths 
where continent IS NOT NULL AND location IS NOT NULL
Order by location, date;

select continent,location,date,new_tests,total_tests,new_vaccinations,total_vaccinations
from SQL_COVID..Vaccine 
where continent IS NOT NULL AND location IS NOT NULL
Order by location, date;



--Now that the Data has been Norrowed I will First analyse the tables one by one and derive interesting points off it
--Table of Deaths will be First


--Analysing indivisual country data for The country "India"


select continent, location, date, population, total_cases, new_cases
from SQL_COVID..Deaths 
where continent IS NOT NULL AND location='india' AND total_cases IS NOT NULL
Order by location, date;
--By observation it was found that the first CASE OF COVID IN INDIA was on "2020-01-30"


select continent, location, date, population, total_cases, new_cases, total_deaths
from SQL_COVID..Deaths 
where continent IS NOT NULL AND location='india' 
Order by location,new_cases desc;
--By observation it was found that the highest number of Cases registered in a single day 
--was on "2021-05-07" and it was a total of "4,14,188"

select location, date, population, total_cases, new_cases, total_deaths , new_deaths
from SQL_COVID..Deaths 
where location = 'India' AND new_deaths <> 0
Order by location,date, new_deaths;
----By observation it was found that the first DEATH DUE TO COVID IN INDIA was on "2020-03-13"


--Will calculate the overall Death Percentage among the Infected
--by using Total Cases and Total Deaths

select continent, location, date, population, total_cases, new_cases, total_deaths,(total_deaths/total_cases)*100 as Death_Percent
from SQL_COVID..Deaths 
where continent IS NOT NULL AND location='india'
Order by location, date;
-- UNFORTUNATELY the code above was not working due to total deaths and total cases were in the format of nvarchar which apparently does not support aggregation functions
-- So what i did was i typecasted them into float for the calculation purposes

select continent, location, date, population, total_cases, new_cases, total_deaths,(cast(total_deaths as float)/cast(total_cases as float))*100 as Death_Percent
from SQL_COVID..Deaths 
where continent IS NOT NULL AND location='india'
Order by location, date;

-- Calculated Highest Date of Death Percent in INDIA 
select location, date, total_cases, new_cases, total_deaths,(cast(total_deaths as float)/cast(total_cases as float))*100 as Death_Percent
from SQL_COVID..Deaths 
where location='india' 
Order by Death_Percent DESC;
-- IT was on "2020-05-06" and the Death percentage was "3.42977465530157 %"


--Calculated Total percentage of population died at the end of 2023
select location, date, population, total_cases, new_cases, total_deaths,new_deaths, (cast(total_deaths as float)/cast(population as float))*100 as Death_Percent
from SQL_COVID..Deaths 
where location='india'
Order by location, date;
-- It was "0.0376323818504263"



--Table of --Table of Vaccine now

select TOP 1 location, date, total_tests, new_tests, total_vaccinations, people_vaccinated 
from SQL_COVID..Vaccine
where location = 'India' AND total_tests IS NOT NULL
order by date ASC
--ACC TO DATA First day of recording no of tests was on "2020-03-13" and it was 6500'


select location, date, cast(total_tests as float) as total_tests, new_tests, 
	cast(total_vaccinations as float) as total_vaccinations, people_vaccinated 
from SQL_COVID..Vaccine
where location = 'India' AND total_vaccinations IS NOT NULL 
order by date
--ACC TO Data first day of vaccination was on 2021-01-16 with no of vaccinations as 191181


select top 1 location, date, cast(total_tests as float) as total_tests, new_tests
from SQL_COVID..Vaccine
where location = 'India' 
order by new_tests desc
-- Highest no of tests in 1 day was on 2020-10-17 with no of teste be 999090

select TOP 1 location, DATE, (CAST(total_vaccinations as float)) as VACCNINED
from SQL_COVID..Vaccine
WHERE location = 'India'
order by VACCNINED DESC
-- tOTAL NO OF VACCINES = 2206751639




--NOW ANALYSING DATA of diff countries

select location, population, MAX(total_cases) as highest_infection_count
from SQL_COVID..Deaths 
group by location, population
Order by location;
--selected highest cases country wise

--How much Population is infected?
select location, population, MAX(total_cases) as highest_infection_count, MAX(total_cases/population)*100 as InfectionPercentage
from SQL_COVID..Deaths 
group by location, population
Order by location;


--HIghest infection Percentage
select location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/population)*100) as InfectionPercentage
from SQL_COVID..Deaths 
group by location, population
Order by InfectionPercentage desc;
--Country with highest percentage wrt to their population
--San Marino	Population="33690"	total cases="25292"	    InfectionPercentage="75.0727218759276"


--Countriy with highest no of cases registered
select TOP 1 location, population, MAX(cast(total_cases as float)) as highest_infection_count
from SQL_COVID..Deaths 
where continent IS NOT NULL
group by continent, location, population
Order by highest_infection_count desc;
--          United States	338289856	103436829


-- country with highest death count
select TOP 1 location, population, MAX(cast(total_deaths as float)) as highest_death_count
from SQL_COVID..Deaths 
where continent IS NOT NULL
group by continent, location, population
Order by highest_death_count desc;
--          United States	338289856	1144877



select location, MAX(CAST(total_vaccinations as float)) as VACCNINED
from SQL_COVID..Vaccine
group by location
order by VACCNINED DESC
--COUNTRY WITH HiGHEST NO OF VACCINATION IS CHINA WITH ="3491077000"






-- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [SQL_COVID].[dbo].[Deaths]
Where continent is not null 
Group by continent
order by TotalDeathCount desc


--Continent with highest Death count
--> continent	TotalDeathCount North America	1144877

Select TOP 1 continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [SQL_COVID].[dbo].[Deaths]
Where continent is not null 
Group by continent
order by TotalDeathCount desc









