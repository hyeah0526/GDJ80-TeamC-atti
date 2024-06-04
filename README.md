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
- [요구사항 명세서 링크 이동](https://github.com/GDJ80-TeamC/semi-atti/blob/7147292df72ef10ce1464b42957e348adc7f379a/atti/src/main/webapp/META-INF/document/GDJ80_teamC_%EC%9A%94%EA%B5%AC%EC%82%AC%ED%95%AD%20%EB%AA%85%EC%84%B8%EC%84%9C.png)
<img src="https://github.com/GDJ80-TeamC/semi-atti/blob/7147292df72ef10ce1464b42957e348adc7f379a/atti/src/main/webapp/META-INF/document/GDJ80_teamC_%EC%9A%94%EA%B5%AC%EC%82%AC%ED%95%AD%20%EB%AA%85%EC%84%B8%EC%84%9C.png" width="800"/>


## 4.  인터페이스 설계서 / ERD다이어 그램 
- [인터페이스 설계서 링크 이동](https://github.com/GDJ80-TeamC/semi-atti/blob/7147292df72ef10ce1464b42957e348adc7f379a/atti/src/main/webapp/META-INF/document/GDJ80_teamC_%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4%EC%84%A4%EA%B3%84%EC%84%9C.png)
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
