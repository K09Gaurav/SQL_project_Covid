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
