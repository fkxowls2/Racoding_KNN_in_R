my_knn <- function(train, test, cl, k, method='Euclidean'){
  result = c()
  for (i in 1:nrow(test)){
    train2 <- train
    if (method == 'Euclidean'){
      #다차원 유클리디안거리 계산(행렬 계산 사용)
      temp <- sqrt(rowSums(t(t(train)-c(t(test[i, ])))^2))
    }
    else if (method == 'Manhattan'){
      #다차원 맨해튼거리 계산(행렬 계산 사용)
      temp <- rowSums(abs(t(t(train)-c(t(test[i, ])))))
    }
    train2$temp <- temp  #거리계산값을 temp컬럼으로 추가
    train2$rnk <- rank(train2$temp, ties.method = 'min') #짧은 거리순으로 순위 부여
    train2$cl <- cl #클래스 데이터를 cl컬럼으로 추가
    top <- train2[train2$rnk <= k, 'cl'] #k개수만큼 짧은 순서대로 선택
    a <- names(which.max(table(top))) #클래스 빈도수 추출
    result <- append(result, a) #결과값을 result에 추가
  }
  return(result)
}
#############################################################
#유방암 데이터로 분류 실습
#데이터 로드
wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors=TRUE)
#데이터를 랜덤하게 섞기
set.seed(1)
wbcd_shuffle <- wbcd[ sample(nrow(wbcd)) ,  ]
wbcd_shuffle2 <- wbcd_shuffle[   , c(-1,-2) ] # 환자번호와 정답을 제외
#데이터 정규화
normalize <- function(x) {  return ( (x-min(x))  / ( max(x) - min(x) )  )   }
wbcd_n <- as.data.frame( lapply( wbcd_shuffle2, normalize )  ) 
summary(wbcd_n)
#정규화한 데이터를 훈련(90%)과 테스트 데이터(10%)로 분리
wbcd_train <- wbcd_n[ 1:512,   ] # 훈련 데이터 구성   
wbcd_test  <- wbcd_n[ 513 : 569,  ] # 테스트 데이터 구성
#클래스 데이터도 분리
wbcd_train_label <- wbcd_shuffle[ 1: 512 ,  2]
wbcd_test_label <- wbcd_shuffle[ 513 : 569 ,  2]
#유클리디안거리 방법 사용해서 분류
result <- my_knn(train=wbcd_train,  test=wbcd_test, cl=wbcd_train_label, k=1)
sum(result == wbcd_test_label)/57 *100 #정확도 96.49
#이원교차표로 확인
library(gmodels)
CrossTable( x=wbcd_test_label, y=result, prop.chisq=FALSE) #2개 오분류
#맨해튼거리 방법 사용해서 분류
result1 <- my_knn(train=wbcd_train,  test=wbcd_test, cl=wbcd_train_label, k=1,
                  method='Manhattan')
sum(result1 == wbcd_test_label)/57 *100 #정확도 100
CrossTable( x=wbcd_test_label, y=result1, prop.chisq=FALSE) #오분류 없음
