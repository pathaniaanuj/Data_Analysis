select * from dbo.all_fuels_data 
-- In this dataset 27,015 Rows and 8 columns
select COUNT(*) as Total_rows from dbo.all_fuels_data

--there are 5 types of commodity
--Natural gas, crude oil, breant crude oil, heating oil, RBOB Gasoline
select distinct(commodity) from dbo.all_fuels_data

--checking number of observation according to commodity
select commodity, COUNT(*) as Total_observations from dbo.all_fuels_data group by commodity order by 2

--this for checking max high of commodity
select commodity,COUNT(*) as Total_observations,max(high) as 'all_time_high' from dbo.all_fuels_data group by commodity order by 3 desc
-- this for checking all time low of commodity / fuels
select commodity,COUNT(*) as Total_observations,min(high)as 'all_time_low' from dbo.all_fuels_data group by commodity order by 3 

select * from dbo.all_fuels_data 
where commodity='RBOB Gasoline'
order by 8 desc ;


-- checking all time high volumn of fuels stock
select commodity,COUNT(*) as Total_observations,min(volume)as 'all_time_low' from dbo.all_fuels_data group by commodity order by 3 

-- checking all time high volumne
select commodity,COUNT(*) as Total_observations,max(volume)as 'all_time_high' from dbo.all_fuels_data group by commodity order by 3 desc



