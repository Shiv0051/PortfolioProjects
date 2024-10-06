--DATA EXPLORATION
select * 
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4

--select * 
-- from PortfolioProject..CovidVaccinations
-- order by 3,4

-- select data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

-- Looking at Total cases vs Total Deaths
-- Showing likelihood of dying if you contract covid in Canada
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%canada%'
order by 1,2


--looking at Total Cases Vs Population
--Shows what percentage of population got Covid
select location, date, total_cases, population, (total_cases/population)*100 as CasePercentage
from PortfolioProject..CovidDeaths
where location like '%canada%'
order by 1,2

-- looking at countries having high case rate compared to population
select location, max(total_cases) as HighinfectionCount, population, Max((total_cases/population))*100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%India%'
Group by location, population
order by PercentagePopulationInfected desc


-- lets break things down by continent
select location, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is null
Group by location
order by TotalDeathCount desc

--showing the countries having highest death count per population
select location, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not null
Group by location
order by TotalDeathCount desc


select continent, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not null
Group by continent
order by TotalDeathCount desc


--Showing COntinents with highest death count per population
select continent, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%India%'
where continent is not null
Group by continent
order by TotalDeathCount desc


--Global numbers
select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)
as DeathPercentage
from PortfolioProject..CovidDeaths
--where location like '%canada%'
where continent is not null
Group by date
order by 1,2

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)
as DeathPercentage
from PortfolioProject..CovidDeaths
--where location like '%canada%'
where continent is not null
--Group by date
order by 1,2


Select *
from PortfolioProject..CovidVaccinations vac
join PortfolioProject..CovidDeaths dea
	On dea.location = vac.location
	and dea.date = vac.date


--looking at total populations vs vaccinations
Select dea.location, dea.continent, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidVaccinations vac
join PortfolioProject..CovidDeaths dea
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

Select dea.location, dea.continent, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location)
from PortfolioProject..CovidVaccinations vac
join PortfolioProject..CovidDeaths dea
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

