# COVID-19 Dataset Exploration

## Overview

This repository presents an extensive exploration of the COVID-19 dataset for 2020 and 2021 using SQL queries. The analysis covers crucial aspects, including deaths, vaccinations, and employs techniques such as ranking, windowing, subqueries, views, and joins.

## Data Exploration

- **Total Cases vs Total Deaths:**
  - Global and Egypt-specific analysis of total cases vs total deaths and death probability.
  - Identification of the top 3 locations with the highest death probability when total cases exceed the average.
  - In-depth examination of infection rates in different countries.
  - Analysis of total deaths in relation to the population of various countries.

## Continent-wise Analysis

- **Continental Metrics:**
  - Exploration of total deaths in proportion to the population across continents.
  - Ranking countries within continents based on infection rates.
  - Specific insights, such as the rank of Egypt within the African continent.

## Windowing and Cumulative Analysis

- **Windowing Functions:**
  - Rolling up continents with countries, showcasing total deaths.
  - Windowing countries within continents by total cases.
  - Cumulative cases and deaths calculations, including ratios to the population over time.

## Additional Features

- **View Creation:**
  - Creation of a VIEW combining deaths and vaccination tables.
- **Vaccination Ratios:**
  - Calculation of vaccinated-to-population ratios using Common Table Expressions (CTEs).

This repository offers a comprehensive exploration of the COVID-19 dataset, providing valuable insights into the global and regional impact of the pandemic. The SQL queries and analyses contribute to a deeper understanding of the data. Contributions for further exploration are welcome.



