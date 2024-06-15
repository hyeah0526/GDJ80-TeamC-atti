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
<img src="https://github.com/GDJ80-TeamC/semi-atti/blob/6572b27fb473d0ca1026451a540e9196287a7d22/atti/src/main/webapp/META-INF/document/GDJ80_teamC_%EC%9A%94%EA%B5%AC%EC%82%AC%ED%95%AD%20%EB%AA%85%EC%84%B8%EC%84%9C.png" width="800"/>


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
첫 팀 프로젝트로 ERP 시스템을 만들게 되었습니다. 이 프로젝트를 진행하면서 가장 어려웠던 점은 바로 소통의 문제였습니다.<br>
기능 구현 방법에 대해 팀원들과 이야기를 나누는 과정에서 다양한 의견이 나왔습니다.<br>
예를 들어, "게시판 페이지에서 수정이 이루어져야 한다"고 주장하는 팀원이 있는 반면, "페이지 이동을 하고 게시판 수정 페이지에서 수정을 해야 한다"고 주장하는 팀원도 있었습니다. <br>
이처럼 각자의 경험과 생각을 바탕으로 제작하려다 보니, 통일된 방향을 잡기가 어려웠습니다.<br>
이 문제를 해결하기 위해 우리는 스토리보드, 요구사항 명세서, 인터페이스 설계서를 작성하기 시작했습니다. 이러한 문서들은 서로 다른 생각을 통합하고, 명확한 구현 방향을 제시하는 데 큰 도움이 되었습니다.<br>
이 과정을 통해 저는 "개발은 기록과 소통으로 완성된다"라는 말을 깊이 이해하게 되었습니다. 앞으로의 프로젝트에서도 철저한 기록과 원활한 소통을 통해 더 효율적인 팀 협업을 이루고자 합니다.<br>

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



