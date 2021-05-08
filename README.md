# 블록체인의 실무응용 1 project contract 작성

## mapping 구성

1. _isbeneficiary
> address에 bool 변수 할당
> 
> true면 해당 address는 기부 수혜자, false면 기부자(일반 사용자)

2. _balances
> 남은 token의 양

3. _totaldonation
> 누적 기부액(수혜자의 경우 받은 기부액의 누적합, 기부자의 경우 해당 기부자의 기부 금액의 누적합)

4. _totaldonator
> 누적 기부자 수(1회 기부가 1명의 기부자로 인식됨; 중복 counting 가능)

5. _allowances
> 실습 예제 코드의 allowances를 배껴 옴(기부(출금) 허용되면 기록)

## constructor
> 어떤 것들이 들어가야 하는지 잘 몰라서..
> 
> 처음엔 address의 constructor인줄 알고 잘못 넣었다가 일단 이대로 냅뒀는데, 
> 
> 조금 더 공부를 해보고 고민을 해보려고 합니다! 
> 
> 아니면 다른 분이 작성해주신 constructor를 참고해도 좋을 것 같습니다!

## functions

#### name, symbol, balanceOf, allowance, approve는 예제 코드랑 비슷

1. isbene
>해당 address의 종류가 수혜자인지 기부자인지를 확인하는 function. (_isbeneficiary 이용)

2. totaldonation / totaldonator
> totaldonation은 누적 기부액을 확인하는 function.
> 
> totaldonator는 누적 기부자 수를 확인하는 function(만약 instance로 주어진 address가 기부자의 address일 경우에는 function 사용 불가)

3. donate
>예제 코드의 transfer랑 비슷한데 totaldonation, totaldonator 계산 작업만 추가됨

4. buytoken
> 예제 코드의 mint랑 비슷 / 따로 결제 과정이 필요

5. selltoken (수혜자 전용 : 기부받은 토큰 환급용)
> 예제 코드의 burn과 비슷 / 따로 환급 과정이 필요

##### 이상입니다

