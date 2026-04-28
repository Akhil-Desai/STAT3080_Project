# Part 2: Hypothesis Test Results

## 1. Overview
Due to the limitations of the BLS summary tables (which provide medians but no sample standard deviations or microdata), testing means via a two-sample t-test is impossible. Instead, we shifted focus to the structural composition of the labor market using a **One-Sample Z-Test for a Population Proportion**.

## 2. Research Question
**Question:** Do women make up less than half (50%) of the full-time wage and salary workforce?

**Hypotheses:**
*   $H_0: p = 0.5$
*   $H_a: p < 0.5$

## 3. Assumptions Verification
1.  **Independence:** The CPS uses a complex, stratified multistage probability sampling design. The resulting sample is nationally representative. Given the sample size ($n = 120,907$ in thousands) is far less than 10% of the entire U.S. population, the independence condition is satisfied.
2.  **Success/Failure Condition:** We must expect at least 10 successes and 10 failures under the null hypothesis.
    *   $np_0 = 120,907 \times 0.5 = 60,453.5 \ge 10$
    *   $n(1-p_0) = 120,907 \times 0.5 = 60,453.5 \ge 10$
    Both conditions are met, allowing us to assume the sampling distribution of $\hat{p}$ is approximately normal.

## 4. Test Results
*   **Total Sample ($n$):** 120,907
*   **Total Women:** 54,207
*   **Sample Proportion ($\hat{p}$):** 0.4483
*   **Test Statistic ($Z^2$ or $X^2$):** 1290.9
*   **p-value:** $< 2.2 \times 10^{-16}$

## 5. Conclusion
With a p-value approaching zero, we reject the null hypothesis. The data provide statistically significant evidence that women constitute a minority of the U.S. full-time wage and salary workforce (approximately 44.8%). These findings generalize to the entire U.S. civilian noninstitutional full-time workforce for 2023.
