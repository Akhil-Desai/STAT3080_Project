# Exploratory Data Analysis Summary

This document summarizes the findings from the Exploratory Data Analysis (EDA) portion of the project (Part 1). The target datasets address U.S. Wage & Income Inequality among full-time workers using 2023 BLS-CPS Annual Averages.

This information is intended to be context for the hypothesis testing/reporting phase. 

All scripts related to this extraction are saved in the `eda/` folder (`run_eda.R`), which is configured to produce graphical and numeric summary CSVs for integration or visual review.

## EDA Requirements Met
1. **Numerical Summaries:** Median weekly earnings aggregated by Sex and Educational Attainment.
2. **Graphical Summaries:**
   - Bar chart of median weekly earnings by Sex.
   - Dot plot of median weekly earnings by Educational Attainment level.
3. No formal statistical inferences (CIs, hypothesis tests) have been conducted. Only group-level comparisons (center and spread) based on descriptive statistics were observed.

## Question 1: Gender Earnings Gap (Center focus)
**Research Question:** *Is there a difference in the center of weekly earnings between male and female full-time wage and salary workers?*

### Key Exploratory Findings:
- Target Group: Full-time wage and salary workers, 16 years and over.
- Overall Median: $1,117/week
- Male Median: $1,202/week 
- Female Median: $1,005/week
- **Observation:** Male full-time workers demonstrate a higher median weekly earning center compared to female workers. The derived gap is exactly $197/week (or roughly 16.4% lower relative to the male baseline).

## Question 2: Returns to Education (Spread focus)
**Research Question:** *How does the spread of weekly earnings vary across educational attainment levels?*

### Key Exploratory Findings:
- Target Group: Full-time wage and salary workers, 25 years and over.
- "Less than a high school diploma": $708/week
- "High school graduates, no college": $898/week
- "Some college or associate degree": $1,016/week
- "Bachelor's degree only": $1,493/week
- "Advanced degree": $1,837/week
- **Observation:** There is a clear monotonic increase in median earnings as formal educational attainment increases. 
- **Spread:** The difference from the lowest tier to the highest tier is $1,129 (Max/Min ratio of ~2.59x). The sharpest observed gap between contiguous ranks is between "Some college or associate degree" and "Bachelor's degree only" ($477/week increase). This points to significant earnings variance (spread) between these independent groups.

## Next Step Handoff Considerations
For Part 2 (Hypothesis Testing):
1. **Two-Sample Location Test for Q1:** A hypothesis test will need to verify if the $197 difference in the center of earnings between men and women is statistically significant. Example targets would be Wilcoxon rank-sum test or a large-sample group test, provided we have adequate representation of distribution shapes (e.g. variances / group sample sizes).
2._**Variance Test for Q2:**_ If selecting Q2 for the Part 2 focus, Levene's Test or similar tests for equality of variances would be logical paths to explore the differing spread across educational attainment stratifications. Since we operate off pre-aggregated table summaries with missing standard deviations, testing spread robustly without raw microdata requires extreme caution. Q1 is identified as the likely more viable candidate for Part 2 due to robust aggregate Ns. 
