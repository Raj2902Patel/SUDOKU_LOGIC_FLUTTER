import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(SudokuApp());
}

class SudokuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SudokuPage(),
    );
  }
}

class SudokuPage extends StatefulWidget {
  @override
  _SudokuPageState createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {
  late List<List<int>> sudokuGrid;
  late Timer timer;
  int secondsElapsed = 0;
  int roundCount = 1;

  @override
  void initState() {
    super.initState();
    sudokuGrid = generateSudoku();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        secondsElapsed++;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List<List<int>> generateSudoku() {
    // TODO: Implement Sudoku generation algorithm
    // For simplicity, I'm just returning an empty grid
    return List.generate(9, (_) => List<int>.filled(9, 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Round: $roundCount',
                style: const TextStyle(fontSize: 20.0),
              ),
              Text(
                'Time: ${Duration(seconds: secondsElapsed).toString().split('.').first}',
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 9,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
                itemCount: 81,
                itemBuilder: (context, index) {
                  int row = index ~/ 9;
                  int col = index % 9;
                  return GestureDetector(
                    onTap: () {
                      // TODO: Implement cell tapping functionality
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        sudokuGrid[row][col] != 0
                            ? sudokuGrid[row][col].toString()
                            : '',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    sudokuGrid = generateSudoku();
                    secondsElapsed = 0;
                    roundCount++;
                  });
                },
                child: const Text('New Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
