import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import 'classes/fireBaseHelper.dart';


class ajouterTrack extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeAjouter();
  }
  
  
}

class homeAjouter extends State<ajouterTrack>{
  String _titre;
  String _son;
  DateTime jour =DateTime.now();
  String dossier;
  String _mail;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child:Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Titre',
              ),
              onChanged: (text){
                _titre = text;
              },
              textAlign: TextAlign.center,
              
            ),
            Padding(padding: EdgeInsets.all(10)),
            RaisedButton(
                onPressed: ()
              {
                _TakeFile();
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.orangeAccent,
              child: Text('Parcourir'),
            ),
            RaisedButton(
              color: Colors.orangeAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: ()
              {
                print('enregsitrement');
                dossier = randomAlpha(20);
                _mail = dossier + '${jour.day.toString()}${jour.year.toString()}${jour.month.toString()}@sebeneacademy.fr';
                print(_mail);
                fireBaseHelper().ajouterTrack(_titre, _son, _mail, dossier);


              },
              child: Text('Validation'),
            ),
          ],
        ),
        
      ),
    );
  }


  _TakeFile() async
  {
    File _track =await FilePicker.getFile();
    
    _son = await fireBaseHelper().savePodcast(_track, fireBaseHelper().storage_track);

  }
  
}