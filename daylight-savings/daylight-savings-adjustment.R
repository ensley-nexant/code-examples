library(tidyverse)
library(lubridate)


# create fake data ------------------------------------------------------------------------------------------------

days <- seq(ymd('2019-01-01'), ymd('2019-12-31'), by = 'day')
hours <- 0:23

interval <- crossing(days, hours) %>% 
  mutate(usage = rnorm(n(), 100, 10))


# adjust for DST --------------------------------------------------------------------------------------------------

# TODO
