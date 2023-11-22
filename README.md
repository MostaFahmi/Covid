#COVID-19 Dataset Exploration
##Overview
This GitHub repository showcases an in-depth exploration of the COVID-19 dataset for the years 2020 and 2021 using SQL queries. The analysis delves into key metrics such as deaths, vaccinations, and various statistical insights. The SQL queries employed cover a range of techniques including ranking, windowing, subqueries, views, and joins.

##Data Exploration
The data exploration phase encompasses a comprehensive look into COVID-19 statistics, including:

###Total cases vs. total deaths and death probability globally and specifically in Egypt.
Identification of the top 3 locations with the highest death probability, where total cases exceed the average.
Analysis of infection rates concerning the population in different countries.
Examination of total deaths in relation to the population of various countries.

###Continent-wise Analysis
####The analysis extends to a continental level, exploring:

###Total deaths in proportion to the population across continents.
Ranking countries within continents based on infection rates.
Specific insights such as the rank of Egypt within the African continent.
Windowing and Cumulative Analysis
Utilizing windowing functions and cumulative calculations, the analysis includes:

Rolling up continents with countries, showcasing total deaths.
Windowing countries within continents by total cases, providing insights into neighboring countries.
Cumulative cases and deaths calculations, including ratios to the population over time.
Additional Features
###The creation of a VIEW combining deaths and vaccination tables.
Calculation of vaccinated-to-population ratios using Common Table Expressions (CTEs).
This repository provides a comprehensive exploration of the COVID-19 dataset, offering valuable insights into the impact of the pandemic on a global and regional scale. The SQL queries and analyses presented here contribute to a deeper understanding of the data, and the repository 


