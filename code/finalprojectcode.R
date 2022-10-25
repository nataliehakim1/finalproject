

knitr::opts_chunk$set(echo = TRUE)
here::i_am("code/finalprojectcode.R")


library(readr)


smoking_data <- read_csv(here::here("data/Smoke2.csv"), col_types = "dc")
show_col_types = FALSE
income_data <- read_csv(here::here("data/Income2.csv"), col_types = "dc")
smokeincome <- 
  merge(smoking_data, income_data, by = c("State", "Year"))


table1 <- cor.test(smokeincome$`Smoke everyday`, smokeincome$`Median Household Income`)$estimate
cor.test(smokeincome$`Smoke everyday`, smokeincome$`Median Household Income`)$p.value

national_med = 50054
smokeincome$'Binary Income' = ifelse(smokeincome$`Median Household Income`< national_med ,0,1)
smokeincome$'Median Household Income National Average' = ifelse(smokeincome$`Median Household Income`< national_med ,'Below Average','Above Average')

#aggregate(smokeincome$`Smoke everyday`,list(smokeincome$`Binary Income`), FUN = mean)

below = smokeincome[smokeincome$`Binary Income`==0,]
above = smokeincome[smokeincome$`Binary Income`==1,]

below = smokeincome[smokeincome$`Median Household Income National Average`=='Below Average',]
above = smokeincome[smokeincome$`Median Household Income National Average`=='Above Average',]

test = t.test(below$`Smoke everyday`, above$`Smoke everyday`, alternative = "two.sided", var.equal = TRUE)


#install.packages('psych')

library(psych)
library(knitr)
describeBy(smokeincome[,c('Smoke everyday' , 'Median Household Income')],group = smokeincome$`Median Household Income National Average`,fast = TRUE)

table2 <- matrix(c(test$statistic, test$p.value, test$conf.int), ncol = 4, byrow = TRUE)

colnames(table2) = c('T-statistic' , 'P-value' , 'lower 95% Conf. Int.' , 'upper 95% Conf. Int.')
rownames(table2) = c("")
tab = as.table(table2)
kable(table2)

library(ggpubr, quietly = TRUE)
figure1 <- ggboxplot(smokeincome, x = 'Median Household Income National Average', y = "Smoke everyday", ylab = "% of State Population that Smoke Everyday", title = "Percent of State Population that Smoke Everyday\n by Binary Median National Household Income", outer = TRUE, add = "jitter")

saveRDS(table1, file = here::here("output", "finalproject1.rds"))
saveRDS(table2, file = here::here("output", "finalproject2.rds"))
saveRDS(figure1, file = here::here("output", "finalproject3.rds"))
