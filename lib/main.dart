import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guessthecolor/Utils.dart';
import 'package:guessthecolor/views/Game.dart';
import 'package:guessthecolor/views/colorList.dart';

import 'colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/Game'            :      (context)=>Game(),
        '/List'            :      (context)=>ColorList(),
      },
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors[randomNumber(0, 11)]["color"],
      body: Center(
        child: Container(
          width: size.width*0.9,
          height: size.height*0.9,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text("Adivina el Color", textAlign: TextAlign.center, style: TextStyle(fontSize: size.height*0.05, fontWeight: FontWeight.bold),),
                  Text("EL JUEGO", textAlign: TextAlign.center, style: TextStyle(fontSize: size.height*0.03, fontWeight: FontWeight.bold),),
                  SizedBox(height: 50,),
                  RaisedButton(child: Text("JUGAR", style: TextStyle(color: Colors.white),), onPressed: (){
                    Navigator.pushNamed(context, "/Game");
                  }, color: Colors.blue),
                  SizedBox(height: 50,),
                  RaisedButton(child: Text("Lista de Colores", style: TextStyle(color: Colors.white),), onPressed: (){
                    Navigator.pushNamed(context, "/List");
                  },
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


