import 'dart:async';
import 'dart:io';
import 'package:academysebene/classes/Track.dart';
import 'package:academysebene/classes/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';


class fireBaseHelper{
  //autehtification

  final auth = FirebaseAuth.instance;

  Future<FirebaseUser> handleSign(String mail,String password) async
  {
    final AuthResult Result = await auth.signInWithEmailAndPassword(email: mail, password: password);
    FirebaseUser user = Result.user;
    return user;

  }

  Future <FirebaseUser> handleCreate(String pseudo, String mail, String password) async
  {
    final AuthResult authResult = await auth.createUserWithEmailAndPassword(email: mail, password:password);
    FirebaseUser user=authResult.user;
    String uid = user.uid;
    Map map =
        {
          "uid":uid,
          "pseudo":pseudo,
          "mail":mail,
          "typeUtilisateur":"particulier"
        };
    addUsers(uid,map);
    return user;
  }



  Future <FirebaseUser> ajouterTrack(String titre, String lien,String mail,String password) async{
    final AuthResult resultTrack =await auth.createUserWithEmailAndPassword(email: mail, password: password);
    FirebaseUser track =resultTrack.user;
    String uid= track.uid;
    Map map =
        {
          "uid":uid,
          "titre":titre,
          "lien":lien

        };
    addTrack(uid,map);
    return track;
  }






  Future<String> myId() async {
    FirebaseUser user = await auth.currentUser();
    return user.uid;
  }







    //Database

  static final base=FirebaseDatabase.instance.reference();
  final base_user=base.child("users");
  final base_track= base.child('track');



  addUsers(String uid,Map map)
  {
    base_user.child(uid).set(map);
  }




  addTrack(String uid,Map map){
    base_track.child(uid).set(map);
  }


  deleteTrack(String uid){
    base_track.child(uid).remove();
  }

  Future <Track> getTrack(String uid) async{
    DataSnapshot snapshot = await base_track.child(uid).once();
    return Track(snapshot);
  }


  Future<User> getUser(String uid) async
  {
    DataSnapshot snapshot = await base_user.child(uid).once();
    return User(snapshot);
  }





  //storage
static final base_storage = FirebaseStorage.instance.ref();
  final StorageReference storage_track = base_storage.child("track");



  Future <String> savePodcast(File file,StorageReference storageReference) async{
    StorageUploadTask storageUploadTask = storageReference.putFile(file);
    StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }


}






