import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glade/screens/splashPage.dart';
import 'package:glade/view_models/AppState.dart';
import 'package:glade/view_models/bank.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await  path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
//  Hive.registerAdapter(DriverAdapter());

//  await Hive.openBox("driver");
//  final box = Hive.box("driver");
//  Driver driver = box.get('driver', defaultValue: null);
//  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_)=>AppState()),
        ChangeNotifierProvider(create: (_)=>BankState()),
      ],
      child: MyApp()));
}


class MyApp extends StatelessWidget {
//  final Driver driver;

//  MyApp({this.driver});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'runDriver',
        theme: ThemeData(

          fontFamily: 'SFPro',
          primarySwatch: Colors.blue,
        ),
        home: SplashPage(),
      ),
    );
  }
}
