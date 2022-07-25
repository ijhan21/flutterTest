import 'package:flutter/material.dart';

class ImageWidgetApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _ImageWidgetApp();
  }
}

class _ImageWidgetApp extends State<ImageWidgetApp>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Image Widget'),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('image/abc.png', width: 200, height: 130,),
              Text('Hello Flutter', style: TextStyle(fontFamily: 'Pacifico', fontSize: 30, color: Colors.redAccent),)
            ],
          ),
        ),
      ),
    );
  }
}