import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Jam extends StatefulWidget {
  @override
  _JamState createState() => _JamState();
}

class _JamState extends State<Jam> {
  String selectedLocation = 'WIB';
  late Timer timer;
  late DateTime currentTime;

  @override
  void initState() {
    super.initState();
    currentTime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
  }

  void _getCurrentTime() {
    setState(() {
      if (selectedLocation == 'WIB') {
        currentTime = DateTime.now();
      } else if (selectedLocation == 'WITA') {
        currentTime = DateTime.now().add(Duration(hours: 1));
      } else if (selectedLocation == 'WIT') {
        currentTime = DateTime.now().add(Duration(hours: 2));
      } else if (selectedLocation == 'London') {
        currentTime = DateTime.now().add(Duration(hours: -7));
      }
    });
  }

  void updateTime(String location) {
    setState(() {
      selectedLocation = location;
      _getCurrentTime();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('HH:mm').format(currentTime);
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFdcdcd4)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Time: $formattedTime',
                style: TextStyle(fontSize: 10,backgroundColor: Colors.transparent, color: Colors.black),
              ),
              SizedBox(width: 20),
              DropdownButton<String>(
                value: selectedLocation,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    updateTime(newValue);
                  }
                },
                items: <String>['WIB', 'WITA', 'WIT', 'London'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(fontSize: 10,color: Colors.black)),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}