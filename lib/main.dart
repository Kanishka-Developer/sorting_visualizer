import "package:flutter/material.dart";
import "dart:math";
import "dart:async";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SortingVisualizer(),
    );
  }
}

class SortingVisualizer extends StatefulWidget {
  @override
  _SortingVisualizerState createState() => _SortingVisualizerState();
}

class _SortingVisualizerState extends State<SortingVisualizer> {
  List<int> numbers = [];
  String selectedAlgorithm = "Bubble Sort";
  double containerWidth = 20.0;
  int delay = 50; // Delay between each step in milliseconds

  @override
  void initState() {
    super.initState();
    generateRandomNumbers();
  }

  void generateRandomNumbers() {
    Random random = Random();
    numbers.clear();
    for (int i = 0; i < 20; i++) {
      numbers.add(random.nextInt(101));
    }
    setState(() {});
  }

  Future<void> sortNumbers() async {
    switch (selectedAlgorithm) {
      case "Bubble Sort":
        await bubbleSort(numbers);
        break;
      // Implement cases for other sorting algorithms here
    }
  }

  Future<void> bubbleSort(List<int> numbers) async {
    for (int i = 0; i < numbers.length - 1; i++) {
      for (int j = 0; j < numbers.length - i - 1; j++) {
        if (numbers[j] > numbers[j + 1]) {
          // Swap numbers[j] and numbers[j + 1]
          int temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;

          // Delay to visualize the sorting process
          await Future.delayed(Duration(milliseconds: delay));

          setState(() {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sorting Visualizer"),
      ),
      body: Column(
        children: <Widget>[
          DropdownButton<String>(
            value: selectedAlgorithm,
            onChanged: (String? newValue) {
              setState(() {
                selectedAlgorithm = newValue!;
              });
            },
            items: <String>[
              "Bubble Sort",
              // Add other sorting algorithms here
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: generateRandomNumbers,
            child: Text("Generate Rectangles"),
          ),
          // Render rectangles with AnimatedContainer for sorting visualization
          Expanded(
            child: Row(
              children: numbers.map<Widget>((int height) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: delay),
                  width: containerWidth,
                  height: height.toDouble(),
                  color: Colors.blue,
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: sortNumbers,
            child: Text("Sort"),
          ),
        ],
      ),
    );
  }
}
