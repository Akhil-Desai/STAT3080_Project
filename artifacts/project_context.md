# STAT 3080 Project — Context & Design Decisions

## Overview

| | Part 1 | Part 2 |
|---|---|---|
| **Due (GitHub)** | April 12, 2026 @ 11:59 PM | April 28, 2026 @ 11:59 PM |
| **Due (Canvas)** | April 28, 2026 @ 11:59 PM | April 28, 2026 @ 11:59 PM |
| **Points** | 10 pts | 10 pts |
| **Page Limit** | Max 7 pages (excl. references) | Max 4 pages (separate doc) |
| **Late Penalty** | 4-pt deduction **per hour** late | Same |

> [!CAUTION]
> The late penalty is severe: **4 points per hour**. Part 1 GitHub push was due April 12, 2026 @ 11:59 PM.

---

## Team & Data Requirements

- **Teams:** Individual or groups of up to 3. All member names must appear on report.
- **GitHub:** All code (`.Rmd`), datasets, and report must be pushed to the team repo. Include repo URL on page 1 of report.
- **Data Sources:** Real data only — from government agencies, reputable global/news/non-profit orgs, academic researchers, or sports leagues.
- **AI Policy:** Generative AI use is permitted and encouraged. AI attribution must follow UVA guidelines (in references).\n- **Reproducibility:** All results must be reproducible from the repository. Every file must have an informative header.

---

## Part 1 — Exploratory Data Analysis

### Research Questions
- Pick **up to 3 preliminary questions** focusing on one or two specific parameters (center, spread, proportion, etc.)
- Questions must be answerable by a **standalone statistical test** (no regression, time series, or predictive modeling — those are not used in Part 2 either)

### Report Sections

1. **Introduction** — Topic and research question(s)
2. **Data Summary** — How data was collected/selected, any modifications made, potential issues, and why it's appropriate for the question
3. **Exploratory Analysis**
   - At least **2 numerical summaries**
   - At least **2 graphical summaries** using `ggplot2`
   - All graphics must be properly labeled and titled
   - > [!IMPORTANT]
     > **Do NOT perform any statistical inference (hypothesis tests, CIs) in Part 1.** EDA only.
4. **Conclusions** — Initial findings based purely on exploratory analysis, contextualized
5. **References** — ASA citation style; include GitHub repo URL on page 1

### Part 1 Grading Criteria
1. Clearly articulates the research question
2. Thoroughness of exploratory analysis
3. Readability of R code and report

---

## Part 2 — Hypothesis Testing (Context Only — Not Due Yet)

### Report Sections (for awareness)

1. **Introduction** — Restate topic/question; recap Part 1 findings
2. **Methods**
   - Choose **one research question** and **one standalone hypothesis test**
   - Justify why the procedure is appropriate
   - **Verify all assumptions graphically** (and/or with secondary tests) — "large sample size" is NOT sufficient for normality
3. **Results** — Show all code and output; interpret components; state statistical significance
4. **Conclusions** — Non-statistical interpretation; limitations; generalizability
5. **References** — On a new page; include AI attribution if applicable

### Part 2 Grading Criteria
1. Design, application, and interpretation of hypothesis test
2. Justification of chosen procedure
3. Statistical AND non-statistical answer to research question
4. R code and report readability

---

## Key Restrictions Across Both Parts
- No linear/logistic regression
- No time series or predictive modeling
- Part 2 is a **separate document** — does not include Part 1 content
- Standalone tests only (t-test, z-test, proportion test, etc.)

---

## Project Design — Part 1 Decisions

### Topic
**U.S. Wage & Income Inequality among Full-Time Workers**

### Dataset
- **Source:** U.S. Bureau of Labor Statistics — Current Population Survey (BLS-CPS)
- **Year:** 2023 Annual Averages (fully finalized; cleaner than 2024)
- **Scope:** Full-time wage and salary workers
- **Key BLS Tables to pull from:**
  - Table 1: Median weekly earnings by sex (full-time workers)
  - Table 37 / CPSAAT37: Median weekly earnings by sex and educational attainment
  - Occupational earnings tables (supplementary if needed)

### Research Questions (Finalized — 2)

| # | Question | Parameter | Potential Part 2 Test |
|---|---|---|---|
| **Q1** | Is there a difference in the center of weekly earnings between male and female full-time wage and salary workers? | Center (median/mean) | Two-sample t-test or Wilcoxon rank-sum |
| **Q2** | How does the spread of weekly earnings vary across educational attainment levels? | Spread (variance / IQR) | Levene's test |

> **Design rationale:** Q1 and Q2 are complementary — Q1 asks *who* earns differently, Q2 asks *why the variance differs*. Both use the same BLS-CPS 2023 source. Q1 is the primary candidate for the Part 2 hypothesis test.

### Finalized Introduction (Draft)

> The gender wage gap, the returns to education, and the variability of earnings across skill levels represent some of the most persistent features of the American labor market. Despite decades of policy attention, full-time female workers continue to earn substantially less than their male counterparts on average, while wage inequality across educational attainment groups remains stark. Using publicly available data from the U.S. Bureau of Labor Statistics' Current Population Survey (BLS-CPS, 2023 Annual Averages), this report investigates the structure of wage inequality among full-time wage and salary workers in the United States. Specifically, we explore two preliminary questions: (1) whether a disparity exists in the center of the weekly earnings distribution between male and female workers, and (2) how the spread of weekly earnings varies with educational attainment. This exploratory analysis lays the groundwork for formal inference, to be conducted in Part 2.
