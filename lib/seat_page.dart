import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  const SeatPage({super.key});

  @override
  State<SeatPage> createState() => SeatPageState(); // 위젯의 상태 클래스 생성
}

// SeatPage 위젯의 상태를 관리
class SeatPageState extends State<SeatPage> {
  // 좌석 선택 상태 저장
  Map<String, bool> selectedSeats = {};

  //좌석을 탭하면 선택/해제를 전환
  void toggleSeat(int row, String col) {
    final seatKey = "$row-$col"; // 행과 열로 좌석 키 만들기
    setState(() {
      // 상태 변경 시 UI를 다시 그리도록 알림
      if (selectedSeats.containsKey(seatKey)) {
        // 이미 선택된 좌석이면
        selectedSeats.remove(seatKey); // 선택 해제
      } else {
        // 선택되지 않은 좌석이면
        selectedSeats[seatKey] = true; // 선택
      }
    });
  }

  // 좌석이 선택되었는지 확인하는 함수
  bool isSeatSelected(int row, String col) {
    final seatKey = "$row-$col";
    return selectedSeats.containsKey(seatKey);
  }

  @override
  Widget build(BuildContext context) {
    // 위젯의 UI를 구성
    final columns = ['A', 'B', 'C', 'D'];
    final rowCount = 20;

    return Scaffold(
      // 기본 앱 화면 구조
      appBar: AppBar(title: const Text('좌석 선택'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '수서',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_circle_right_outlined, // 화살표 아이콘
                  size: 30,
                ),
                const SizedBox(width: 10),
                const Text(
                  '부산',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),

          // 좌석 상태 표시
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  // '선택됨' 상태 색상 표시 컨테이너
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    // 컨테이너 장식 설정
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('선택됨'),
                const SizedBox(width: 20),
                Container(
                  // '선택안됨' 상태 색상 표시 컨테이너
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    // 컨테이너 장식 설정
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('선택안됨'),
              ],
            ),
          ),

          const SizedBox(height: 20),
          // 좌석 배치도
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 50),
              ...columns.map(
                // A, B, C, D 각 열에 대한 위젯 생성
                (col) => Container(
                  // 열 레이블을 감싸는 컨테이너
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(col, style: const TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),

          // 좌석 배치도
          Expanded(
            // 남은 공간을 모두 차지하는 위젯
            child: ListView.builder(
              // 스크롤 가능한 목록
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: rowCount,
              itemBuilder: (context, rowIndex) {
                final row = rowIndex + 1;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // 행 번호를 감싸는 컨테이너
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        row.toString(), // 행 번호 텍스트
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),

                    // A, B, C, D 각 열의 좌석들
                    ...columns.map((col) {
                      final isSelected = isSeatSelected(
                        row,
                        col,
                      ); // 좌석의 선택 여부 확인

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: GestureDetector(
                          onTap: () => toggleSeat(row, col),
                          child: Container(
                            // 좌석 모양 컨테이너
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              // 컨테이너 장식 설정
                              color:
                                  isSelected ? Colors.purple : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),

          // 예매 버튼
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              // 버튼의 크기
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                // 입체감 있는 버튼
                onPressed: () {
                  // 버튼 클릭 시 실행할 함수
                  Navigator.pop(context); // 이전 화면으로 돌아가기
                },
                style: ElevatedButton.styleFrom(
                  // 버튼 스타일 설정
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    // 버튼 모양 설정
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  // 버튼 내부 텍스트
                  '예매 하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
