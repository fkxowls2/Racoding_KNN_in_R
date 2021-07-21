# Racoding_KNN_in_R
### K-Nearest Neighbor Algorithm
> KNN은 최근접 이웃 알고리즘이라고하며 Classification의 대표적인 알고리즘으로 지도 학습(supervisor Learning)에 해당합니다.
> 
> KNN 알고리즘을 간단하게 정의하자면 새로운 데이터와 기존 데이터들간 거리를 측정하고 
>
> 가까운 데이터들의 종류가 무엇인지 확인하여 새로운 데이터의 종류를 판별하는 알고리즘입니다.

### 직접 작성한 KNN 분류 알고리즘을 가지고 유명한 위스콘신 유방암 데이터로 분류 실습
### 기존 KNN과 다른점은?
* 유클리디안 거리 뿐만 아니라 맨해튼 거리계산 방식도 사용가능

|거리계산|결과|
|:--:|:--:|
|유클리디안|![image](https://user-images.githubusercontent.com/72850237/126509449-0728c6fc-8e2f-4497-a8e7-91df597df961.png)<br>정확도 96%, 오분류 2개|
|맨해튼|![image](https://user-images.githubusercontent.com/72850237/126510160-1da93110-8971-4382-b594-119c731eb22a.png)<br>정확도 100%, 오분류 0개|
