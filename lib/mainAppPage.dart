import 'package:academysebene/classes/fireBaseHelper.dart';
import 'package:academysebene/controller/backTrack.dart';
import 'package:academysebene/login.dart';
import 'package:academysebene/principal.dart';
import 'package:academysebene/register.dart';
import 'package:academysebene/track.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'classes/User.dart';


class mainAppPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeMain();
  }

}

class homeMain extends State<mainAppPage>{
  User _login;
  String _identifiant;
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
          _login=user;
        });

      });

    });
  }
  @override
  Widget build(BuildContext context) {
    if (Theme
        .of(context)
        .platform == TargetPlatform.iOS) {
      return new CupertinoTabScaffold(
          tabBar: new CupertinoTabBar(
              backgroundColor: Colors.amber,
              activeColor: Colors.black,
              inactiveColor: Colors.white,
              items: [
                new BottomNavigationBarItem(icon: new Icon(Icons.music_note,size: 1,),
                    title: new Text(
                      "Coaching", style: new TextStyle(fontSize: 18),)),


                new BottomNavigationBarItem(icon: Icon(Icons.music_note,size: 1,),
                    title: new Text(
                      "Backing Track", style: new TextStyle(fontSize: 18),)),

                new BottomNavigationBarItem(icon: new Icon(Icons.music_note,size: 1,),
                    title: new Text(
                      "Standard rumba", style: new TextStyle(fontSize: 18),)),
                new BottomNavigationBarItem(icon: new Icon(Icons.music_note,size: 1,),
                    title: new Text(
                      "Standard Sebene", style: new TextStyle(fontSize: 18),)),



              ]
          ),
          tabBuilder: (BuildContext context, int index) {
            Widget controllerSelected = controller()[index];
            return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      icon: (Icon(Icons.account_circle)),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context)
                                {
                                  return principal();
                                }
                        ));
                      }
                  ),



                  title: new Text("Sebene Academy"),
                  backgroundColor: Colors.amber,

                ),
                body: controllerSelected
            );
          }
      );
    }
    else {
      return DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(


                title:new Text('Sebene Academy'),
                centerTitle: true,
                backgroundColor: Colors.amber,
                bottom: new TabBar(
                  tabs: [
                    new Tab(
                      icon: new Icon(Icons.account_circle),
                      child: new Text(
                        "Login", style: new TextStyle(fontSize: 18),),
                    ),
                    new Tab(
                      icon: new Icon(Icons.music_note),
                      child: new Text(
                        "Backing Track", style: new TextStyle(fontSize: 18),),
                    )


                  ],
                  labelColor: Colors.black,
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                ),
              ),
              body: new TabBarView(
                children: controller(),
              )
          )
      );
    }
  }

  Widget authentification()
  {
    return StreamBuilder <FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context,snapshot){
        if(snapshot.hasData)
        {
          //Si on a des datas , on est authentifié
          return login(profil: _login,);
        }
        else
        {
          //on est n'est pas off
          return principal();
        }
      },

    );
  }


  List <Widget> controller() {
    return [
      backTrack(),
      backTrack(),
      backTrack(),
      backTrack()

    ];
  }




}


