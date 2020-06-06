import 'package:academysebene/updateTrack.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'classes/Track.dart';
import 'classes/fireBaseHelper.dart';


class listingTrack extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeTrackList();
  }



}


class homeTrackList extends State<listingTrack>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FirebaseAnimatedList(
        query: fireBaseHelper().base_track,
        itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation <double> animation,int index)
        {
          Track listeTrack = new Track(snapshot);
          return Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(listeTrack.titre),
                  IconButton(icon: Icon(Icons.dehaze),
                      onPressed: (){
                    _UpdateTrack(listeTrack);
                      })
                ],
              ),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){
                    fireBaseHelper().deleteTrack(listeTrack.id);
                  }),
            ),
          );

        }
    );
  }


  _UpdateTrack(Track son)
  {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context){
          return updateTrack(son);
        }
    ));
  }

}