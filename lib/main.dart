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
      case "Selection Sort":
        await selectionSort(numbers);
        break;
      case "Insertion Sort":
        await insertionSort(numbers);
        break;
      case "Merge Sort":
        await mergeSort(numbers);
        break;
      case "Quick Sort":
        await quickSort(numbers);
        break;
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

  Future<void> selectionSort(List<int> numbers) async {
    for (int i = 0; i < numbers.length - 1; i++) {
      int minIndex = i;
      for (int j = i + 1; j < numbers.length; j++) {
        if (numbers[j] < numbers[minIndex]) {
          minIndex = j;
        }
      }

      // Swap numbers[i] and numbers[minIndex]
      int temp = numbers[i];
      numbers[i] = numbers[minIndex];
      numbers[minIndex] = temp;

      // Delay to visualize the sorting process
      await Future.delayed(Duration(milliseconds: delay));

      setState(() {});
    }
  }

  Future<void> insertionSort(List<int> numbers) async {
    for (int i = 1; i < numbers.length; i++) {
      int key = numbers[i];
      int j = i - 1;
      while (j >= 0 && numbers[j] > key) {
        numbers[j + 1] = numbers[j];
        j--;
      }
      numbers[j + 1] = key;

      // Delay to visualize the sorting process
      await Future.delayed(Duration(milliseconds: delay));

      setState(() {});
    }
  }

  Future<void> mergeSort(List<int> numbers) async {
    await mergeSortHelper(numbers, 0, numbers.length - 1);
  }

  Future<void> mergeSortHelper(
      List<int> numbers, int start, int end) async {
    if (start < end) {
      int mid = (start + end) ~/ 2;
      await mergeSortHelper(numbers, start, mid);
      await mergeSortHelper(numbers, mid + 1, end);
      await merge(numbers, start, mid, end);
    }
  }

  Future<void> merge(List<int> numbers, int start, int mid, int end) async {
    int n1 = mid - start + 1;
    int n2 = end - mid;

    List<int> left = [];
    List<int> right = [];

    for (int i = 0; i < n1; i++) {
      left.add(numbers[start + i]);
    }
    for (int j = 0; j < n2; j++) {
      right.add(numbers[mid + 1 + j]);
    }

    int i = 0;
    int j = 0;
    int k = start;

    while (i < n1 && j < n2) {
      if (left[i] <= right[j]) {
        numbers[k] = left[i];
        i++;
      } else {
        numbers[k] = right[j];
        j++;
      }
      k++;

      // Delay to visualize the sorting process
      await Future.delayed(Duration(milliseconds: delay));

      setState(() {});
    }

    while (i < n1) {
      numbers[k] = left[i];
      i++;
      k++;

      // Delay to visualize the sorting process
      await Future.delayed(Duration(milliseconds: delay));

      setState(() {});
    }

    while (j < n2) {
      numbers[k] = right[j];
      j++;
      k++;

      // Delay to visualize the sorting process
      await Future.delayed(Duration(milliseconds: delay));

      setState(() {});
    }
  }

  Future<void> quickSort(List<int> numbers) async {
    await quickSortHelper(numbers, 0, numbers.length - 1);
  }

  Future<void> quickSortHelper(
      List<int> numbers, int start, int end) async {
    if (start < end) {
      int partitionIndex = await partition(numbers, start, end);
      await quickSortHelper(numbers, start, partitionIndex - 1);
      await quickSortHelper(numbers, partitionIndex + 1, end);
    }
  }

  Future<int> partition(List<int> numbers, int start, int end) async {
    int pivot = numbers[end];
    int i = start - 1;
    for (int j = start; j < end; j++) {
      if (numbers[j] < pivot) {
        i++;

        // Swap numbers[i] and numbers[j]
        int temp = numbers[i];
        numbers[i] = numbers[j];
        numbers[j] = temp;

        // Delay to visualize the sorting process
        await Future.delayed(Duration(milliseconds: delay));

        setState(() {});
      }
    }

    // Swap numbers[i + 1] and numbers[end]
    int temp = numbers[i + 1];
    numbers[i + 1] = numbers[end];
    numbers[end] = temp;

    // Delay to visualize the sorting process
    await Future.delayed(Duration(milliseconds: delay));

    setState(() {});

    return i + 1;
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
              "Selection Sort",
              "Insertion Sort",
              "Merge Sort",
              "Quick Sort",
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
