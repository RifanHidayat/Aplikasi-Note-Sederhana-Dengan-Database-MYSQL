import 'dart:convert';
import 'package:appservice/layout/AddData.dart';
import 'package:appservice/layout/Detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  String nama="";
  String email="";
  String telp="";
  String jk="";
  String id="";
  Future<List> getData() async {
    final response =
    await http.post("http://192.168.43.49/webservice_note/RestFullAPi",
        body: {"id":id}
    );
    return json.decode(response.body);
  }

  Future _getDataUser() async{
    SharedPreferences sharedPreferences = await
    SharedPreferences.getInstance();

    setState(() {
      nama = sharedPreferences.getString("nama");
      telp = sharedPreferences.getString("telp");
      email = sharedPreferences.getString("email");
      jk = sharedPreferences.getString("jk");
      id = sharedPreferences.getString("id");
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        appBar: new AppBar(
          title: Text("Home"),
          backgroundColor: Colors.blue,
        ),
          floatingActionButton: new FloatingActionButton(
              child: new Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddData()));
              }),
          body: new FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new ItemList(
                list: snapshot.data,
              )
                  : new Center(
                child: new CircularProgressIndicator(),
              );
            },
          ),
        ),
    );
  }
  //inialisasi awal
  void initState() {
    super.initState();
    _getDataUser();

  }

}
class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
      return new Container(
          child: new GestureDetector(
          onTap: () {
        Navigator.of(context).push(new
        MaterialPageRoute(builder: (BuildContext context)
        => Detail(
            list: list, index: i
        )));
      },

    child: new Card(
    color: Colors.white,
    child: new ListTile(
          title: new Text(list[i]['judul']),
          leading: new Icon(Icons.list),
           ),
          ),
          ),
          );
        });
  }

}