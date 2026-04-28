# eda/run_hypothesis_test.R
# Script for Part 2 Hypothesis Testing

library(dplyr)
library(stringr)
library(readr)

# 1. Load Data
clean_sex <- read.csv("../data/clean/cpsaat37.csv", stringsAsFactors = FALSE)

# 2. Extract Data
earnings_sex <- clean_sex |>
  filter(str_detect(characteristic, "Total, 16 years|Men, 16 years|Women, 16 years")) |>
  mutate(
    group = case_when(
      str_detect(characteristic, "Total") ~ "Total",
      str_detect(characteristic, "Men")   ~ "Men",
      str_detect(characteristic, "Women") ~ "Women"
    ),
    n_workers_2023 = as.numeric(n_2023)
  )

n_total <- earnings_sex$n_workers_2023[earnings_sex$group == "Total"]
n_women <- earnings_sex$n_workers_2023[earnings_sex$group == "Women"]

# 3. Run Test
# H0: p = 0.5 vs Ha: p < 0.5
test_res <- prop.test(x = n_women, n = n_total, p = 0.5, alternative = "less", correct = FALSE)

# 4. Save Results
results_df <- data.frame(
  n_total = n_total,
  n_women = n_women,
  sample_proportion = as.numeric(test_res$estimate),
  null_probability = as.numeric(test_res$null.value),
  x_squared = as.numeric(test_res$statistic),
  df = as.numeric(test_res$parameter),
  p_value = as.numeric(test_res$p.value),
  ci_lower = as.numeric(test_res$conf.int[1]),
  ci_upper = as.numeric(test_res$conf.int[2]),
  method = as.character(test_res$method)
)

dir.create("summaries", showWarnings = FALSE)
write_csv(results_df, "summaries/hypothesis_test_results.csv")
