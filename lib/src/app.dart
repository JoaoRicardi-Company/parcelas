import 'package:calculo_de_parcelas/src/pages/mobile/main/main_page.dart';
import 'package:calculo_de_parcelas/src/pages/web/main/web_main_page.dart';
import 'package:calculo_de_parcelas/src/presentation/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Parcelas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: selectPlatformHome()
    );
  }

  Widget selectPlatformHome(){
    if (kIsWeb) {
      return MainPage();
    } else {
      return MobileMainPage();
    }
  }
}