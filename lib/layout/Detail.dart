import 'dart:convert';
import 'package:appservice/layout/Home.dart';
import 'package:flutter/material.dart';
import 'editData.dart';
import 'package:http/http.dart' as http;
class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.list, this.index});
  @override
  _DetailState createState() => _DetailState();
}
class _DetailState extends State<Detail> {
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  void deleteData() async {
    final responseData = await
    http.post("http://192.168.43.49/webservice_note/RestFullAPi/deleteNote",
        body: {'id': widget.list[widget.index]['id']}
    );
    final data = jsonDecode(responseData.body);
    var status=data['status'];
    var pesan=data['message'];
    if (status=="true"){
      //Navigator.pop(context);
      Navigator.of(context).push(new
      MaterialPageRoute(builder: (BuildContext context) => new Home()));

    }else{

      showSnakeBar(scaffoldState,
          '$pesan');
    }
  }

  void confirm() {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: new Text(
                "Are You Sure Want to Delete'${widget.list[widget.index]['judul']}'"), actions: <Widget>[
            new RaisedButton(
                child: new Text(
                  'OK DELETE!',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                  deleteData();

                }),
            FlatButton(
                child: new Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);

                }
            ),
          ],
          );

        }
    );


  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldState,
      appBar: new AppBar(
        title: new Text("${widget.list[widget.index]['judul']}"),
        backgroundColor: Colors.blue,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(10.0),
            height: 500.0,
            child: Row(
              children: <Widget>[
                new Expanded(
                    child: Card(
                      child: new Column(children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(top: 30.0)),

                        new Text(
                          widget.list[widget.index]['isi'],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        new Padding(padding: const EdgeInsets.only(
                            top:30.0)),
                        new Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: <Widget>[
                            new RaisedButton(child: new Text('Edit',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                              color: Colors.deepOrangeAccent,
                              onPressed: () =>
                                  Navigator.of(context).push(new
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new EditData(list: widget.list, index:
                                    widget.index),
                                  )),),
                            Padding( padding: const
                            EdgeInsets.all(5.0),),
                            new RaisedButton(child: new Text('Delete',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                              color: Colors.blue,
                              onPressed: () => confirm(),),
                          ],)
                      ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );




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
