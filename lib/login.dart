import 'dart:io';

import 'package:academysebene/classes/Track.dart';
import 'package:academysebene/classes/fireBaseHelper.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

import 'classes/User.dart';

class login extends StatefulWidget{
  User profil;

  login({User profil})
  {
    this.profil=profil;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeLogin();
  }


}

class homeLogin extends State<login>{
  String _identifiant;
  User _profil = null;
  List<Track> _backTracking =[


  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireBaseHelper().myId().then((uid)
    {
      setState(() {
        _identifiant=uid;
      });
      fireBaseHelper().getUser(_identifiant).then((user)
      {
        setState(() {
          _profil=user;
        });

      });

    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(_profil==null)
    {
      return new Center(child: new Text('En cours de chargement ....'),);
    }
    else {
      return new SingleChildScrollView(
          child: new Center(
            child: new Container(
                child: (_profil.typeUtilisateur=='particulier')?_PartieParticulier():_PartieProfessionnel()
            ),
          )
      );
    }

  }


  Widget _PartieParticulier()
  {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Image.asset('assets/Logo_Transparent.png',
          height: MediaQuery
              .of(context)
              .size
              .height / 4,
        ),
        new Icon(
          Icons.account_circle, size: 50, color: Colors.amber,),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        new Text(_profil.pseudo,
          style: new TextStyle(fontSize: 25, color: Colors.amber),),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        new Text(_profil.mail,
          style: new TextStyle(color: Colors.amber, fontSize: 25),)


      ],
    );
  }



  Widget _PartieProfessionnel()
  {
    return new SingleChildScrollView(
      child : new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.all(30),
                child:  new  Text('Liste des Backing Track',textAlign: TextAlign.center,),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/10,
              ),

              new Container(
                height: MediaQuery.of(context).size.height/1.6,
                color: Colors.amber,
                child:new Card(
                  elevation: 10,
                  child: new FirebaseAnimatedList(
                    query: fireBaseHelper().base_track,
                  itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index)
                  {
                    Track _track= Track(snapshot);
                    return new ListTile(

                      title: new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Text(_track.titre),
                          IconButton(
                              icon: new Icon(Icons.menu),
                              onPressed: null),
                          new IconButton(
                              icon: new Icon(Icons.delete),
                              onPressed: null)
                        ],
                      ),

                    );


                  }
              ),
                ),


              ),
              new RaisedButton(
                onPressed: (){
                  addTracking();
                },
                child: new Text('Ajouter un Track'),
                color: Colors.amber,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),

            ],
          )

      ),

    );
  }



  addTracking()
  {
    String _password;
    String _titleSong;
    String _lien;
    showDialog(
        context:context,
        barrierDismissible: true,
        builder:(BuildContext Buildcontext)
        {
          if(Platform.isIOS)
          {
            return CupertinoAlertDialog(
              title: new Text('Ajouter un backing Tracking'),
              content: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new TextField(
                    onChanged: (text){
                      setState(() {
                        _titleSong=text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Entrer le titre'

                    ),
                  ),
                  new TextField(
                    onChanged: (text){
                      setState(() {
                        _password=text;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Entrer votre mot de passe'
                    ),
                  ),

                ],

              ),
              actions: <Widget>[
                new FlatButton(
                    onPressed: ()=>print('Enregistrer'),
                    child: new Text('Enregistrer'))
              ],
            );
          }
          else
          {
            return SimpleDialog(

            );

          }
        }
    );
  }




}