import 'dart:math';
import 'package:collection/collection.dart';

class Game {
  static const int size = 4;
  List<List<int>> grid =
      List.generate(size, (_) => List.generate(size, (_) => 0));

  Game() {
    addRandomTile();
    addRandomTile();
  }

  bool _isGridChanged = false;

  void moveRight() {
    _isGridChanged = false;
    for (int i = 0; i < size; i++) {
      List<int> row = grid[i];
      List<int> newRow =
          slideAndCombine(row.reversed.toList()).reversed.toList();
      if (!_listEquals(row, newRow)) {
        _isGridChanged = true;
      }
      grid[i] = newRow;
    }
    if (_isGridChanged) {
      addRandomTile();
    }
    printGrid();
  }

  void moveLeft() {
    _isGridChanged = false;
    for (int i = 0; i < size; i++) {
      List<int> row = grid[i];
      List<int> newRow = slideAndCombine(row);
      if (!_listEquals(row, newRow)) {
        _isGridChanged = true;
      }
      grid[i] = newRow;
    }
    if (_isGridChanged) {
      addRandomTile();
    }
    printGrid();
  }

  void moveUp() {
    _isGridChanged = false;
    for (int j = 0; j < size; j++) {
      List<int> column = [for (int i = 0; i < size; i++) grid[i][j]];
      List<int> newColumn = slideAndCombine(column);
      for (int i = 0; i < size; i++) {
        if (grid[i][j] != newColumn[i]) {
          _isGridChanged = true;
        }
        grid[i][j] = newColumn[i];
      }
    }
    if (_isGridChanged) {
      addRandomTile();
    }
    printGrid();
  }

  void moveDown() {
    _isGridChanged = false;
    for (int j = 0; j < size; j++) {
      List<int> column = [for (int i = 0; i < size; i++) grid[i][j]];
      List<int> newColumn =
          slideAndCombine(column.reversed.toList()).reversed.toList();
      for (int i = 0; i < size; i++) {
        if (grid[i][j] != newColumn[i]) {
          _isGridChanged = true;
        }
        grid[i][j] = newColumn[i];
      }
    }
    if (_isGridChanged) {
      addRandomTile();
    }
    printGrid();
  }

  List<int> slideAndCombine(List<int> row) {
    List<int> result = List.filled(size, 0);
    int insertIndex = 0;

    for (int i = 0; i < size; i++) {
      if (row[i] != 0) {
        if (insertIndex > 0 && result[insertIndex - 1] == row[i]) {
          result[insertIndex - 1] *= 2;
        } else {
          result[insertIndex] = row[i];
          insertIndex++;
        }
      }
    }
    return result;
  }

  void addRandomTile() {
    List<Point<int>> emptyCells = [];
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (grid[i][j] == 0) {
          emptyCells.add(Point(i, j));
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      final point = emptyCells[Random().nextInt(emptyCells.length)];
      grid[point.x][point.y] = Random().nextInt(10) < 9 ? 2 : 4;
      print('Added tile ${grid[point.x][point.y]} at ${point.x}, ${point.y}');
    }
  }

  bool _listEquals(List<int> list1, List<int> list2) {
    return ListEquality<int>().equals(list1, list2);
  }

  void printGrid() {
    print('Current Grid State:');
    for (var row in grid) {
      print(row);
    }
    print('');
  }
}
