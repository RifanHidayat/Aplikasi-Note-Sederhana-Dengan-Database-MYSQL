import 'dart:convert';

import 'package:appservice/layout/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}
class _AddDataState extends State<AddData> {
  final GlobalKey<ScaffoldState> scaffoldState =
  new GlobalKey<ScaffoldState>();
  TextEditingController Cjudul = new TextEditingController();
  TextEditingController Cisi = new TextEditingController();
  String id="";

  void addData() async {
    final responseData = await
    http.post("http://192.168.43.49/webservice_note/RestFullAPi/addNote",
        body: {"judul" : Cjudul.text, "isi" : Cisi.text,"id":id}
    );

    final data = jsonDecode(responseData.body);
    var status=data['status'];
    var pesan=data['message'];
    if (status=="true"){
      Navigator.of(context).push(new
      MaterialPageRoute(builder: (BuildContext context) => new Home()));

    }else{

      showSnakeBar(scaffoldState,
          '$pesan');
    }
  }
  Future _getDataUser() async{
    SharedPreferences sharedPreferences = await
    SharedPreferences.getInstance();

    setState(() {
      id= sharedPreferences.getString("id");

    });

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldState,
        appBar: new AppBar(
        title: Text('Isi Note'),
    backgroundColor: Colors.blue,
    ),
    body: Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListView(children: <Widget>[
    new Column(

    children: <Widget>[

    new Padding(padding: new EdgeInsets.only(top:15.0)),
    new TextField(

    controller: Cjudul,
    decoration: new InputDecoration(

        hintText: "Masukan title note",
        labelText: "Title",
        border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0)))),
      new Padding(padding: new EdgeInsets.all(5.0)),

      new TextField(
        maxLines: 15,

          controller: Cisi,
          decoration: new InputDecoration(
              hintText: "Masukan content note",
              labelText: "Content",
              border: new OutlineInputBorder(borderRadius: new
              BorderRadius.circular(20.0)))),
      new Padding(padding: new EdgeInsets.all(5.0)),

      new Padding(padding: const EdgeInsets.all(5.0)),
      new RaisedButton(
        child: new Text("Add Data",
          style: TextStyle(color: Colors.white)
        ),

        color: Colors.blue,
        onPressed: (){
          addData();

        },
      )
    ],
    )
    ],),
    ),
    );
  }
  void initState() {
    super.initState();
    _getDataUser();

  }


  void showSnakeBar(scaffoldState, String _pesan) {
    scaffoldState.currentState.showSnackBar(
      new SnackBar(
        content: Text(_pesan),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      ),
    );
  }
}
