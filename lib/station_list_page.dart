import 'package:flutter/material.dart';
import 'seat_page.dart';

// 역 선택 페이지
class StationListPage extends StatelessWidget {
  const StationListPage({super.key});

  static List<String> stations = [
    "수서",
    "동탄",
    "평택지제",
    "천안아산",
    "오송",
    "대전",
    "김천구미",
    "동대구",
    "경주",
    "울산",
    "부산",
  ];

  @override
  Widget build(BuildContext context) {
    // 위젯의 UI를 구성하는 메서드
    return Scaffold(
      appBar: AppBar(title: const Text('출발역 선택'), centerTitle: true),
      body: ListView.builder(
        // 스크롤 가능한 목록 만들기
        itemCount: stations.length, // 목록의 아이템 개수 설정
        itemBuilder: (context, index) {
          // 아이템
          final station = stations[index]; // 현재 인덱스에 해당하는 역 이름 가져오기

          return Container(
            // 역 이름을 감싸는 컨테이너
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!), // 아래쪽에만 테두리 추가
              ),
            ),
            child: ListTile(
              // 목록 아이템 위젯
              title: Text(
                station,
                style: const TextStyle(
                  // 텍스트 스타일 설정
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SeatPage(),
                  ), // 좌석 선택 페이지로 이동
                );
              },
            ),
          );
        },
      ),
    );
  }
}
