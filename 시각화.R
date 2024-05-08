install.packages("extrafont")

library(extrafont)
font_import()
library(ggplot2)
library(dplyr)
theme_set(theme_grey(base_family="AppleGothic"))

# 주정차위반단속현황 시각화
ggplot(data = NotLegalParking_graph, aes(x = 집계년도, y = n, col = 단속동)) + 
  geom_line() +
  scale_x_continuous(breaks = seq(min(NotLegalParking_graph$집계년도), 
                                  max(NotLegalParking_graph$집계년도), 
                                  length.out = 3))

# 주정차위반단속현황 면적대비 시각화
NotLegalParking_graph_area <- left_join(NotLegalParking_graph, area_km, by = "단속동")
NotLegalParking_graph_area <- NotLegalParking_graph_area %>%
  mutate(결과 = n / 면적 )

ggplot(data = NotLegalParking_graph_area, aes(x = 집계년도, y = 결과, col = 단속동)) + 
  geom_line() +
  scale_x_continuous(breaks = seq(min(NotLegalParking_graph$집계년도), 
                                  max(NotLegalParking_graph$집계년도), 
                                  length.out = 3))

# 주차장 위치 시각화
install.packages("ggmap")
library(ggmap)
register_google(key="AIzaSyC0U6lhBsLUQ8pPVbKg8aTOK-2ckK5R99U")
boxLocation = c(127.0207, 37.46461,127.1186, 37.53086)
Gangnam <- get_map(boxLocation, maptype = "roadmap")
ggplot() + geom_point(data = ParkingLot, aes(x = 경도, y = 위도, color = 소재지지번주소, size = 주차구획수))
ggmap(Gangnam) + geom_point(data = ParkingLot, aes(x = 경도, y = 위도, color = 소재지지번주소, size = 주차구획수))

# 연료별 자동차 현황
ggplot(data = carNow ,aes(x = reorder(연료종류, 총등록대수), y = 총등록대수)) + geom_col(aes(fill=총등록대수))+
  geom_text(aes(label=총등록대수),position=position_stack(vjust=0.5))

# 아파트 주차장면수 시각화
ggplot(data = ApartParking , aes(x = 동, y = 총주차면수)) + geom_col(aes(fill = 총주차면수))
ggplot(data = ApartParking , aes(x = reorder(동, 총주차면수), y = 총주차면수)) + geom_col(aes(fill = 총주차면수))

# 상점 분기별 시각화 / 면적 대비 분기별 시각화 (by 평균)
ggplot(data = store, aes(x = 분기, y = 전체, group = 동, col = 동)) +
  geom_line()

store_area <- left_join(store, area_km, by = "동")
store_area <- store_area %>%
  group_by(동) %>%
  summarise(평균 = mean(전체/면적))

ggplot(data = store_area, aes(x = 동, y = 평균)) + geom_col(aes(fill = 평균))
ggplot(data = store_area, aes(x = reorder(동, 평균), y = 평균)) + geom_col(aes(fill = 평균))
# 유동인구 분기별 시각화/ 면적 대비 분기별 시각화 (by 평균)
ggplot(data = people, aes(x = 분기, y = 길단위, col = 동, group = 동)) +
  geom_line()

ggplot(data = people, aes(x = 분기, y = 주거, col = 동, group = 동)) +
  geom_line()

ggplot(data = people, aes(x = 분기, y = 직장, col = 동, group = 동)) +
  geom_line()

people_area <- left_join(people, area_km, by = "동")
people_area <- people_area %>%
  group_by(동) %>%
  summarise(평균길단위 = mean(길단위),평균주거 = mean(주거),평균직장 = mean(직장))

ggplot(data = people_area, aes(x = 동, y = 평균길단위)) + geom_col(aes(fill = 평균길단위))
ggplot(data = people_area, aes(x = reorder(동, 평균길단위), y = 평균길단위)) + geom_col(aes(fill = 평균길단위))

ggplot(data = people_area, aes(x = 동, y = 평균주거)) + geom_col(aes(fill = 평균주거))
ggplot(data = people_area, aes(x = reorder(동, 평균주거), y = 평균주거)) + geom_col(aes(fill = 평균주거))

ggplot(data = people_area, aes(x = 동, y = 평균직장)) + geom_col(aes(fill = 평균직장))
ggplot(data = people_area, aes(x = reorder(동, 평균직장), y = 평균직장)) + geom_col(aes(fill = 평균직장))
