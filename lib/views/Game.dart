import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
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

  AudioPlayer audioPlayer = new AudioPlayer();
  AudioCache audioCache = AudioCache();
  int guess=1;
  bool win=true;
  int intentos=10;

  @override
  void initState() {
    // TODO: implement initState
    _Scaffoldkey = new GlobalKey<ScaffoldState>();
    _RandColor= colors[randomNumber(0, 11)];
    preloadAudio();
    super.initState();
  }

  void preloadAudio(){
     List<String> AudioNames = List<String>();
     colors.forEach((element) {
       AudioNames.add("audios/${element['name']}.mp3");
     });
     audioCache.loadAll(AudioNames);
  }

  int contador=5;
  void countDownTimer({int num=5, int limit=0})async{
    if(num==limit){
      await Future.delayed(Duration(seconds: 1)).then((value) => Navigator.pop(context));
      return;
    }

    Future.delayed(Duration(seconds: 1)).then((value){
      setState(() {
        contador--;
      });
      countDownTimer(num: contador, limit: limit);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      key: _Scaffoldkey,
      backgroundColor: Colors.white70,
      body: Center(
        child: Container(
          width: size.width*0.98,
          height: size.height*0.94,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: _Cuerpo( context),
              ),
            ),
          ),
        ),
      ),
    );
  }


  ButtonAdivinar()async{
      _Scaffoldkey.currentState.removeCurrentSnackBar();
      if(_RandColor["name"]==_Text.text){
        setState(() {
          guess=2;
        });

        _Scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('Lo lograste!!!!!!!!!!!!!'), backgroundColor: Colors.green,));
        audioPlayer = await audioCache.play("audios/${_RandColor['name']}.mp3");
        audioPlayer.onPlayerCompletion.listen((event) {
          setState(() {
            _RandColor=colors[randomNumber(0, 11)];
            guess=1;
            _Text.text="";
            intentos=10;
            _Scaffoldkey.currentState.removeCurrentSnackBar();
          });
        });
      }else{

        setState(() {
          intentos--;
        });
        if(intentos==0){
          setState(() {
            guess=2;
            win=false;
            _Text.text=_Text.text=_RandColor["name"];
          });
          _Scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('El color era: ${_RandColor["name"]}'), backgroundColor: Colors.green,));

          audioPlayer = await audioCache.play("audios/${_RandColor['name']}.mp3");
          audioPlayer.onPlayerCompletion.listen((event) {
            setState(()async {
              await countDownTimer();
            });
          });

        }else{
          _Scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('Lo siento pero no es correcto'), backgroundColor: Colors.red,));
        }
      }




  }

  ButtonMeRindo() async{

      _Scaffoldkey.currentState.removeCurrentSnackBar();

        _Scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('El color era: ${_RandColor["name"]}'), backgroundColor: Colors.green,));
        setState(() {_Text.text=_RandColor["name"]; guess=2; win=false;});
            audioPlayer = await audioCache.play("audios/${_RandColor['name']}.mp3");
            audioPlayer.onPlayerCompletion.listen((event) {
              setState(()async {
                await countDownTimer();
              });
      });

  }

   Widget _Cuerpo(BuildContext context) {
    final size= MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Text("¿Cuál es este color?", textAlign: TextAlign.center, style: TextStyle(fontSize: size.height*0.05, fontWeight: FontWeight.bold),),
        // Text("EL JUEGO", textAlign: TextAlign.center, style: TextStyle(fontSize: size.height*0.03, fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        Container(decoration: BoxDecoration(border: Border.all(color: Colors.black), color:_RandColor["color"]),width: 170, height: 170,),
        SizedBox(height: 20,),
        TextField(
          textCapitalization: TextCapitalization.words,
          controller: _Text,
          enabled: guess==1,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            suffix: Icon(Icons.edit),
            border:  OutlineInputBorder(
              borderSide: BorderSide(width: 5.0),
            ),

          ),
        ),
        _PanelBotones(context)
      ],
    );
   }

   Widget _PanelBotones(BuildContext context) {
      final size= MediaQuery.of(context).size;
      return Center(
        child: Row(
          children: <Widget>[
            Container(
              width: size.width*0.28,
              //color: Colors.red,
              child: _CounterDisplay(context)
            ),
            Container(
              width: size.width*0.285,
              //color:Colors.pinkAccent,
              child: Column(children: <Widget>[
              SizedBox(height: 20,),
              RaisedButton(child: Text("¿Adivine?", style: TextStyle(color: Colors.white, fontSize: 16.28),), color: Colors.blue, onPressed: guess==1?()=>ButtonAdivinar():null),
              SizedBox(height: 20,),
              RaisedButton(child: Text("Me rindo", style: TextStyle(color: Colors.white, fontSize: 16.28),), color: Colors.blue, onPressed: guess==1?()=>ButtonMeRindo():null,),

            ],),),
            Container(
              width: size.width*0.28,
             // color: Colors.red,
              child: Column(children: <Widget>[
                Text("Quedan:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ),),
                SizedBox(height: 20,),
                Text("$intentos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text("Intentos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ],
              ),
            ),
          ],
        ),
      );
   }

  Widget _CounterDisplay(BuildContext context) {

    if(guess==1){
      return SizedBox();
    }else if(guess==2 && win==true){
      return Text("Bien Hecho!!!!!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),);
    }else{
      return Column(children: <Widget>[
        Text("Volviendo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        Text("al menú", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        Text("en: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        SizedBox(height: 20,),
        Text("$contador", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
      ],);
    }



  }

}
