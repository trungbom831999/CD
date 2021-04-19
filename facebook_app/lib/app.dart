import 'package:facebook_app/root_page.dart';
import 'package:facebook_app/src/view/register/register_page_step_1.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/second': (context) => RegisterPageFirst(),
      },
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}
