# Data Summary: BLS-CPS 2023 Annual Averages

This document outlines the data summary for the exploratory data analysis (Part 1) of the STAT 3080 project on U.S. wage and income inequality among full-time workers. It specifically addresses the data collection, modifications, and suitability requirements.

### (a) Population vs. Sample
The data represent a **sample**, not a census or full population dataset. Therefore, question (a) is not applicable. Please see section (b) for details on the sample selection.

### (b) Sample Selection and Collection
The data are drawn from the **Current Population Survey (CPS)**, a monthly household survey conducted jointly by the U.S. Census Bureau and the Bureau of Labor Statistics (BLS). The CPS is the primary source of labor force statistics for the population of the United States. 

- **Selection:** The survey utilizes a **stratified multistage cluster sampling** design. This means it is not a simple random sample but rather a complex probability sample designed to be nationally and state-wide representative of the civilian noninstitutional population aged 16 and over. 
- **Collection:** Each month, approximately 60,000 eligible households are interviewed. The survey employs a rotating panel design (4-8-4 rotation), where a household is in the sample for four consecutive months, out for eight, and then back in for four. The data provided here (2023 Annual Averages) aggregates these monthly samples across the full calendar year of 2023 to provide stable, annualized estimates.

### (c) Data Modifications After Collection
The data pulled from the BLS (Table 37 and Table 54) are pre-aggregated summary tables, not individual-level microdata. Several modifications were made to prepare the tables for analysis in R:

1. **Column Filtering:** The raw BLS tables include historical data (e.g., 2022). Only the current year (2023) columns were retained for this analysis.
2. **Row Filtering (Scope):** 
   - For Table 37 (Earnings by Sex), we retained only the top-level aggregates ("Total", "Men", "Women" for ages 16 and over). Age-specific and race-specific subgroups were removed.
   - For Table 54 (Earnings by Educational Attainment), we retained only the five mutually exclusive educational categories (e.g., "Less than a high school diploma", "Some college or associate degree"). We excluded overlapping summary rows (like "Bachelor's degree and higher").
3. **Data Type Conversion:** Numeric fields were published as character strings containing comma separators (e.g., "1,202") and dollar signs. These strings were stripped of non-numeric characters and converted into standard numerical data types.
4. **No Imputation:** Missing values were not imputed. We used the published medians exactly as provided by the BLS.

### (d) Potential Issues and Their Impact
There are several potential limitations to this dataset:

1. **Parameter Limitation (Medians vs. Means):** The BLS tables provide *median* weekly earnings, not *mean* earnings. While medians are highly robust to outliers (a common issue in income data), this limits our ability to use statistical tests that strictly require sample means or rely on sample variances. We will have to assess variance based on the spread across the medians of subgroups rather than within-group variances.
2. **Aggregated Summary Data:** We do not have access to individual-level observations (microdata). Because the data is already grouped, we cannot perform observation-level regression or ANOVA. Any hypothesis testing in Part 2 must rely on group-level summary statistics.
3. **Scope Restrictions:** The dataset is explicitly restricted to **full-time wage and salary workers**. It completely excludes part-time workers, the self-employed, and those outside the labor force. Consequently, any conclusions drawn from this analysis cannot be generalized to the entire U.S. adult population or the overall labor force.
4. **Sampling Error:** Because this is sample data, the published medians contain sampling error. The BLS does not publish confidence intervals or standard errors alongside these specific summary tables, making it harder to visually ascertain the margin of error before conducting formal hypothesis tests.

### (e) Appropriateness of the Data
Despite its limitations, the data are highly appropriate for answering the proposed research questions:

1. **Authoritative Source:** The BLS CPS is the "gold standard" for U.S. labor statistics and strictly meets the project's requirement to use reputable government data.
2. **Direct Alignment with Questions:** 
   - Table 37 directly provides the sample size and median weekly earnings disaggregated by sex, matching Q1 (comparing the center between male and female workers).
   - Table 54 directly provides earnings stratified by educational attainment, matching Q2 (analyzing the spread across education levels).
3. **Robustness:** By using Annual Averages comprising over 700,000 household observations throughout the year, the estimates are highly stable and largely immune to seasonal volatility or month-to-month anomalies.
