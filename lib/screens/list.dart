import 'package:flutter/material.dart';
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
  String _errorText;
AppState appState;
  Bank _dropdownValue;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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

                        border: InputBorder.none, hintText: "Recipient name", contentPadding: const EdgeInsets.all(20.0)),
                  ),
                ),


              ),
            ),
          ],
        ),
      ),
    );
  }

//  Widget _buildBank() {
//    return FormField(
//      builder: (FormFieldState state) {
//        return DropdownButtonHideUnderline(
//          child: new Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              new InputDecorator(
//                decoration: InputDecoration(
//                  filled: false,
//                  hintText: 'Choose Bank',
//                  labelText:
//                  _dropdownValue == null ? 'Select bank' : "bank",
//                  errorText: _errorText,
//                ),
//                isEmpty: _dropdownValue == null,
//                child: ,
//              ),
//            ],
//          ),
//        );
//      },
//    );
//  }


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
