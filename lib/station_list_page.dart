import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String title;
  final String? selectedStation;

  const StationListPage({super.key, required this.title, this.selectedStation});

  // 선택 가능한 역 목록
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
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          final isSelected = station == selectedStation;

          return Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: ListTile(
              title: Text(
                station,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.purple : Colors.black,
                ),
              ),
              trailing:
                  isSelected
                      ? const Icon(Icons.check, color: Colors.purple)
                      : null,
              onTap: () {
                Navigator.pop(context, station); // 선택된 역 이름 반환
              },
            ),
          );
        },
      ),
    );
  }
}
