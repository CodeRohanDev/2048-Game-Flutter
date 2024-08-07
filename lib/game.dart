import 'package:flutter/material.dart';
import 'package:game_2048/game.dart';
import 'package:game_2048/tile.dart';

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
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.primaryDelta != null) {
      final dx = details.primaryDelta!.dx;
      final dy = details.primaryDelta!.dy;

      setState(() {
        if (dx.abs() > dy.abs()) {
          // Horizontal swipe
          if (dx > 0) {
            game.moveRight();
          } else {
            game.moveLeft();
          }
        } else {
          // Vertical swipe
          if (dy > 0) {
            game.moveDown();
          } else {
            game.moveUp();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('2048')),
      body: GestureDetector(
        onPanUpdate: onPanUpdate,
        child: Stack(
          children: [
            for (int i = 0; i < 4; i++)
              for (int j = 0; j < 4; j++)
                AnimatedPositioned(
                  duration: animationDuration,
                  left: j * tileSize.toDouble(),
                  top: i * tileSize.toDouble(),
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
