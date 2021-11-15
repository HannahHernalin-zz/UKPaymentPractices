-- To check the imported PP1 dataset
SELECT *
FROM PortfolioProject..PP1$

-- To count the number of rows
SELECT Count(ReportId)
FROM PortfolioProject..PP1$

-- To calculate the total average time to pay
SELECT 
  ROUND(AVG(AverageTimeToPay) ,0) AS TotalAverageDaysToPay
FROM 
  PortfolioProject..PP1$

-- To calculate the percentage of UK businesses that pay within the reporting period (per month of 2019/year)
SELECT
  --YEAR(FilingDate) AS FilingYear, 
  MONTH(FilingDate) AS FilingMonth,
  COUNT(PaymentsMadeWithinReportingPeriod) AS WithinReportingPeriod
FROM
  PortfolioProject..PP1$
WHERE
  PaymentsMadeWithinReportingPeriod = 'Yes' AND
  YEAR(FilingDate) = 2019
GROUP BY 
--YEAR(FilingDate)
  MONTH(FilingDate)
ORDER BY
--YEAR(FilingDate)
  MONTH(FilingDate)


-- To calculate the percentage of UK businesses that pay outside the reporting period (per month of 2019/year)
SELECT
  --YEAR(FilingDate) AS FilingYear, 
  MONTH(FilingDate) AS FilingMonth,
  COUNT(PaymentsMadeWithinReportingPeriod) AS OusiteReportingPeriod
FROM
  PortfolioProject..PP1$
WHERE
  PaymentsMadeWithinReportingPeriod = 'No' AND
  YEAR(FilingDate) = 2019
GROUP BY 
--YEAR(FilingDate)
  MONTH(FilingDate)
ORDER BY
--YEAR(FilingDate)
  MONTH(FilingDate)

-- To calculate the percentage of UK businesses that did not state whether they paid within/outside the reporting period  (per month of 2019/year)
SELECT
  --YEAR(FilingDate) AS FilingYear, 
  MONTH(FilingDate) AS FilingMonth,
  COUNT(PaymentsMadeWithinReportingPeriod) AS NA
FROM
  PortfolioProject..PP1$
WHERE
  PaymentsMadeWithinReportingPeriod = 'NULL' AND
  YEAR(FilingDate) = 2019
GROUP BY 
--YEAR(FilingDate)
  MONTH(FilingDate)
ORDER BY
--YEAR(FilingDate)
  MONTH(FilingDate)

-- To calculate the total average time to pay per year (excluded 2017 and 2020 as they are incomplete)
SELECT 
  YEAR(FilingDate) AS FilingYear, ROUND(AVG(AverageTimeToPay) ,0) AS TotalAverageDaysToPay
FROM
  PortfolioProject..PP1$
--WHERE YEAR(FilingDate) >= 2018 AND YEAR(FilingDate) <= 2019
GROUP BY YEAR(FilingDate)
ORDER BY YEAR(FilingDate)


-- To get the top 20 UK businesses that pay their bills on time
SELECT
  TOP 20
  CAST(FilingDate AS DATE) AS FilingDate,
  Company, 
  CompanyNumber, 
  PaymentsMadeWithinReportingPeriod,
  AverageTimeToPay,
  PaymentTermsHaveChanged
FROM PortfolioProject..PP1$
WHERE
  PaymentsMadeWithinReportingPeriod = 'Yes' AND
  PaymentTermsHaveChanged = 'No' AND
  YEAR(FilingDate) >= 2018
ORDER BY
  AverageTimeToPay ASC

-- To get the top 20 UK businesses that do not pay their bills on time
SELECT
  TOP 20
  CAST(FilingDate AS DATE) AS FilingDate,
  Company, 
  CompanyNumber, 
  PaymentsMadeWithinReportingPeriod,
  AverageTimeToPay
FROM PortfolioProject..PP1$
WHERE
  PaymentsMadeWithinReportingPeriod = 'Yes' AND
  YEAR(FilingDate) >= 2018
ORDER BY
  AverageTimeToPay DESC
  
-- To check the imported PP2 dataset
SELECT *
FROM PortfolioProject..PP2$

-- To calculate the average percentages of invoices paid witin 30, between 31-60, and >=61 days per year (2017 to 2020)
SELECT
  YEAR(FilingDate) AS Year,
  AVG(PercentageOfInvoicesPaidWithin30days) AS Within30,
  AVG(PercentageOfInvoicesPaidBetween31and60days) AS Between31to60,
  AVG(PercentageOfInvoicesPaidLaterThan60days) AS Above60
FROM
  PortfolioProject..PP2$
GROUP BY
  YEAR(FilingDate)
ORDER BY
  YEAR(FilingDate)