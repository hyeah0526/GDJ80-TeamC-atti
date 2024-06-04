# 아띠(ATTI) 종합 동물 병원 ERP 시스템 
<p align="center"><img src="https://github.com/GDJ80-TeamC/semi-atti/blob/8f925dfb9bf190914cec5ea716b3b41af4719ae5/atti/src/main/webapp/inc/logo.png" width="400" height="400"/></p>

## 1. 프로젝트 소개
반려 동물 시장이 증가함에 따라 의료 서비스를 제공하는 동물 병원의 필요성이 높아져 종합 동물 병원의 ERP시스템 구현

<img alt="Java" src ="https://img.shields.io/badge/Java-007396.svg?&style=for-the-badge&logo=Java&logoColor=white"/><img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white"><img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"><img src="https://img.shields.io/badge/mariaDB-003545?style=for-the-badge&logo=mariaDB&logoColor=white"><img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">


## 2. 팀원 구성
- 김인수 ([@Guinsu](https://github.com/Guinsu))
- 김지훈 ([@babpur](https://github.com/babpur)) 
- 박혜아 ([@hyeah0526](https://github.com/hyeah0526)) 
- 한은혜 ([@eunhyes](https://github.com/eunhyes))

## 3. 요구사항 명세서
- [요구사항 명세서 링크 이동](https://github.com/GDJ80-TeamC/semi-atti/blob/6572b27fb473d0ca1026451a540e9196287a7d22/atti/src/main/webapp/META-INF/document/GDJ80_teamC_%EC%9A%94%EA%B5%AC%EC%82%AC%ED%95%AD%20%EB%AA%85%EC%84%B8%EC%84%9C.png)
<img src="https://github.com/GDJ80-TeamC/semi-atti/blob/7147292df72ef10ce1464b42957e348adc7f379a/atti/src/main/webapp/META-INF/document/GDJ80_teamC_%EC%9A%94%EA%B5%AC%EC%82%AC%ED%95%AD%20%EB%AA%85%EC%84%B8%EC%84%9C.png" width="800"/>


## 4.  인터페이스 설계서 / ERD다이어 그램 
- [인터페이스 설계서 링크 이동](https://github.com/GDJ80-TeamC/semi-atti/blob/6572b27fb473d0ca1026451a540e9196287a7d22/atti/src/main/webapp/META-INF/document/GDJ80_teamC_%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4%EC%84%A4%EA%B3%84%EC%84%9C.png)
- [ERD 다이어그램 링크 이동](https://github.com/GDJ80-TeamC/semi-atti/blob/7147292df72ef10ce1464b42957e348adc7f379a/atti/src/main/webapp/META-INF/document/GDJ80_teamC_ERD%EB%8B%A4%EC%9D%B4%EC%96%B4%EA%B7%B8%EB%9E%A8.png)


## 5. 주요기능
### 1. 메인화면 
   - 오늘 날짜의 접수/수술/검사 리스트가 출력되며 로그인 한 아이디에 따라 해당 의사의 진료를 출력

### 2. 보호자 및 반려동물 조회 및 고객
   - 보호자 및 반려동물 전체조회
     - 접수하기
   - 고객 등록
   - 고객 상세정보
     - 펫 등록

### 3. 접수/예약
   - 오늘의 접수 내역 조회
   - 전체 예약 조회

### 4. 진료
   - 오늘의 진료 조회(로그인 한 아이디값에 따라 다른 화면 출력)
     - 접수 상태 변경(진료시작)
   - 진료 상세페이지
     - 보호자 / 반려동물 / 접수 정보 조회
     - 진료 내용 등록
     - 검사 등록 및 수정
     - 수술 등록 및 수정
     - 처방 등록 및 수정
     - 입원 등록

### 5. 검사
   - 검사 내역 전체 조회
     - 검사 상세보기
     
### 6. 수술
   - 수술 내역 전체 조회
     - 수술 상세보기
     - 수술 상태 변경(완료)

### 7. 처방
   - 처방 전체 조회

### 8. 입원
   - 입원실 현황 조회
   - 입원 환자 전체 조회
   - 입원 환자 상세보기
     - 입원 환자 진료 내용 등록
     - 입원 환자 상태 변경(퇴원)

### 9. 결제
   - 결제 전체 조회
     - 결제 상세 보기
        - 결제 완료 처리

### 10. 매출
   - 전전달 / 전달 / 현재달의 매출 그래프 표시
   - 각 달의 상세보기

### 11. 직원관리
   - 직원 전체 조회
   - 직원 상세보기
     - 직원 정보 수정
   - 신규 직원 등록

### 12. 로그인
  - 로그인
    - 비밀번호 수정
  - 로그아웃

## 6. 후기
#### 김인수 ([@Guinsu](https://github.com/Guinsu))
첫 팀프로젝트로 동물병원 ERP 프로그램을 만들게 되었습니다. 프로젝트를 진행하면서 소통과 기록의 중요성을 절실히 깨닫게 되었습니다. 같은 기능을 구현하더라도 팀원들의 생각이 제각각 달랐기 때문입니다. 그때 저는 왜 요구 사항 명세서와 스토리보드를 작성해야 하는지 알게 되었습니다.

팀원들과 회의를 통해 사용자가 필요로 하는 요구 사항들을 작성하고 스토리보드를 만들면서 서로 달랐던 기능 구현 방법을 하나의 방법으로 맞춰 나갔습니다. 또한, 그 과정에서 기록의 중요성도 깨닫게 되었습니다.

저희는 일일 회의를 진행했지만, 한 가지 주제가 아닌 여러 가지 주제로 회의를 진행하다 보니 팀원들의 의견을 정리하는 데 어려움을 겪었습니다. 그래서 저희는 한 가지 주제를 정해 토론을 진행하면서 하나씩 문제를 해결해 나갔습니다. 이러한 경험을 통해 소통과 기록의 얼마나 중요한지 다시 한번 알게 되었습니다. 
앞으로의 프로젝트에서는 소통과 기록을 더욱 철저히 하여 효율적인 팀 협업을 이루겠습니다.

#### 김지훈 ([@babpur](https://github.com/babpur)) 
처음 팀을 구성해 세미 프로젝트 설계할 때에는 기대보다 걱정이 더 컸던 것 같습니다.<br>
걱정거리가 많았지만 그중 하나는 결과물을 얻기 위해서 팀원끼리 협업한다는 데에 내 역할을 잘해낼 수 있을까라는 생각이 들었습니다.<br>
하지만 걱정과는 반대로 좋은 팀원들과 좋은 기억을 남기게 되었고 첫 번째 팀 프로젝트를 즐겁게 마칠 수 있었습니다.<br>
좋았던 부분도 있지만 다른 한편으로 프로젝트를 진행하면서 스스로 부족한 부분이 많다고 느꼈습니다.<br>
특히 작업물 하나하나 꼼꼼하게 확인하지 못한 부분에서 크게 와닿았고 제가 구현한 코드에 대해 다시 한번 생각해 보는 계기가 되었습니다.<br>
파이널 프로젝트에서는 세미 프로젝트 작업 중 부족하다고 느꼈던 부분을 보완해서 더 좋은 결과물을 만들고 싶습니다.

#### 박혜아 ([@hyeah0526](https://github.com/hyeah0526)) 
요구 사항 명세서부터 인터페이스 설계서 등 문서를 작성하여 프로젝트 진행해 보는 것은 처음이였습니다. 
프로젝트를 진행하면서 정말 많은 토론을 진행하였는데 팀원들 모두 열정을 가지고 참여해 주었습니다.

처음에는 전부 다 달랐던 생각이 팀원들과 토론하며 의견 차이를 줄여나가 하나의 ERP 시스템이 되어가는 것을 보며 협업에 대하여 경험해 볼 수 있었습니다. 
프로젝트를 구현해 나가면서 겹치는 부분이 많았기 때문에 다른 팀원분과 어떻게 진행할지 소통해 가면서 작업하는 과정이 힘들었지만 즐거웠습니다. 

또한 sql 관련하여 다양한 join문을 사용해 볼 수 있어 많은 공부가 되었습니다. 프로젝트를 진행하면서 많이 부족하다는 것을 느끼게 되어 부족한 부분을 채울 수 있도록 더 공부하여 파이널 프로젝트 때는 좀 더 발전된 결과물을 낼 수 있도록 하고 싶습니다.

#### 한은혜 ([@eunhyes](https://github.com/eunhyes))
수업 시간에 배운 쿼리 외에, SQLD 시험을 준비하면서 공부한 다양한 쿼리를 사용해 볼 수 있는 기회였습니다. 
전에 사용했던 것보다 훨씬 복잡한 쿼리를 직접 짜 보면서 자격증 공부와 프로젝트를 함께 마칠 수 있어 보람찬 시간이었습니다. 

코드적인 부분뿐만 아니라, DB 설계, 소프트웨어 개발 과정 등의 CS 지식들을 응용할 수 있고, 부족한 부분도 찾을 수 있는 기회였습니다.
좋은 팀원들을 만나 같은 목표를 향해가며 많이 배웠고, 즐거운 시간이었습니당



