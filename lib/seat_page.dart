import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // 좌석 선택 상태를 저장하는 맵
  Map<String, bool> selectedSeats = {};

  // 좌석 선택 토글 함수
  void toggleSeat(int row, String col) {
    final seatKey = "$row-$col";
    setState(() {
      if (selectedSeats.containsKey(seatKey)) {
        selectedSeats.remove(seatKey);
      } else {
        selectedSeats[seatKey] = true;
      }
    });
  }

  // 좌석 선택 여부 확인 함수
  bool isSeatSelected(int row, String col) {
    final seatKey = "$row-$col";
    return selectedSeats.containsKey(seatKey);
  }

  // 예매 확인 다이얼로그 표시
  void _showReservationDialog() {
    if (selectedSeats.isEmpty) {
      return;
    }

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('예매 확인'),
          content: Text(
            '${selectedSeats.length}개의 좌석을 예매하시겠습니까?\n'
            '${widget.departureStation} → ${widget.arrivalStation}',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text('확인'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final columns = ['A', 'B', 'C', 'D'];
    final rowCount = 20;

    return Scaffold(
      appBar: AppBar(title: const Text('좌석 선택'), centerTitle: true),
      body: Column(
        children: [
          // 출발역-도착역 정보 표시
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.departureStation,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_circle_right_outlined, size: 30),
                const SizedBox(width: 10),
                Text(
                  widget.arrivalStation,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),

          // 좌석 상태 안내 레이블
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('선택됨'),
                const SizedBox(width: 20),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
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

          // 좌석 열 헤더 (A, B, C, D)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 50),
              ...columns.map(
                (col) => Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(col, style: const TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),

          // 좌석 배치도 (스크롤 가능)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: rowCount,
              itemBuilder: (context, rowIndex) {
                final row = rowIndex + 1;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 행 번호
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        row.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),

                    // A~D 열 좌석들
                    ...columns.map((col) {
                      final isSelected = isSeatSelected(row, col);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: GestureDetector(
                          onTap: () => toggleSeat(row, col),
                          child: Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
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
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _showReservationDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
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
