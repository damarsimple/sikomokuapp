import 'package:flutter/material.dart';

class MyActivity extends StatelessWidget {
  const MyActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Activity')),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Text('Sedang dalam pengembangan...'),
            ),
          ),
        ),
      ),
    );
  }
}
