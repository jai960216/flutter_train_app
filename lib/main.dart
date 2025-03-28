import 'package:flutter/material.dart';
import 'station_list_page.dart';

// 앱 실행의 시작점, MyApp 위젯을 실행시킴
void main() {
  runApp(const MyApp()); // Flutter 앱 실행 위젯으로 MyApp 지정
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 위젯의 UI를 구성하는 메서드
    return MaterialApp(
      title: 'Flutter Train App', // 앱 이름 설정
      home: const HomePage(), // 앱의 첫 화면으로 HomePage 위젯 설정
    );
  }
}

// 앱의 홈페이지 위젯, 출발역과 도착역 선택 UI 포함
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 기본 앱 화면
      appBar: AppBar(
        title: const Text('기차 예매'), // 앱바 제목목
        centerTitle: true, // 앱바 제목을 중앙에 배치
      ),
      body: Container(
        // 화면 본문 내용을 감싸는 컨테이너
        color: Colors.grey[200], // 배경색 설정
        padding: const EdgeInsets.all(20), // 컨테이너 내부 여백을 모든 방향으로 20 설정
        child: Column(
          // 세로 방향으로 위젯들을 배치
          mainAxisAlignment: MainAxisAlignment.center, // 세로 방향 가운데 정렬
          children: [
            Container(
              // 출발역/도착역 선택 영역 컨테이너
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white, // 배경색
                borderRadius: BorderRadius.circular(20), // 모서리 둥글기
              ),
              child: Row(
                // 가로 방향으로 위젯들을 배치
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 가로 방향 균등 배치
                children: [
                  // 출발역 선택 부분
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          // '출발역' 레이블 텍스트
                          '출발역',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '선택',
                          style: TextStyle(fontSize: 40),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // 세로선 - 출발역과 도착역 사이 구분선
                  Container(width: 2, height: 50, color: Colors.grey[400]),

                  // 도착역 선택 부분
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          // '도착역' 텍스트
                          '도착역',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '선택',
                          style: TextStyle(fontSize: 40),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // 좌석 선택 버튼
            SizedBox(
              // 버튼의 크기를 지정
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                // 입체감 있는 버튼
                onPressed: () {
                  Navigator.push(
                    // 새 화면으로 이동
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StationListPage(),
                    ), // 역 선택 페이지로 이동
                  );
                },
                style: ElevatedButton.styleFrom(
                  //버튼 스타일일
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    // 버튼 모양 설정
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  // 버튼 내부 텍스트
                  '좌석 선택',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
