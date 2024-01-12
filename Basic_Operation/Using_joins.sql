--> Will practice the use of joins 



--Selecting vaccination on the day and populations which are from diff tables.
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From [SQL_COVID].[dbo].[Deaths]  dea
Join [SQL_COVID].[dbo].[Vaccine] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
