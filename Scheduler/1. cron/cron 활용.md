### 📝 과제. cron 활용하여 현재 시간(날짜 포함)을 1분마다 콘솔에 출력하기

-----

- #### crontab 설정 내용


  1분마다 Main.java를 실행하는 스케줄러입니다 <br>

  Main.java에는 현재 날짜, 시간을 출력할 수 있는 코드가 작성되어 있습니다

  ``` 
  #CRONTAB FILE 
  # Classic crontab format:
  # Minutes Hours Days Months WeekDays Command
  
  * * * * * cd c:\SSAFY && java Main
  ```



  

- #### 스케줄러 결과 


  좌측 로그에서 스케줄러가 1분마다 실행되는 것을 확인할 수 있고<br>

  우측 출력 파일에서 스케줄러가 실행하는 프로그램의 결과를 확인할 수 있다


![image](https://user-images.githubusercontent.com/97875998/186696988-25220331-6941-4a05-a8c2-2c6aa0671e89.png)

<br>


