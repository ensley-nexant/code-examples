library(tidyverse)
library(lubridate)


# create fake data ------------------------------------------------------------------------------------------------

days <- seq(ymd('2019-01-01'), ymd('2019-12-31'), by = 'day')
hours <- 0:23

interval <- crossing(date = days, hr = hours) %>% 
  mutate(usage = rnorm(n(), 100, 10))


# adjust for DST --------------------------------------------------------------------------------------------------

dst_start <- ymd('2019-03-10')
dst_end <- ymd('2019-11-03')
dst_hr <- 2

is_daylight_savings <- function(df) {
  is_dst <- ((df$date > dst_start) | (df$date == dst_start & df$hr >= dst_hr)) &
            ((df$date < dst_end) | (df$date == dst_end & df$hr < dst_hr))
  
  is_dst
}

interval <- interval %>% 
  mutate(hr_dst = if_else(is_daylight_savings(interval), (hr + 1L) %% 24L, hr),
         date_dst = if_else(hr != hr_dst & hr_dst == 0, date + days(1), date))
