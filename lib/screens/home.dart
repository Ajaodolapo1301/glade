import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:glade/animation/fadeRoute.dart';
import 'package:glade/constant.dart';
import 'package:glade/screens/list.dart';
import 'package:glade/view_models/bank.dart';
import 'package:provider/provider.dart';




class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with AfterLayoutMixin<Home>{
  var bvn;
  BankState bankState;
  @override
  Widget build(BuildContext context) {
    bankState = Provider.of<BankState>(context);
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.white,
//        elevation: 0.0,
//      ),
      body: Container(margin: EdgeInsets.only(top: 60),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Column(
              children: <Widget>[
                Text("Link Your Bvn", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),),
                SizedBox(height: 20,),

                Center(child: Text("Please input BVN to hekp us verify your account.if you cant remember, dial *565*0#", style: TextStyle(fontSize: 15),)),
 SizedBox(height: 20,),
                Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                      border: Border.all(color:Colors.grey)),
                  child:TextFormField(

                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if( !(value.length > 5 && value.isNotEmpty)){
                        return "password should contain more than 5 characters";
                      }
                      bvn  = value;
                      return null;
                    },
                    decoration: InputDecoration(

                        border: InputBorder.none, hintText: "Input your BVN", contentPadding: const EdgeInsets.all(20.0)),
                  ),


                ),],
            ),


              InkWell(
                onTap: (){
                      Navigator.push(context, FadeRoute(page: List()));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color:kprimary,
                      borderRadius: BorderRadius.circular(13)
                  ),
                  child: Center(child: Text("Next", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 20, ),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
        bankState.getListOfBanks();
  }
}
