import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glade/animation/fadeRoute.dart';
import 'package:glade/constant.dart';
import 'package:glade/model/user.dart';
import 'package:glade/screens/list.dart';
import 'package:glade/utils/CustomUtils.dart';
import 'package:glade/view_models/bank.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin<Home> {
  final _formkey = GlobalKey<FormState>();
  ProgressDialog pd;

  void showPdDialog() async {
    pd = await CustomUtils.showProgressDialog(
        context, "Processing...Please wait!");
  }

  TextEditingController bvn = new TextEditingController();
  BankState bankState;
  @override
  Widget build(BuildContext context) {
    pd = ProgressDialog(context);

    bankState = Provider.of<BankState>(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Link Your Bvn",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                    "Please input BVN to hekp us verify your account.if you cant remember, dial *565*0#",
                    style: TextStyle(fontSize: 15),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formkey,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(color: Colors.grey)),
                      child: TextFormField(
                        controller: bvn,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11)
                        ],
                        validator: (value) {
                          if (value.length < 11) {
                            return "Enter a valid Bvn number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Input your BVN",
                            contentPadding: const EdgeInsets.all(20.0)),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (_formkey.currentState.validate()) {
                    getBvn();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
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
      ),
    );
  }

//  Method to get BVn response
  getBvn() async {
    showPdDialog();
    var result = await bankState.verifyBvn(bvn: bvn.text);

    pd.hide();
    if (result["error"] == false) {
      setState(() {
        User user = result["user"];
        CustomUtils.showCustomDialog(
            DialogType.success,
            context,
            "${user.firstname} ${user.lastname}, Congratulations, Your BVN has beem verified succesfully",
            "Proceed", () {
          bvn.text = " ";
          Navigator.pop(context);
          Navigator.push(context, FadeRoute(page: List()));
        });
      });
    } else if (result["error"] == true) {
      CustomUtils.showCustomDialog(
          DialogType.success,
          context,
          "Ops!, Verification failed, please Ensure you entered your Bvn correctly",
          "Proceed", () {
        bvn.text = " ";
        Navigator.pop(context);
      });
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bankState.getListOfBanks();
  }
}
