import 'package:flutter/material.dart';
import 'station_list_page.dart';
import 'seat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Train App', home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  // 출발역 선택 함수
  void _selectDepartureStation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => StationListPage(
              title: '출발역 선택',
              selectedStation: departureStation,
            ),
      ),
    );

    if (result != null) {
      setState(() {
        departureStation = result;
      });
    }
  }

  // 도착역 선택 함수
  void _selectArrivalStation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => StationListPage(
              title: '도착역 선택',
              selectedStation: arrivalStation,
            ),
      ),
    );

    if (result != null) {
      setState(() {
        arrivalStation = result;
      });
    }
  }

  // 좌석 선택 페이지로 이동하는 함수
  void _navigateToSeatPage() {
    if (departureStation != null && arrivalStation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => SeatPage(
                departureStation: departureStation!,
                arrivalStation: arrivalStation!,
              ),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('출발역과 도착역을 모두 선택해주세요.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('기차 예매'), centerTitle: true),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 출발역/도착역 선택 영역
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 출발역 선택 부분
                  Expanded(
                    child: InkWell(
                      onTap: _selectDepartureStation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '출발역',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            departureStation ?? '선택',
                            style: const TextStyle(fontSize: 40),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 세로 구분선
                  Container(width: 2, height: 50, color: Colors.grey[400]),

                  // 도착역 선택 부분
                  Expanded(
                    child: InkWell(
                      onTap: _selectArrivalStation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '도착역',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            arrivalStation ?? '선택',
                            style: const TextStyle(fontSize: 40),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 좌석 선택 버튼
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _navigateToSeatPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
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
