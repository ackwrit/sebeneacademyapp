import 'package:academysebene/classes/Musique.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class backTrack extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeBack();
  }

}

class homeBack extends State<backTrack>{
  Musique musique = new Musique("assets/audios/Backing_track_rumba_Do.mp3", "Rumba");
  AssetsAudioPlayer assetsAudioPlayer = new AssetsAudioPlayer();
  
  @override
  Widget build(BuildContext context) {
    assetsAudioPlayer.open(
        Audio(musique.source),
      autoStart: false

    );
    // TODO: implement build
    return bodyPage();
  }
  
  
  
  
  Widget bodyPage(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: (assetsAudioPlayer.isPlaying==true)?Icon(Icons.pause_circle_filled,color: Colors.red,):Icon(Icons.play_circle_filled,color: Colors.red,),
            onPressed: (){
              if(assetsAudioPlayer.isPlaying==true)
                {
                  assetsAudioPlayer.pause();
                }
              else
                {
                  assetsAudioPlayer.play();
                }

            }
        ),

        Text(musique.nom)
        
      ],
    );
  }
  
}