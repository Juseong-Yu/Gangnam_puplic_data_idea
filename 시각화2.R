# 주차장 위치와 주차위반단속현황으로 최적의 주차장 위치 구해보기
df_model1 <- merge(ParkingLot, NotLegalParking_organized, by.x = "소재지지번주소", by.y = "단속동", all = TRUE)

# 위도와 경도의 동 값 구하기
install.packages("rgdal")
library(rgdal)
