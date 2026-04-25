import 'package:flutter/material.dart';

class HistoryDetailsItem extends StatelessWidget {
  final String? title;
  final String? data;

  const HistoryDetailsItem({
    super.key,
    this.title,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              data ?? "",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
