import 'dart:io';

import 'package:academysebene/administration.dart';
import 'package:academysebene/classes/Track.dart';
import 'package:academysebene/classes/fireBaseHelper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class updateTrack extends StatefulWidget{
  Track sonTrack;

  updateTrack(Track son)
  {
    sonTrack = son;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeUpdateTrack();
  }

}

class homeUpdateTrack extends State<updateTrack>{
   Track musique;
   @override
   void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      musique = widget.sonTrack;
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sebene Academy'),
        backgroundColor: Colors.amber,
      ),
      body: _Body(),
    );
  }

  Widget _Body(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (text){


                setState(() {
                  musique.titre = text;
                });

              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                hintText: musique.titre,
                filled: true,
                fillColor: Colors.white
              ),
              
            ),
            
            RaisedButton(
              onPressed: ()
              {
                _TakeFile();

              },
              child: Text('Parcourir'),
              color: Colors.amber,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

            ),
            
            RaisedButton(
                onPressed: ()
                    {

                      Map map = musique.toMap();
                      fireBaseHelper().addUsers(musique.id, map);
                      _DirectionAdmin();

                    },
              child: Text('Modification'),
              color: Colors.amber,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

            ),

          ],
        ),
      ),
    );
  }


  _TakeFile() async
  {
    File _track =await FilePicker.getFile();

    widget.sonTrack.lien = await fireBaseHelper().savePodcast(_track, fireBaseHelper().storage_track);

  }

  _DirectionAdmin()
  {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context)
            {
              return administration();
            }
    ));
  }



}