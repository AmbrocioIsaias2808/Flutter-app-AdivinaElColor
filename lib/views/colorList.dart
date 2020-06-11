import 'package:flutter/material.dart';

import '../Utils.dart';
import '../colors.dart';

class ColorList extends StatelessWidget {

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
                  Text("Lista de Colores", textAlign: TextAlign.center, style: TextStyle(fontSize: size.height*0.05, fontWeight: FontWeight.bold),),
                 // Text("EL JUEGO", textAlign: TextAlign.center, style: TextStyle(fontSize: size.height*0.03, fontWeight: FontWeight.bold),),
                  SizedBox(height: 50,),
                  Row(
                    children: <Widget>[
                      Expanded(child: Text("Nombre", style: TextStyle(fontWeight: FontWeight.bold),),),
                      Expanded(child: Text("Color", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),)
                    ],
                  ),
                  Container(
                    height: 380,
                    width: 500,
                    child: ListView.builder(itemCount: colors.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              SizedBox(height: 10,),
                              Row(
                                children: <Widget>[
                                  Expanded(child: Text(colors[index]["name"],),),
                                  Expanded(child: SizedBox(),),
                                  Container(decoration: BoxDecoration(border: Border.all(color: Colors.black), color: colors[index]["color"]),width: 50, height: 20,),
                                  Expanded(child: SizedBox(),)
                                ],
                              )
                            ],
                          );
                        }
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

