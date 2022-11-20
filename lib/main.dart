import 'package:flutter/material.dart';
import 'package:news3_0/ui/description_news.dart';
import 'package:news3_0/ui/home_news.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomeNewsScreen(),
        '/description': (BuildContext context) => DescriptNews(),
      }));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
      home: HomeNewsScreen(),
    );
  }

}
