import 'package:academysebene/classes/Musique.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';


class track extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeTrack();
  }

}

class homeTrack extends State<track>{
  int selectedindex=1;
  AudioPlayer lecture;
  AudioCache lectureCache;
  double deltaVitesse = 100.0;



  StreamSubscription positionsub;
  StreamSubscription statesub;
  Duration duree=new Duration(seconds: 10);
  PlayerState statut= PlayerState.stopped;
  PlayerState statutrumba=PlayerState.stopped;
  int indexmusique=0;
  Musique musiqueactuelle;
  List <Musique> listemusique=[
    Musique("Backing_track_rumba_Do.mp3", "Rumba"),
    Musique("Sample_Congolese_Rumba_beat.mp3", "Congolais Rumba"),

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    musiqueactuelle=listemusique[0];
    configurationAudioPlayer();
    lectureCache=new AudioCache(fixedPlayer: lecture);


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SingleChildScrollView(
      child:Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset("assets/Logo_Transparent.png",
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width/3,
            ),
            Container(
                child:   Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        button((statutrumba == PlayerState.playing)?Icons.pause_circle_filled:Icons.play_circle_filled,(statutrumba == PlayerState.playing)?Actionmusic.pause:Actionmusic.play ,70.0,0),
                        Text(listemusique[0].nom),
                      ],

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        button((statut == PlayerState.playing)?Icons.pause_circle_filled:Icons.play_circle_filled, (statut == PlayerState.playing)?Actionmusic.pause:Actionmusic.play ,70.0,1),
                        Text(listemusique[1].nom),

                        Slider(
                            value:deltaVitesse,
                            divisions: 10,
                            min: 0,
                            max: 180,
                            onChanged: (value)
                        {
                          setState(() {
                            deltaVitesse = value;
                          });
                        })

                      ],

                    ),








                  ],
                )
            ),

          ],
        ),

      ),

    );



  }



  IconButton button(IconData icone,Actionmusic action, double scale,int gestionmusique){
    return IconButton(
        iconSize: scale,
        color: Colors.red,
        icon:Icon(icone),
        onPressed: () {
          setState(() {
            musiqueactuelle=listemusique[gestionmusique];
            indexmusique=gestionmusique;
          });
          switch(action)
          {

            case Actionmusic.play:
              play();
              print("play");
              print(statut);

              // TODO: Handle this case.
              break;
            case Actionmusic.pause:
              pause();
              print("stop");
              print(statut);
              // TODO: Handle this case.
              break;
          }
        }
    );

  }

  void configurationAudioPlayer(){
    lecture=new AudioPlayer();

    statesub=lecture.onPlayerStateChanged.listen((state)
    {
      if(state== AudioPlayerState.PLAYING){
        setState(() {
          if(indexmusique==0)
          {
            statutrumba =PlayerState.playing;
          }
          else
          {
            statut=PlayerState.playing;
          }


        });
      }
      else if (state == AudioPlayerState.STOPPED){
        setState(() {
          if(indexmusique==0)
          {
            statutrumba =PlayerState.stopped;
          }
          else
          {
            statut = PlayerState.stopped;
          }

        });

      }

    },
        onError:(message)
        {
          print("erreur  $message");
          setState(() {
            statut = PlayerState.stopped;
            duree= new Duration(seconds: 0);
          });
        }
    );

  }

  Future<ByteData> loadAsset() async {
    return await rootBundle.load(musiqueactuelle.source);
  }


  Future play() async{

    await lectureCache.play(musiqueactuelle.source,volume: 5.0);
    setState(() {
      if(indexmusique==0)
      {
        statutrumba=PlayerState.playing;
      }
      else {
        statut=PlayerState.playing;
      }
    });

  }

  Future pause() async{
    await lecture.stop();
    setState(() {
      if(indexmusique==0)
      {
        statutrumba=PlayerState.stopped;
        lectureCache.clearCache();
      }
      else {
        statut=PlayerState.stopped;
        lectureCache.clearCache();
      }
    });
  }

}
enum Actionmusic{
  play,
  pause,
}

enum PlayerState{
  playing,
  stopped,
}