import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home : home(),
  ));
}
class home extends StatefulWidget{
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int counter = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : Text('Dhruv Choudhary'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
    body : Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Center(child: Text('HELLO')),
              Text('hi'),
            ],
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.red,
            child: Text('two'),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.cyan,
            child: Text('One'),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.green,
            child: Text('three'),
          ),
          Container(
            child: Text('$counter'),
            color: Colors.red,   
          ),
        ],


    ),

    floatingActionButton: FloatingActionButton(
      onPressed: () {
        setState(() {
          counter += 1;
        });
      },
      child : Text("hi"),
      backgroundColor: Colors.red,
    ),
    );
  }
}