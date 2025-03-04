select *
from PopulCollapse..data_last


--countries with highest popultion growth
SELECT TOP 20
       [Country Name],
       CAST([Population Growth] AS FLOAT) AS PopGrowth
FROM PopulCollapse..DATA
WHERE [Year] = 2023
  AND [Population Growth] IS NOT NULL
ORDER BY CAST([Population Growth] AS FLOAT) DESC;
 
 --countries with lowest popultion growth
SELECT TOP 50 [Country Name],
       CAST([Population Growth] AS FLOAT) AS PopGrowth
FROM PopulCollapse..DATA
WHERE [Year] = 2023
  AND [Population Growth] IS NOT NULL
ORDER BY CAST([Population Growth] AS FLOAT) ASC;

 --countries with highest birth rate
SELECT TOP 10 
       [Country Name], 
       CAST([Birth Rate] AS FLOAT) AS BirthRateFloat
FROM PopulCollapse..DATA
WHERE [Year] = 2022
  AND [Birth Rate] IS NOT NULL
  
ORDER BY CAST([Birth Rate] AS FLOAT) DESC;

 --countries with lowest birth rate
SELECT TOP 10 
       [Country Name], 
       CAST([Birth Rate] AS FLOAT) AS BirthRateFloat
FROM PopulCollapse..DATA
WHERE [Year] = 2022
  AND [Birth Rate] IS NOT NULL
  
ORDER BY CAST([Birth Rate] AS FLOAT) ASC;



--countries with highest GDP

SELECT [Country Name] , MAX(CAST([GDP per Capita] AS int)) AS HighestGDP
FROM PopulCollapse..data_last
WHERE [GDP per Capita] IS NOT NULL
GROUP BY [Country Name]
ORDER BY HighestGDP DESC;

--countries with lowest GDP


SELECT [Country Name] , MAX(CAST([GDP per Capita] AS int)) AS LowestGDP
FROM PopulCollapse..data_last
WHERE [GDP per Capita] IS NOT NULL
GROUP BY [Country Name]
ORDER BY LowestGDP Asc;


--countries with highest migration

SELECT [Country Name], AVG(TRY_CAST([Net Migration] AS INT)) AS HighestMIG
FROM PopulCollapse..data_last
WHERE TRY_CAST([Net Migration] AS INT) IS NOT NULL  
AND [Country Name] NOT IN (
    'High income', 'OECD members', 'Post-demographic dividend', 'European Union', 
    'Middle East & North Africa', 'Late-demographic dividend', 'Europe & Central Asia', 
    'Arab World', 'Euro area', 'Fragile and conflict affected situations', 
    'Pre-demographic dividend', 'North America', 'Early-demographic dividend', 
    'IBRD only', 'Central Europe and the Baltics', 'IDA blend', 
    'Middle East & North Africa (IDA & IBRD countries)', 'Middle East & North Africa (excluding high income)',
    'Upper middle income', 'Europe & Central Asia (IDA & IBRD countries)', 
    'Heavily indebted poor countries (HIPC)', 'East Asia & Pacific (excluding high income)',
    'East Asia & Pacific (IDA & IBRD countries)', 'Low income', 'Low & middle income',
    'Middle income', 'Least developed countries: UN classification', 'IDA & IBRD total', 
    'East Asia & Pacific', 'South Asia (IDA & IBRD)', 'South Asia', 
    'Lower middle income', 'IDA only', 'Africa Eastern and Southern', 
    'Sub-Saharan Africa (excluding high income)', 'Sub-Saharan Africa', 'Sub-Saharan Africa (IDA & IBRD countries)',
    'Latin America & Caribbean (excluding high income)', 'IDA total', 'Small states',
    'Latin America & the Caribbean (IDA & IBRD countries)', 'Latin America & Caribbean',
    'Other small states', 'Caribbean small states', 'Pacific island small states', 'World'
)
GROUP BY [Country Name]
ORDER BY HighestMIG DESC;




--countries with lowest migration

SELECT [Country Name], AVG(TRY_CAST([Net Migration] AS INT)) AS HighestMIG
FROM PopulCollapse..data_last
WHERE TRY_CAST([Net Migration] AS INT) IS NOT NULL  
AND [Country Name] NOT IN (
    'High income', 'OECD members', 'Post-demographic dividend', 'European Union', 
    'Middle East & North Africa', 'Late-demographic dividend', 'Europe & Central Asia', 
    'Arab World', 'Euro area', 'Fragile and conflict affected situations', 
    'Pre-demographic dividend', 'North America', 'Early-demographic dividend', 
    'IBRD only', 'Central Europe and the Baltics', 'IDA blend', 
    'Middle East & North Africa (IDA & IBRD countries)', 'Middle East & North Africa (excluding high income)',
    'Upper middle income', 'Europe & Central Asia (IDA & IBRD countries)', 
    'Heavily indebted poor countries (HIPC)', 'East Asia & Pacific (excluding high income)',
    'East Asia & Pacific (IDA & IBRD countries)', 'Low income', 'Low & middle income',
    'Middle income', 'Least developed countries: UN classification', 'IDA & IBRD total', 
    'East Asia & Pacific', 'South Asia (IDA & IBRD)', 'South Asia', 
    'Lower middle income', 'IDA only', 'Africa Eastern and Southern', 
    'Sub-Saharan Africa (excluding high income)', 'Sub-Saharan Africa', 'Sub-Saharan Africa (IDA & IBRD countries)',
    'Latin America & Caribbean (excluding high income)', 'IDA total', 'Small states',
    'Latin America & the Caribbean (IDA & IBRD countries)', 'Latin America & Caribbean',
    'Other small states', 'Caribbean small states', 'Pacific island small states', 'World'
)
GROUP BY [Country Name]
ORDER BY HighestMIG Asc;





-- Finding Countries with the Fastest Population Decline (2020-2024) with Ordered Years

SELECT [Country Name], [Year], [Population Total],
       LAG([Population Total]) OVER (PARTITION BY [Country Name] ORDER BY [Year]) AS Previous_Year_Population,
       ([Population Total] - LAG([Population Total]) OVER (PARTITION BY [Country Name] ORDER BY [Year])) AS Population_Change
FROM PopulCollapse..data_last
WHERE [Population Total] IS NOT NULL  
AND [Year] BETWEEN 2019 AND 2024  
AND [Country Name] NOT IN (
    'High income', 'OECD members', 'Post-demographic dividend', 'European Union', 
    'Middle East & North Africa', 'Late-demographic dividend', 'Europe & Central Asia', 
    'Arab World', 'Euro area', 'Fragile and conflict affected situations', 
    'Pre-demographic dividend', 'North America', 'Early-demographic dividend', 
    'IBRD only', 'Central Europe and the Baltics', 'IDA blend', 
    'Middle East & North Africa (IDA & IBRD countries)', 'Middle East & North Africa (excluding high income)',
    'Upper middle income', 'Europe & Central Asia (IDA & IBRD countries)', 
    'Heavily indebted poor countries (HIPC)', 'East Asia & Pacific (excluding high income)',
    'East Asia & Pacific (IDA & IBRD countries)', 'Low income', 'Low & middle income',
    'Middle income', 'Least developed countries: UN classification', 'IDA & IBRD total', 
    'East Asia & Pacific', 'South Asia (IDA & IBRD)', 'South Asia', 
    'Lower middle income', 'IDA only', 'Africa Eastern and Southern', 
    'Sub-Saharan Africa (excluding high income)', 'Sub-Saharan Africa', 'Sub-Saharan Africa (IDA & IBRD countries)',
    'Latin America & Caribbean (excluding high income)', 'IDA total', 'Small states',
    'Latin America & the Caribbean (IDA & IBRD countries)', 'Latin America & Caribbean',
    'Other small states', 'Caribbean small states', 'Pacific island small states', 'World'
)  -- Closing the NOT IN condition correctly

ORDER BY  [Year] ASC;  




--Countries with the Most Aging Population
SELECT TOP 30 [Country Name], MAX(CAST([Population Over 65] AS int)) AS Oldest_Population
FROM PopulCollapse..data_last
WHERE [Population Over 65] IS NOT NULL
GROUP BY [Country Name]
ORDER BY Oldest_Population DESC;



-- start here


--Countries with Birth Rate Below Replacement Level (2.1)\

SELECT TOP 10 [Country Name], 
              CAST([Fertility Rate] AS FLOAT) AS Fertility_Rate
FROM PopulCollapse..data_last
WHERE TRY_CAST([Fertility Rate] AS FLOAT) < 2.1
ORDER BY Fertility_Rate ASC;






-- Countries Where Death Rate > Birth Rate

SELECT [Country Name], [Birth Rate], [Death Rate],
       CAST([Birth Rate] AS FLOAT) - CAST([Death Rate] AS FLOAT) AS Net_Population_Growth
FROM PopulCollapse..data_last
WHERE [Birth Rate] IS NOT NULL AND [Death Rate] IS NOT NULL
ORDER BY Net_Population_Growth ASC;
