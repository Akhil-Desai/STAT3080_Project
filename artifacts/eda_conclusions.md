# EDA Conclusions — 4-Part Framework

This document outlines the conclusions of the Exploratory Data Analysis (EDA) on U.S. Wage & Income Inequality, answering the primary research questions based on a structured 4-part interpretative framework: (a) Initial conclusions, (b) Statistical interpretation, (c) Contextual implications, and (d) Topic summary.

## Q1: Is there a difference in the center of weekly earnings between male and female full-time wage and salary workers?

* **(a) Initial Conclusions:** 
  The numerical and graphical summaries indicate that male full-time workers have a consistently higher median weekly earnings center ($1,202) compared to female full-time workers ($1,005).
* **(b) Statistical Interpretation:** 
  The "center" of the distribution for male earnings is shifted upward relative to the female earnings distribution by a difference of $197 (a 16.4% relative gap). With men earning above the overall median ($1,117) and women earning below it, there is a pronounced separation in the central tendency of these two independent groups.
* **(c) Implications:** 
  In the context of the question, these patterns imply that full-time employment status alone does not equalize earnings across genders. The clear separation between the center of the distributions points to structural factors—such as occupational segregation or wage disparities—systematically affecting compensation based on sex.
* **(d) Topic Summary:** 
  Regarding the broader topic of U.S. Wage and Income Inequality, the gender earnings gap remains a prominent and measurable feature of the labor market. The typical male worker commands noticeably more per week than the typical female worker, a finding that will be robustly tested via two-sample hypothesis testing in Part 2.

## Q2: How does the spread of weekly earnings vary across educational attainment levels?

* **(a) Initial Conclusions:** 
  The summaries demonstrate a clear monotonic increase in median weekly earnings as educational attainment rises, beginning at $708 for those without a high school diploma and reaching $1,837 for those with an advanced degree.
* **(b) Statistical Interpretation:** 
  The earnings data exhibits a massive spread (between-group variance), with a $1,129 range from the lowest to the highest educational tier (a ratio of 2.59x). The sharpest variance between contiguous ranks occurs between "Some college" and "Bachelor's degree only" (a $477 dollar increase), highlighting significant between-group variability based on degree thresholds.
* **(c) Implications:** 
  This trend implies a strong "skills premium" built into the labor market. The wide spread suggests that crossing the threshold to a four-year degree drastically diverges a worker's earnings trajectory, whereas wages at lower educational tiers cluster much closer together.
* **(d) Topic Summary:** 
  In the context of U.S. wage inequality, educational attainment dictates a vast spread in earnings potential. The stark financial boundaries between education levels underscore how formal schooling structurally stratifies the full-time workforce, establishing a clear motivation for testing equality of variances (e.g., Levene's test) in Part 2.

*Note: All findings are strictly exploratory. No formal statistical inferences have been conducted.*
