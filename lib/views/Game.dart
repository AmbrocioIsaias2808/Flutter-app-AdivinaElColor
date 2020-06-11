import 'package:flutter/material.dart';

import '../Utils.dart';
import '../colors.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  final _Text = TextEditingController();
  dynamic _RandColor;
  GlobalKey<ScaffoldState> _Scaffoldkey;

  int guess=1;

  @override
  void initState() {
    // TODO: implement initState
    _Scaffoldkey = new GlobalKey<ScaffoldState>();
    _RandColor= colors[randomNumber(0, 11)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      key: _Scaffoldkey,
      backgroundColor: colors[randomNumber(0, 11)]["color"],
      body: Center(
        child: Container(
          width: size.width*0.9,
          height: size.height*0.9,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    guess==1?Text("¿Cuál es este color?", textAlign: TextAlign.center, style: TextStyle(fontSize: size.height*0.05, fontWeight: FontWeight.bold),):SizedBox(),
                    // Text("EL JUEGO", textAlign: TextAlign.center, style: TextStyle(fontSize: size.height*0.03, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    guess==1?Container(decoration: BoxDecoration(border: Border.all(color: Colors.black), color:_RandColor["color"]),width: 170, height: 170,):SizedBox(),
                    SizedBox(height: 20,),
                    guess==1?TextField(
                      textCapitalization: TextCapitalization.words,
                      controller: _Text,
                      decoration: InputDecoration(
                        suffix: Icon(Icons.edit),
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(width: 5.0),
                        ),

                      ),
                    ):SizedBox(),
                    SizedBox(height: 20,),
                    RaisedButton(child: Text(guess==1?"¿Adivine?":"Siguiente Nivel", style: TextStyle(color: Colors.white, fontSize: 20),), color: Colors.blue, onPressed: ()=>ButtonAdivinar()),
                    SizedBox(height: 20,),
                    RaisedButton(child: Text(guess==1?"Me rindo":"Regresar", style: TextStyle(color: Colors.white, fontSize: 20),), color: Colors.blue, onPressed: ()=>ButtonMeRindo(),),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  ButtonAdivinar(){
    print(_Text.text);
    print(guess);
    print(_RandColor["name"]==_Text.text);
    if(guess==1){
      _Scaffoldkey.currentState.removeCurrentSnackBar();
      if(_RandColor["name"]==_Text.text){
        _Scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('Lo lograste!!!!!!!!!!!!!'), backgroundColor: Colors.green,));
        setState(() {guess=2;});
      }else{
        _Scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('Lo siento pero no es correcto'), backgroundColor: Colors.red,));
      }

    }else{
      setState(() {_RandColor=colors[randomNumber(0, 11)]; guess=1;});
    }


  }

  ButtonMeRindo() {
    if(guess==1){
      _Scaffoldkey.currentState.removeCurrentSnackBar();
        _Scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('El color era: ${_RandColor["name"]}'), backgroundColor: Colors.green,));
        setState(() {guess=2;});
    }else{
      Navigator.pop(context);
    }

  }
}
