
import 'package:flutter/cupertino.dart';
import 'package:glade/model/bank.dart';

class AppState with ChangeNotifier{


  List<Bank> listOfBnk = [
    Bank(

      id: "1",
      name: "Gtbank"
    ),

    Bank(

        id: "2",
        name: "Skybank"
    ),
    Bank(

        id: "3",
        name: "First name"
    ),
  ];


}