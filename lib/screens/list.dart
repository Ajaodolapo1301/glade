import 'package:flutter/material.dart';
import 'package:glade/animation/fadeRoute.dart';
import 'package:glade/constant.dart';
import 'package:glade/model/bank.dart';
import 'package:glade/view_models/AppState.dart';
import 'package:provider/provider.dart';




class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {


  TextEditingController bank = new TextEditingController();
  TextEditingController AccountNum = new TextEditingController();

  TextEditingController AccountName = new TextEditingController();
  String _errorText;
AppState appState;
  Bank _dropdownValue;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: (){
          Navigator.pop(context);
        },),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 5,),
            Text("GET BANKS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
            SizedBox(height: 20,),
            Center(
              child: Container(

                width: 370,
          margin: EdgeInsets.only(top: 4, left: 8, right: 8),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(7)
//
                    ),
                child:Container(
                  width: 300,
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 300,
                        child: TextFormField(
                          controller: bank,
                          onTap: (){
                            showSheet();
                          },
                          autofocus: true,
//                          keyboardType: TextInputType.emailAddress,

                          decoration: InputDecoration(

                              border: InputBorder.none, hintText: "Choose your bank", contentPadding: const EdgeInsets.all(20.0)),
                        ),
                      ),
                      IconButton(icon: Icon(Icons.keyboard_arrow_down), onPressed: (){

                        showSheet();
                      },)

                    ],
                  ),
                ),


              ),
            ),

            SizedBox(height: 20,),
            Center(
              child: Container(

                width: 370,
                margin: EdgeInsets.only(top: 4, left: 8, right: 8),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(7)
//
                ),
                child:      Container(
                  width: 300,
                  child: TextFormField(
                    controller: AccountNum,
                    onTap: (){

                    },
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if( !(value.length > 5 && value.isNotEmpty)){
                        return "Account should contain more than 5 characters";
                      }
//                  bank  = value;
                      return null;
                    },
                    decoration: InputDecoration(

                        border: InputBorder.none, hintText: "Account num", contentPadding: const EdgeInsets.all(20.0)),
                  ),
                ),


              ),
            ),

            SizedBox(height: 20,),
            Center(
              child: Container(

                width: 370,
                margin: EdgeInsets.only(top: 4, left: 8, right: 8),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(7)
//
                ),
                child:      Container(
                  width: 300,
                  child: TextFormField(
                    controller: AccountName,
                    onTap: (){

                    },
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if( !(value.length > 5 && value.isNotEmpty)){
                        return "Account should contain more than 5 characters";
                      }
//                  bank  = value;
                      return null;
                    },
                    decoration: InputDecoration(

                        border: InputBorder.none, hintText: "Recipient name", contentPadding: const EdgeInsets.all(20.0)),
                  ),
                ),


              ),
            ),



Spacer(),

            InkWell(
              onTap: (){
                Navigator.push(context, FadeRoute(page: List()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 50, right: 20, left: 20),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: kprimary,
                    borderRadius: BorderRadius.circular(13)
                ),
                child: Center(child: Text("Next", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 20, ),)),
              ),
            ),
          ],
        ),
      ),
    );
  }



  showSheet(){
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,

        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20.0)),
        ),
        builder: (builder){
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState){
              return
                Container(
                    height: MediaQuery.of(context).size.height * 0.7,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0))
                    ),
                  child: ListView.builder(
                    itemCount: appState.listOfBnk.length,
                      itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: bankWidget(appState.listOfBnk[index].name)
                    );

                  }),
                );
            },


          );
        });
  }

  Widget bankWidget (name){
    return InkWell(
        onTap: (){
          setState(() {
            bank.text = name;
          });
          print(bank.text);
          Navigator.pop(context);
        },

        child: Text(name));
  }



}
