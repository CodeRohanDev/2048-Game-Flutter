import 'package:flutter/material.dart';
import 'package:game_2048/models/game.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game game;
  static const double tileSize = 80.0;
  static const Duration animationDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    game = Game();
    // Add initial tiles to game
    game.addRandomTile();
    game.addRandomTile();
  }

  void onPanUpdate(DragUpdateDetails details) {
    final Offset offset =
        details.delta; // Use details.delta instead of primaryDelta
    final double dx = offset.dx;
    final double dy = offset.dy;

    setState(() {
      if (dx.abs() > dy.abs()) {
        if (dx > 0) {
          game.moveRight();
        } else {
          game.moveLeft();
        }
      } else {
        if (dy > 0) {
          game.moveDown();
        } else {
          game.moveUp();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Swipe Game')),
      body: GestureDetector(
        onPanUpdate: onPanUpdate,
        child: Stack(
          children: [
            for (int i = 0; i < 4; i++)
              for (int j = 0; j < 4; j++)
                AnimatedPositioned(
                  duration: animationDuration,
                  left: j * tileSize,
                  top: i * tileSize,
                  child: Tile(
                    value: game.grid[i][j],
                    size: tileSize,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

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
