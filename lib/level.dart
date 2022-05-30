import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Level extends StatefulWidget {
  const Level({Key? key}) : super(key: key);

  @override
  State<Level> createState() => _LevelState();
}

class LevelArguments {
  final int id;

  LevelArguments(this.id);
}

class Activity {
  final String name;
  final String time;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String imageThumbnail;
  final String imageSmall;

  const Activity({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.imageThumbnail,
    required this.imageSmall,
    required this.name,
    required this.time,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
      name: json['name'] as String,
      time: json['time'] as String,
      imageSmall: 'https://sikomoku-be.damaral.my.id' +
          json['image']['data']['attributes']['formats']['small']['url'],
      imageThumbnail: 'https://sikomoku-be.damaral.my.id' +
          json['image']['data']['attributes']['formats']['thumbnail']['url'],
    );
  }
}

Future<List<Activity>> fetchActivites(int lvl) async {
  final response = await http.get(Uri.parse(
      'https://sikomoku-be.damaral.my.id/api/activities?filters[level][name][\$eq]=$lvl&populate=image'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    final List<Activity> data = List<Activity>.from(
        jsonDecode(response.body)['data']
            .map((e) => Activity.fromJson(e['attributes'])));
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

int parseTimeValue(String str) {
  var time = str.split(':');
  return int.parse(time[0]) * 60 + int.parse(time[1]);
}

class _LevelState extends State<Level> {
  bool loading = true;
  bool error = false;
  String errorMessage = '';
  List<Activity> activities = [];

  HashMap<String, List<Activity>> timesMap = HashMap();
  List<String> timesKeys = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        final args =
            ModalRoute.of(context)!.settings.arguments as LevelArguments;
        final level = args.id;
        fetchActivites(level).then((value) {
          setState(() {
            activities = value;
            loading = false;

            for (var element in value) {
              if (timesMap.containsKey(element.time)) {
                timesMap[element.time]?.add(element);
              } else {
                timesMap[element.time] = [element];
              }
            }

            var d = timesMap.keys.toList();

            d.sort((a, b) => parseTimeValue(a) - parseTimeValue(b));

            timesKeys = d;
          });
        }).catchError((e) {
          setState(() {
            error = true;
            errorMessage = e.toString();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as LevelArguments;
    final level = args.id;
    return Scaffold(
      appBar: AppBar(title: Text("Level $level")),
      body: error
          ? Center(child: Text(errorMessage))
          : loading
              ? const Center(child: CircularProgressIndicator())
              : level == 3
                  ? SingleChildScrollView(
                      child: Column(
                          children: timesKeys
                              .map((e) => Card(
                                    color: Colors.lightBlueAccent,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Center(
                                              child: Text(
                                            e,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 25, 15, 15)),
                                          )),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(
                                            children: timesMap[e]
                                                    ?.map(
                                                      (value) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Chip(
                                                          avatar: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.grey
                                                                    .shade800,
                                                            child:
                                                                Image.network(
                                                              value.imageSmall,
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                          ),
                                                          label: Expanded(
                                                              child: Text(
                                                                  value.name)),
                                                        ),
                                                      ),
                                                    )
                                                    .toList() ??
                                                [const Text('No activities')],
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                              .toList()),
                    )
                  : GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: activities
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  e.imageThumbnail,
                                  fit: BoxFit.fitWidth,
                                ),
                              ))
                          .toList(),
                    ),
    );
  }
}
