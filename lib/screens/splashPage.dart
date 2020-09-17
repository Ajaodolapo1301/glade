import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:glade/screens/home.dart';
import 'package:glade/view_models/bank.dart';
import 'package:provider/provider.dart';


class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin<SplashPage>{

  BankState bankState;



  @override
  void initState() {

    super.initState();

    Timer(Duration(seconds: 5,) , ()=>   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home())));

  }

  @override
  Widget build(BuildContext context) {
    bankState = Provider.of<BankState>(context);
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

  @override
  void afterFirstLayout(BuildContext context) {
    bankState.getListOfBanks();
  }
}


