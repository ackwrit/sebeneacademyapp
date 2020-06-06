import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Track{
  String id;
  String titre;
  String lien;




  Track(DataSnapshot snapshot)
  {
    id=snapshot.key;
    Map map=snapshot.value;
    titre=map['titre'];
    lien =map['uid'];

  }


  Map toMap (){
    return{
      "uid":id,
      "titre":titre,
      "lien":lien

  };
}

}