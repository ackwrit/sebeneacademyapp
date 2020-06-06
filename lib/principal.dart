import 'package:academysebene/classes/fireBaseHelper.dart';
import 'package:academysebene/mainAppPage.dart';
import 'package:academysebene/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class principal extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homePrincipal();
  }

}

class homePrincipal extends State<principal>{
  String _mail;
  String _password;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SingleChildScrollView(
      child: new Container(
        padding: EdgeInsets.all(10),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/Logo_Transparent.png',
              height: MediaQuery.of(context).size.height/2.5,
            ),
            new TextField(
              onChanged: (text){
                setState(() {
                  _mail=text;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                prefixIcon: new Icon(Icons.mail),
                labelText: 'E-Mail',
                fillColor: Colors.amber,
                hoverColor: Colors.amber,

              ),

            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),

            new TextField(
              obscureText: true,
              onChanged: (text){
                setState(() {
                  _password=text;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                prefixIcon: new Icon(Icons.lock),
                labelText: 'Password',
                fillColor: Colors.amber,
                hoverColor: Colors.amber,

              ),

            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: ()=> versInscription(),
                  child: new Text('Inscription',style: new TextStyle(color: Colors.amber),),
                ),
                FlatButton(
                  onPressed: (){
                    fireBaseHelper().handleSign(_mail, _password);
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context)
                            {
                              return mainAppPage();
                            }
                    ));


                  },
                  child: new Text('Connexion',style:new TextStyle(color: Colors.amber),),
                )

              ],
            ),

          ],
        ),
      ),

    );


  }


  versInscription()
  {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context)
            {
              return register();
            }
    ));
  }

}