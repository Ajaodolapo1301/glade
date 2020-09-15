import 'dart:async';
import 'package:flutter/material.dart';
import 'package:glade/screens/home.dart';


class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {





  @override
  void initState() {

    super.initState();

    Timer(Duration(seconds: 5,) , ()=>   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home())));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white
            ),
          ),

          Center(
            child: Container(
                height: 300,
                width: 300,
                child: Image.asset('images/glade.png')),
          ),

        ],
      ),
    );
  }
}


