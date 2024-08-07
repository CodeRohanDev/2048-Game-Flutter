import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int value;
  final double size;

  Tile({required this.value, required this.size});

  Color getBackgroundColor(int value) {
    switch (value) {
      case 2:
        return Colors.yellow;
      case 4:
        return Colors.orange;
      case 8:
        return Colors.red;
      case 16:
        return Colors.purple;
      case 32:
        return Colors.blue;
      case 64:
        return Colors.green;
      case 128:
        return Colors.pink;
      case 256:
        return Colors.cyan;
      case 512:
        return Colors.teal;
      case 1024:
        return Colors.brown;
      case 2048:
        return Colors.black;
      default:
        return Colors.grey[200]!;
    }
  }

  Color getTextColor(int value) {
    return value <= 4 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: getBackgroundColor(value),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          value == 0 ? '' : '$value',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: getTextColor(value),
          ),
        ),
      ),
    );
  }
}
