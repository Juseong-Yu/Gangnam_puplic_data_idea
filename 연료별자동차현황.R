library(dplyr)

# 데이터 불러오기
carNow <- read.csv("data/강남구연료별자동차현황.csv")

# 데이터 병합(용도별 데이터 불필요)
carNow <- carNow %>%
  group_by(연료종류) %>%
  summarise(승용 = sum(승용),승합 = sum(승합),화물 = sum(화물)
            ,특수 = sum(특수),총등록대수 = sum(총등록대수))
