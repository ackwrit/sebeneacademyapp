import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'classes/User.dart';
import 'classes/fireBaseHelper.dart';


class listingUtilisateur extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeUtilisateur();
  }

}

class homeUtilisateur extends State<listingUtilisateur> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FirebaseAnimatedList(
        query: fireBaseHelper().base_user,
        itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation <double> animation,int index ){
          User _Utilisateur = new User(snapshot);
          return new Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_Utilisateur.mail),
                  IconButton(
                      icon: Icon(Icons.dehaze),
                      onPressed: ()
                      {

                      }
                  ),
                ],
              ),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){
                  }),
            ),
          );

        }
    );
  }
}
