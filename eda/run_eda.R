# eda/run_eda.R
# Script for Exploratory Data Analysis of BLS 2023 Wage Data

library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)
library(readr)

# 1. Load Data
clean_sex <- read.csv("../data/clean/cpsaat37.csv", stringsAsFactors = FALSE)
clean_edu <- read.csv("../data/clean/cpsaat54.csv", stringsAsFactors = FALSE)

# 2. Prepare Data
earnings_sex <- clean_sex |>
  filter(str_detect(characteristic, "Total, 16 years|Men, 16 years|Women, 16 years")) |>
  mutate(
    group = case_when(
      str_detect(characteristic, "Total") ~ "Total",
      str_detect(characteristic, "Men")   ~ "Men",
      str_detect(characteristic, "Women") ~ "Women"
    ),
    n_workers_2023     = as.numeric(n_2023),
    median_weekly_2023 = as.numeric(earnings_2023)
  ) |>
  select(group, n_workers_2023, median_weekly_2023)

edu_levels_ordered <- c(
  "Less than a high school diploma",
  "High school graduates, no college",
  "Some college or associate degree",
  "Bachelor's degree only",
  "Advanced degree"
)

earnings_edu <- clean_edu |>
  filter(str_detect(characteristic,
    "Less than a high school|High school graduates|Some college|Bachelor|Advanced degree")) |>
  filter(!str_detect(characteristic, "Bachelor.s degree and higher")) |>
  mutate(
    education = factor(characteristic, levels = edu_levels_ordered),
    n_workers          = as.numeric(n_total),
    median_weekly_2023 = as.numeric(earnings_total)
  ) |>
  arrange(education) |>
  select(education, n_workers, median_weekly_2023)

# Filter Dataset 3: Intersectionality (Race x Sex)
race_idx <- which(clean_sex$characteristic %in% c("White", "Black or African American", "Asian", "Hispanic or Latino ethnicity"))
earnings_race_sex <- bind_rows(lapply(race_idx, function(i) {
  data.frame(
    race = clean_sex$characteristic[i],
    sex = c("Men", "Women"),
    median_weekly = as.numeric(c(clean_sex$earnings_2023[i + 1], clean_sex$earnings_2023[i + 2]))
  )
})) |>
  mutate(race = factor(race, levels = c("White", "Black or African American", "Asian", "Hispanic or Latino ethnicity")))

# Filter Dataset 4: Age/Experience Curve
earnings_age <- clean_edu[c(3, 5, 6, 7, 9, 10), ] |>
  mutate(
    age_group = factor(trimws(characteristic), levels = trimws(characteristic)),
    median_weekly = as.numeric(earnings_total)
  ) |>
  select(age_group, median_weekly)

# 3. Numerical Summaries
dir.create("summaries", showWarnings = FALSE)
write_csv(earnings_sex, "summaries/numerical_summary_sex.csv")
write_csv(earnings_edu, "summaries/numerical_summary_edu.csv")
write_csv(earnings_race_sex, "summaries/numerical_summary_race_sex.csv")
write_csv(earnings_age, "summaries/numerical_summary_age_curve.csv")

# 4. Generate Graphical Summaries

dir.create("assets", showWarnings = FALSE)

# Plot 1: Earnings by Sex
earnings_sex_plot <- earnings_sex |> filter(group != "Total")
overall_median <- earnings_sex$median_weekly_2023[earnings_sex$group == "Total"]

p1 <- ggplot(earnings_sex_plot, aes(x = group, y = median_weekly_2023, fill = group)) +
  geom_col(width = 0.55, show.legend = FALSE, alpha = 0.9, color = "black", linewidth = 0.3) +
  geom_hline(yintercept = overall_median, linetype = "dotted",
             color = "#475569", linewidth = 0.8) +
  geom_text(aes(label = paste0("$", median_weekly_2023)),
            vjust = -0.8, size = 4, fontface = "bold", color = "#1e293b") +
  annotate("text", x = 2.45, y = overall_median + 20,
           label = paste0("Overall Median: $", overall_median),
           size = 3.5, color = "#475569", hjust = 1) +
  scale_fill_manual(values = c("Men" = "#3B82F6", "Women" = "#F43F5E")) +
  scale_y_continuous(labels = scales::dollar_format(),
                     limits = c(0, 1500),
                     expand = expansion(mult = c(0, 0.05))) +
  labs(
    title    = "Median Weekly Earnings by Sex",
    subtitle = "Full-time wage and salary workers, 2023",
    x        = NULL,
    y        = "Median Weekly Earnings (USD)",
    caption  = "Source: BLS-CPS 2023 Annual Averages, Table 37"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title       = element_text(face = "bold", size = 14, margin = margin(b=5)),
    plot.subtitle    = element_text(color = "#64748b", margin = margin(b=15)),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x      = element_text(size = 11, face = "bold")
  )

ggsave("assets/earnings_by_sex.png", p1, width = 6, height = 5, bg = "white", dpi = 300)

# Plot 2: Earnings by Education
p2 <- ggplot(earnings_edu,
       aes(x = median_weekly_2023, y = reorder(education, median_weekly_2023))) +
  geom_segment(aes(xend = 0, yend = reorder(education, median_weekly_2023)),
               color = "#cbd5e1", linewidth = 1) +
  geom_point(size = 5, color = "#2563EB") +
  geom_text(aes(label = paste0("$", median_weekly_2023)),
            hjust = -0.4, size = 3.8, fontface = "bold", color = "#1e293b") +
  scale_x_continuous(labels = scales::dollar_format(),
                     limits = c(0, 2300),
                     expand = expansion(mult = c(0, 0.05))) +
  scale_y_discrete(labels = scales::label_wrap(25)) +
  labs(
    title    = "Earnings by Educational Attainment",
    subtitle = "Full-time wage and salary workers aged 25+, 2023",
    x        = "Median Weekly Earnings (USD)",
    y        = NULL,
    caption  = "Source: BLS-CPS 2023 Annual Averages, Table 54"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title       = element_text(face = "bold", size = 14, margin = margin(b=5)),
    plot.subtitle    = element_text(color = "#64748b", margin = margin(b=15)),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y      = element_text(size = 11, lineheight = 0.9)
  )

ggsave("assets/earnings_by_education.png", p2, width = 8, height = 5, bg = "white", dpi = 300)

# Plot 3: Earnings by Race and Sex
p3 <- ggplot(earnings_race_sex, aes(x = race, y = median_weekly, fill = sex)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7, alpha = 0.9, color = "black", linewidth = 0.2) +
  geom_text(aes(label = paste0("$", median_weekly)),
            position = position_dodge(width = 0.8), vjust = -0.6, size = 3.5, fontface = "bold", color = "#1e293b") +
  scale_fill_manual(values = c("Men" = "#3B82F6", "Women" = "#F43F5E")) +
  scale_y_continuous(labels = scales::dollar_format(), limits = c(0, 2000), expand = expansion(mult = c(0, 0.05))) +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 15)) +
  labs(
    title    = "Intersectionality: Gender Wage Gap by Race/Ethnicity",
    subtitle = "Full-time wage and salary workers, 2023",
    x        = NULL,
    y        = "Median Weekly Earnings (USD)",
    fill     = "Sex",
    caption  = "Source: BLS-CPS 2023 Annual Averages, Table 37"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title       = element_text(face = "bold", size = 14, margin = margin(b=5)),
    plot.subtitle    = element_text(color = "#64748b", margin = margin(b=10)),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position  = "top",
    legend.title     = element_blank(),
    axis.text.x      = element_text(size = 11, angle = 0) # Width is sufficient for no-rotation due to wider plot
  )

ggsave("assets/earnings_race_sex.png", p3, width = 8.5, height = 5.5, bg = "white", dpi = 300)

# Plot 4: Earnings by Age Group
p4 <- ggplot(earnings_age, aes(x = age_group, y = median_weekly, group = 1)) +
  geom_line(color = "#94a3b8", linewidth = 1.2) +
  geom_point(size = 4.5, color = "#10B981") +
  geom_text(aes(label = paste0("$", median_weekly)), 
            vjust = -1.5, size = 3.8, fontface = "bold", color = "#059669") +
  scale_y_continuous(labels = scales::dollar_format(), limits = c(0, 1600), expand = expansion(mult = c(0, 0.15))) +
  scale_x_discrete(labels = function(x) str_remove(x, " years")) +
  labs(
    title    = "The Earnings-Experience Curve: Median Earnings by Age",
    subtitle = "Full-time wage and salary workers across all education levels, 2023",
    x        = "Age Group",
    y        = "Median Weekly Earnings (USD)",
    caption  = "Source: BLS-CPS 2023 Annual Averages, Table 54"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title       = element_text(face = "bold", size = 14, margin = margin(b=5)),
    plot.subtitle    = element_text(color = "#64748b", margin = margin(b=15)),
    panel.grid.minor = element_blank(),
    axis.text.x      = element_text(size = 11, angle = 0)
  )

ggsave("assets/earnings_age_curve.png", p4, width = 8, height = 5, bg = "white", dpi = 300)

# 5. Extract Spread and Gap Stats for context
earnings_range  <- diff(range(earnings_edu$median_weekly_2023))
earnings_ratio  <- max(earnings_edu$median_weekly_2023) / min(earnings_edu$median_weekly_2023)
sex_gap_dollars <- earnings_sex$median_weekly_2023[earnings_sex$group == "Men"] -
                   earnings_sex$median_weekly_2023[earnings_sex$group == "Women"]
sex_gap_pct     <- round(sex_gap_dollars /
                   earnings_sex$median_weekly_2023[earnings_sex$group == "Men"] * 100, 1)

stats <- data.frame(
  Metric = c("Earnings Range (Education)", "Earnings Ratio (Max/Min Education)", "Sex Gap (Dollars)", "Sex Gap (%)"),
  Value = c(earnings_range, earnings_ratio, sex_gap_dollars, sex_gap_pct)
)
write_csv(stats, "summaries/eda_key_statistics.csv")
