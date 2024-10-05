import 'package:flutter/material.dart';
import 'package:nine_dart_score/presentation/history/ui/history_list.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HistoryList(),
          ],
        ),
      ),
    );
  }
}
