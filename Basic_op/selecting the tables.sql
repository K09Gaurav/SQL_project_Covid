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


select continent, location, date, population, total_cases, new_cases, total_deaths,(cast(total_deaths as float)/cast(total_cases as float))*100 as Death_Percent
from SQL_COVID..Deaths 
where continent IS NOT NULL AND location='india' AND total_cases IS NOT NULL
Order by location, date, Death_Percent DESC;
--By observation it was found that the first CASE OF COVID IN INDIA was on "2020-01-30"


select continent, location, date, population, total_cases, new_cases, total_deaths
from SQL_COVID..Deaths 
where continent IS NOT NULL AND location='india' 
Order by location,new_cases desc;
--By observation it was found that the highest number of Cases registered in a single day 
--was on "2021-05-07" and it was a total of "4,14,188"



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
select continent, location, date, population, total_cases, new_cases, total_deaths,(cast(total_deaths as float)/cast(total_cases as float))*100 as Death_Percent
from SQL_COVID..Deaths 
where continent IS NOT NULL AND location='india' 
Order by Death_Percent DESC;

-- IT was on "2020-05-06" and the Death percentage was "3.42977465530157 %"

--

