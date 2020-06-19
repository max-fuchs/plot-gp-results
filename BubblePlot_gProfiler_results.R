library(ggplot2)
library(dplyr)
library(scales)

##TODO create column GeneRatio in gProfiler results file devinding intersect
##     number by total term size
##TODO Set define result_file and color_var

##Read pre-filtered gProfiler list
gprofiler_results <- as.data.frame(read.csv(result_file))
head(gprofiler_results)

gprofiler_results$adjusted_p_value <- as.numeric(as.character(gprofiler_results$adjusted_p_value))
gprofiler_results$GeneRatio <- as.numeric(as.character(gprofiler_results$GeneRatio))

##Sort by GeneRatio descending
gprofiler_results <- gprofiler_results %>% arrange(GeneRatio)

#lock in factor level order
gprofiler_results$term_name <- factor(gprofiler_results$term_name, levels = gprofiler_results$term_name)

##Build the plot

ggplot(gprofiler_results,
       aes(x = gprofiler_results$GeneRatio, y = gprofiler_results$term_name )) + 
  geom_point(aes(size = GeneRatio, color = gprofiler_results$adjusted_p_value)) +
  scale_size_continuous(range = c(5, 10)) +
  theme_bw(base_size = 14) +
  scale_colour_gradient(limits = c(0, 0.05), low = color_var, name = "Adjusted p-value") +
  ylab(NULL) +
  xlab("GeneRatio") +
  scale_y_discrete(label = wrap_format(40)) +
  xlim(0.003,0.35)

