

import 'package:flutter/cupertino.dart';
import 'package:glade/api/api.dart';

abstract class ABankState {
  Future<Map<String,dynamic>> getListOfBanks();
  Future<Map<String,dynamic>> verifyAccount({String accountnum,  String bankCode});
}



class BankState extends ABankState with  ChangeNotifier{

  var _banks = {};
  get bank => _banks;

  set bank(bank1) {
    _banks = bank1;
    notifyListeners();
  }



  @override
  Future<Map<String, dynamic >> getListOfBanks() async {
    Map<String, dynamic> result = Map();

    try{
      result = await ListOfBanks().getListOfBanks();
      if(result['error'] == null){
        result['error'] = true;
        result['message'] = 'An Error occured, please try again';
      }else if(result['error'] == false){
        bank = result['banks'];

      }

    }catch(error){
      print(error.toString());
    }
    print(result);
    return result;

  }

  @override
  Future<Map<String,dynamic>> verifyAccount({String accountnum, String bankCode})  async{
    Map<String, dynamic> result = Map();
    try{
      result = await ListOfBanks().verifyAccount(accountnum: accountnum, bankCode: bankCode);
      if(result['error'] == null){
        result['error'] = true;
        result['message'] = 'An Error occured, please try again';
      }
    }catch(e){
      print(e.toString());
    }


    return result;
  }

}