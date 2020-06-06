import 'package:academysebene/ajouterTrack.dart';
import 'package:academysebene/listingTrack.dart';
import 'package:academysebene/listingUtilisateur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class administration extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeAdmin();
  }


}

class homeAdmin extends State<administration>{
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
                new BottomNavigationBarItem(icon: new Icon(Icons.account_circle,),
                    title: new Text(
                      "Utilisateur", style: new TextStyle(fontSize: 18),)),
                new BottomNavigationBarItem(icon: new Icon(Icons.add_circle),
                    title: new Text(
                      "Ajouter Track", style: new TextStyle(fontSize: 18),)),

                new BottomNavigationBarItem(icon: new Icon(Icons.music_note),
                    title: new Text(
                      "Tracks", style: new TextStyle(fontSize: 18),)),

              ]
          ),
          tabBuilder: (BuildContext context, int index) {
            Widget controllerSelected = controller()[index];
            return Scaffold(
                appBar: AppBar(



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
                        "Utilisateur", style: new TextStyle(fontSize: 18),),
                    ),
                    new Tab(
                      icon: new Icon(Icons.add_circle),
                      child: new Text(
                        "Ajouter Track", style: new TextStyle(fontSize: 18),),
                    ),
                    new Tab(
                      icon: new Icon(Icons.music_note),
                      child: new Text(
                        "Track", style: new TextStyle(fontSize: 18),),
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

  List <Widget> controller() {
    return [
      listingUtilisateur(),
      ajouterTrack(),
      listingTrack(),

    ];
  }

}