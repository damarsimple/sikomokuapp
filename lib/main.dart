import 'package:flutter/material.dart';
import 'package:sikomokuapp/my_activity.dart';

import 'level.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sikomoku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/my_activity': (context) => const MyActivity(),
        '/level': (context) => const Level(),
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextCard(
                name: 'HOME',
                subtitle:
                    'Aplikasi komunikasi dan pengelolaan perilaku Anak Autism',
                color: Colors.green),
            const TextCard(
                name: 'Dewi Barotut Taqiyah',
                subtitle: 'NIM: 21129251031',
                color: Colors.blue),
            Center(
              child: Card(
                child: SizedBox(
                  width: 300,
                  height: 180,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'MENU',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amberAccent),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, '/level',
                                arguments: LevelArguments(1)),
                            child: const Card(
                              color: Colors.lightBlueAccent,
                              child: SizedBox(
                                height: 50,
                                width: 130,
                                child: Center(
                                  child: Text('Level 1'),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, '/level',
                                arguments: LevelArguments(2)),
                            child: const Card(
                              color: Colors.blue,
                              child: SizedBox(
                                  height: 50,
                                  width: 130,
                                  child: Center(
                                    child: Text('Level 2'),
                                  )),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, '/level',
                                arguments: LevelArguments(3)),
                            child: const Card(
                              color: Colors.amberAccent,
                              child: SizedBox(
                                height: 50,
                                width: 130,
                                child: Center(
                                  child: Text('Level 3'),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/my_activity'),
                            child: const Card(
                              color: Colors.yellow,
                              child: SizedBox(
                                  height: 50,
                                  width: 130,
                                  child: Center(
                                    child: Text('Aktivitasku'),
                                  )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}

class TextCard extends StatelessWidget {
  const TextCard(
      {Key? key,
      required this.name,
      required this.subtitle,
      required this.color})
      : super(key: key);

  final String name;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          width: 300,
          height: 100,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
