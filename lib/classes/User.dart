import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class User{


  String id;
  String pseudo;
  String mail;
  String typeUtilisateur;


  User(DataSnapshot Snapshot)
  {
    id=Snapshot.key;
    Map map=Snapshot.value;
    pseudo = map['pseudo'];
    mail = map['mail'];
    typeUtilisateur = map['typeUtilisateur'];
  }

  Map toMap()
  {
    return {
      'uid':id,
      'pseudo':pseudo,
      'mail': mail,
      'typeUtilisateur':typeUtilisateur
    };
  }


}