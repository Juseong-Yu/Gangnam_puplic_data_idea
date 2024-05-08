install.packages("reshape")

library(dplyr)
library(utils)
library(stringr)
library(reshape)
# 데이터 불러오기
NotLegalParking <- read.csv("data/강남구_주정차위반단속위치현황.csv")

# 단속동이 강남구인 경우 단속장소에서 단속동을 찾아 넣기
NotLegalParking <-NotLegalParking %>%
  mutate(동 = str_extract(단속장소,"([가-힣]+동)"))

NotLegalParking$단속동 <- ifelse(NotLegalParking$단속동 == "강남구",NotLegalParking$동, NotLegalParking$단속동)

# 단속동이 법정동으로 명시된 경우 행정동으로 병합(율현동, 자곡동 -> 세곡동)
NotLegalParking$단속동 <- ifelse(NotLegalParking$단속동 == "율현동" | NotLegalParking$단속동 == "자곡동", "세곡동", NotLegalParking$단속동)

# 단속동과 연도별로 데이터 주기별로 정리하기
NotLegalParking <- NotLegalParking %>% 
  group_by(단속동, 집계년도) %>%
  summarise(n=n())

# 사용할 데이터로 가공
NotLegalParking_graph <- NotLegalParking %>%
  filter(!is.na(단속동) & !(단속동 == "가락동") & !(단속동 == "곡반정동") & !(단속동 == "도곡1동") & !(단속동 == "반포동") 
         & !(단속동 == "서초동") & !(단속동 == "성내동") & !(단속동 == "양재동") & !(단속동 == "역삼1동") & !(단속동 == "잠실동")
         & !(단속동 == "잠원동") & !(집계년도 == 2024))

NotLegalParking_organized <- cast(NotLegalParking_graph, 단속동 ~ 집계년도 )

# 파이썬으로 보낼 데이터
NotLegalParking_phyhon <- NotLegalParking_organized %>%
  group_by(단속동) %>%
  summarise(illegal = mean())
