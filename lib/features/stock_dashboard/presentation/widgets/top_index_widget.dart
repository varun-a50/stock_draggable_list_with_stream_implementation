import 'package:flutter/material.dart';

class TopIndexWidget extends StatelessWidget {
  final String firstLabel;
  final String secondLable;
  final double firstValue;
  final double secondValue;
  const TopIndexWidget({
    super.key,
    required this.firstLabel,
    required this.firstValue,
    required this.secondLable,
    required this.secondValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 48, 16, 8),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                firstLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 158, 158, 158),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                firstValue.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 26, 26, 46),
                ),
              ),
            ],
          ),
          Container(
            height: 36,
            width: 1,
            color: const Color.fromARGB(255, 224, 224, 224),
          ),
          Column(
            children: [
              Text(
                secondLable,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 158, 158, 158),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                secondValue.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 26, 26, 46),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
