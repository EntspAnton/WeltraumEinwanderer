import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:weltraum_einwanderer/space_shooter_game.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  final level = 1;

  @override
  State<StatefulWidget> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Widget? _content;
  bool gameRunning = false;

  

  void _startGame() {
    print('start');
    _content = GameWidget(game: SpaceShooterGame());
    gameRunning = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

     if(!gameRunning){
      _content = ElevatedButton(onPressed: _startGame, child: Text('Start Game', style: GoogleFonts.quantico(),));
     }
    


    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        //toolbarOpacity: 0,
        title: Text('Weltraum Einwanderer', style: GoogleFonts.quantico(),),
      ),
      body: SafeArea(
          child: Center(
        child: _content,
      )),
    );
  }
}
