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

  void onSwipe(DragEndDetails details) {
    if (details.primaryVelocity != null) {
      setState(() {
        if (details.primaryVelocity! > 0) {
          game.moveRight();
        } else if (details.primaryVelocity! < 0) {
          game.moveLeft();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('2048')),
      body: GestureDetector(
        onPanEnd: onSwipe,
        child: Stack(
          children: [
            for (var move in game.moves)
              AnimatedPositioned(
                duration: animationDuration,
                left: move.to.y * tileSize.toDouble(),
                top: move.to.x * tileSize.toDouble(),
                child: Tile(
                  value: game.grid[move.to.x][move.to.y],
                  size: tileSize,
                ),
                onEnd: () {
                  setState(() {
                    game.grid[move.to.x][move.to.y] =
                        game.grid[move.from.x][move.from.y];
                    game.grid[move.from.x][move.from.y] = 0;
                  });
                },
              ),
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
