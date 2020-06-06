import 'package:academysebene/classes/fireBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'mainAppPage.dart';

class register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeRegister();
  }

}

class homeRegister extends State<register>{
  String _mail;
  String _pseudo;
  String _password;
  String _password2;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Inscription'),
        centerTitle: true,
        backgroundColor: Colors.amber,

      ),
      body: _Body(),
    );
  }


  Widget _Body()
  {
    return new SingleChildScrollView(
      child: new Container(
        padding: EdgeInsets.all(20),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/Logo_Transparent.png',
              height: MediaQuery.of(context).size.height/4,
            ),



            TextField(
              onChanged: (text){
                setState(() {
                  _pseudo=text;
                });

              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: new Icon(Icons.account_circle),
                labelText: 'Pseudo'
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
              onChanged: (text){
                setState(() {
                  _mail=text;
                });

              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: new Icon(Icons.mail),
                  labelText: 'E-mail'
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
              obscureText: true,
              onChanged: (text){
                setState(() {
                  _password=text;
                });

              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: new Icon(Icons.lock),
                  labelText: 'Entrer votre mot de passe'
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
              obscureText: true,
              onChanged: (text){
                setState(() {
                  _password2=text;
                });

              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: new Icon(Icons.lock),
                  labelText: 'Confirmer votre mot de passe'
              ),
            ),
            Padding(padding: EdgeInsets.all(15),),
            new RaisedButton(
                onPressed: (){
                  verification();
                },
              child: new Text('Enregistrement'),
              color: Colors.amber,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),

          ],
        ),
      ),
    );
  }


  verification()
  {
    if(_password==_password2)
      {
        //Enregistrement dans la base de donnée
        fireBaseHelper().handleCreate(_pseudo, _mail, _password);
        Navigator.push(context, new MaterialPageRoute(
            builder: (BuildContext context)
                {
                  return mainAppPage();
                }
        ));
      }
    else
      {
        alerte();
      }

  }



  alerte() async
  {
  showDialog(
      context: context,
    barrierDismissible: true,
    builder: (BuildContext Buildcontext)
      {
        if(Platform.isIOS)
          {
            return CupertinoAlertDialog(
              title: new Text('Erreur'),
              content: new Text('Les mots de passe sont différents'),
              actions: <Widget>[
                CupertinoButton(
                  onPressed:() => Navigator.pop(context),
                  child: new Text('OK'),
                ),
              ],

            );

          }
        else
          {
            return SimpleDialog(
              title: new Text('Erreur'),
              children: <Widget>[
                new Text('Les mots de passe sont différents'),
                new RaisedButton(
                    onPressed: ()=>Navigator.pop(context),
                  child: new Text('Ok'),
                )
              ],
            );

          }
      }
  );
  }

}