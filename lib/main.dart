import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<SensorValue> data = [];
  int bpmValue = 0;

  @override
  Widget build(BuildContext context) {
    var isBPMEnabled = true;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Heart BPM Demo'),
        ),
        body: Column(
          children: [
            isBPMEnabled ? HeartBPMDialog(
              context: context,
              onRawData: (value) {
                setState(() {
                  // add raw data points to the list
                  // with a maximum length of 100
                  if (data.length == 100)
                    data.removeAt(0);
                  data.add(value);
                });
              },
              onBPM: (value) =>
                  setState(() {
                    bpmValue = value;
                  }),
            )
                : SizedBox(),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.favorite_rounded),
                label: Text(isBPMEnabled
                    ? "Stop measurement" : "Measure BPM"),
                onPressed: () =>
                    setState(() =>
                    isBPMEnabled = !isBPMEnabled
                    ),
              ),
            ),
            Container(
              height: 200,
                width: double.infinity,
                child: BPMChart(data)),
          ],
        ),
      ),
    );
  }
}