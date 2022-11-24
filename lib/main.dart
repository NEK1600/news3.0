import 'package:flutter/material.dart';
import 'package:news3_0/data/model/news_model.dart';
import 'package:news3_0/data/remote/api_client.dart';
import 'package:news3_0/data/remote/repository.dart';
import 'package:news3_0/ui/description_news.dart';
import 'package:news3_0/ui/home_news.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: '/',
      routes:<String, WidgetBuilder> {
        '/one': (BuildContext context) => HomeNewsScreen(),
        '/one/description': (BuildContext context) => DescriptNews(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
      ),
      home: MultiProvider(
        providers: [
          //ChangeNotifierProvider<NewsModel>(create: (_)=>NewsModel()),
          ChangeNotifierProvider<ApiClient>(create: (_)=>ApiClient()),
          ChangeNotifierProvider<HomeNewsModel>(create: (_)=>HomeNewsModel()),
        ],
        child: HomeNewsScreen(),
      ),
    );
  }

}
