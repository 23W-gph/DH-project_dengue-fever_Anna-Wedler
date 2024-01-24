library(pacman)
pacman::p_load(
  ggplot,
  ggpubr
  )

source("scripts/script_clean.R")

# Group data -------------------------------------
  
  #Group by area type
  ll_by_area_type <- dengue_env %>%  
    group_by(area, outcome, area_type) %>% 
    tally()
  
  #Group by house type
  ll_by_house_type <- dengue_env %>%  
    group_by(area, outcome, house_type) %>%  
    tally()

#Plot data----------------------------------------
 
  #Plot distribution by area type
  ggplot(ll_by_area_type, aes(x=area, y=n, fill=area_type)) + geom_col() +
  labs(title = "Distribution by area type", x = "Area in Dhaka", y = "Number of cases") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
       
  #Plot distribution by house type
  ggplot(ll_by_house_type, aes(x=area, y=n, fill=house_type)) + geom_col() +
  labs(title = "Distribution by house type", x = "Area in Dhaka", y = "Number of cases") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 





