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
  int deltavitesse =90;

  
  @override

  Widget build(BuildContext context) {
    assetsAudioPlayer.open(
        Audio(musique.source),
      autoStart: false

    );
    assetsAudioPlayer.builderRealtimePlayingInfos(
      builder: (BuildContext context, RealtimePlayingInfos infos){
        return Text(infos.toString());
      }
    );
    // TODO: implement build
    return bodyPage();
  }
  
  
  
  
  Widget bodyPage(){
    return Column(

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.play_circle_filled,color: Colors.red,),
                onPressed: (){

                  assetsAudioPlayer.playOrPause();

                }
            ),
            Text(musique.nom),

            IconButton(icon: Icon(Icons.remove),
                onPressed: (){
              setState(() {
                deltavitesse =deltavitesse-5;
              });
              variationVitesse();

                }
            ),
            Text("${deltavitesse} BPM"),
            IconButton(
                icon: (Icon(Icons.add)),
                onPressed: (){
                  setState(() {
                    deltavitesse =deltavitesse+5;
                    variationVitesse();
                  });

                }
            ),

          ],

        ),



        
      ],
    );
  }



  variationVitesse(){
    assetsAudioPlayer.setPlaySpeed(deltavitesse/90);

  }
  
}