import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Settings.dart';

class Guide  extends StatefulWidget{
  const Guide ({Key? key}) : super (key: key);

  @override
  _Guide createState() => _Guide();
}

class _Guide extends State<Guide> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("이용약관",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.grey,
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: Colors.white,
          toolbarHeight: 40,
        ),
        body: Container(

        )
    );
  }
}