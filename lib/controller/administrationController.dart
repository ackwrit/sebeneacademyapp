import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class admnistrationController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeAdmins();
  }

}


class homeAdmins extends State<admnistrationController>{
  final AssetsAudioPlayer assetsAudioPlayer =AssetsAudioPlayer();
  double deltaVitesse =1.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assetsAudioPlayer.pause();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Platform.isIOS)?scaffoldIos():scaffoldAndroid();
  }




  Widget scaffoldIos() {
    assetsAudioPlayer.open(Audio("assets/audios/Backing_track_rumba_Do.mp3"),autoStart: false);
    return new Scaffold(
      appBar: AppBar(
        title:Text('page Text'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: (){
              assetsAudioPlayer.play();

              print(assetsAudioPlayer);

            },
              child:Text('Play'),

            ),
            RaisedButton(
              onPressed:(){
                assetsAudioPlayer.stop();
              },
              child: Text('Stop'),
            ),
            Slider(
                value:deltaVitesse,
                divisions: 10,
                min: 0,
                max: 16,
                onChanged: (value)
                {
                  setState(() {
                    deltaVitesse = value;
                    assetsAudioPlayer.setPlaySpeed(deltaVitesse);
                    //assetsAudioPlayer.play();
                  });
                })

          ],

        ),


      ),
    );
  }



  Widget scaffoldAndroid()
  {
    return null;
  }


}