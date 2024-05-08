library(dplyr)

# 데이터 불러오기
ApartParking <- read.csv("data/아파트주차면수.csv")

# 총주차면수라는 열 만들기
ApartParking[is.na(ApartParking)] <- 0
ApartParking <- ApartParking %>%
  mutate(총주차면수 = 주차면수 + 장애인주차면수)

# 동별로 총주차면수의 합을 구하기
ApartParking <- ApartParking %>%
  group_by(동) %>%
  summarise(주차면수 = sum(주차면수), 장애인주차면수 = sum(장애인주차면수), 총주차면수 = sum(총주차면수))
