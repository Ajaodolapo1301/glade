
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glade/animation/fadeRoute.dart';
import 'package:glade/constant.dart';

import 'package:glade/screens/lastPage.dart';

import 'package:glade/utils/CustomUtils.dart';
import 'package:glade/view_models/AppState.dart';
import 'package:glade/view_models/bank.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  var code;
  var bankName;

  BankState bankState;
  TextEditingController bank = new TextEditingController();
  TextEditingController accountNum = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  TextEditingController accountName = new TextEditingController();
  AppState appState;
  var result;
  ProgressDialog pd;
  void showPdDialog() async {
    pd = await CustomUtils.showProgressDialog(
        context, "Processing...Please wait!");
  }

  @override
  Widget build(BuildContext context) {
    bankState = Provider.of<BankState>(context);
    pd = ProgressDialog(context);
    appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bank Details",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: 370,
                      margin: EdgeInsets.only(top: 4, left: 8, right: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(7)
//
                          ),
                      child: Container(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 300,
                              child: TextFormField(
                                controller: bank,
                                onTap: () {
                                  showSheet();
                                },
                                autofocus: true,
//                          keyboardType: TextInputType.emailAddress,

                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Choose your bank",
                                    contentPadding: const EdgeInsets.all(20.0)),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              onPressed: () {
                                showSheet();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: 370,
                      margin: EdgeInsets.only(top: 4, left: 8, right: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(7)

                          ),
                      child: Container(
                        width: 300,
                        child: TextFormField(
                          controller: accountNum,
                          onTap: () {},
                          onChanged: (v) {
                            if (v.length < 10) {
                              accountName.text = "";
                            } else if (v.length == 10 && bank.text.isNotEmpty) {
                              getName();
                            }
                          },
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          validator: (e) {
                            if (e.length < 1) {
                              return "enter a valid Account number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Account num",
                              contentPadding: const EdgeInsets.all(20.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: 370,
                      margin: EdgeInsets.only(top: 4, left: 8, right: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(7)
//
                          ),
                      child: Container(
                        width: 300,
                        child: TextFormField(
                          readOnly: true,
                          controller: accountName,
                          onTap: () {},
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (!(value.length > 5 && value.isNotEmpty)) {
                              return "Account should contain more than 5 characters";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Recipient name",
                              contentPadding: const EdgeInsets.all(20.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                if (_formkey.currentState.validate()) {
                  Navigator.push(context, FadeRoute(page: Last()));
                }
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 50, right: 20, left: 20),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: kprimary, borderRadius: BorderRadius.circular(13)),
                child: Center(
                    child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 20,
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }


//  Method to get Account name
  getName() async {
    showPdDialog();
    result = await bankState.verifyAccount(
        accountnum: accountNum.text, bankCode: code);
    pd.hide();
    if (result["error"] == false) {
      setState(() {
        accountName.text = result["name"];
      });
    } else {
      redAlert(message: result["message"]);
    }
    print(accountName.text);
  }





//  Method for bottomSheet
  showSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20.0)),
        ),
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0))),
                child: ListView.builder(
                    itemCount: bankState.bank.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: bankWidget(
                              name: bankState.bank.values.elementAt(index),
                              bankCode: bankState.bank.keys.elementAt(index)));
                    }),
              );
            },
          );
        });
  }



  void redAlert({String message}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: Container(
              height: 205,
              width: 267,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            message,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 24,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Color(0xffE53227),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                              child: Text(
                            "Close",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }



  Widget bankWidget({name, bankCode}) {
    return InkWell(
        onTap: () {
          setState(() {
            bank.text = name;
            code = bankCode;
          });

          Navigator.pop(context);
        },
        child: Card(
          child: ListTile(title: Text(name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
        ));
  }
}
