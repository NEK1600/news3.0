import 'package:flutter/material.dart';
import 'package:news3_0/data/model/news_model.dart';
import 'package:news3_0/data/remote/api_client.dart';
import 'package:news3_0/ui/home_news.dart';
import 'package:news3_0/ui/web_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          title: Center(child: Text('Фильтр Слово')),
          backgroundColor: Color(0xFF393939),
        ),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<ApiClient>(create: (_)=>ApiClient()),
          ChangeNotifierProvider<HomeNewsModel>(create: (_)=>HomeNewsModel()),
        ],
        child: DescriptWidget(),
      ),
    );
  }
}

class DescriptWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var homeProv = Provider.of<HomeNewsModel>(context,listen: false);
    var newsRepositoryProvider = Provider.of<ApiClient>(context,listen: false);
    homeProv.newsModelList = newsRepositoryProvider.searchNews('');

    print('Полученый индекс ${homeProv.getIndex}');
    return Consumer<ApiClient>(builder: (context, model, child) {
      return FutureBuilder(
        future: homeProv.newsModelList,
        builder:(context, snapshot){
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                TitleWidget(),
                AutorWidget(),
                DescriptionWidget(),
                WebView(),
              ],
            );
          } else if (snapshot.hasError) {
            print("ошибка ${snapshot.error}");
            return Text('${snapshot.error}');
          }
          print("другое");
          return const CircularProgressIndicator();
        },
      );

    });
  }
}


class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    return Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFF393939),
        margin: EdgeInsets.only(bottom: 10),
        child:Text(context.watch<ApiClient>().newsmModel.articles![arguments['index']].title!,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        )
    );
  }
}

class AutorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    if(context.watch<ApiClient>().newsmModel.articles![arguments['index']].author==null){
      return Container(
          height: 33,
          width: MediaQuery.of(context).size.width,
          color: Color(0xFF393939),
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            "Автор не указан",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          )
      );
    }else{
      return Container(
          height: 33,
          width: MediaQuery.of(context).size.width,
          color: Color(0xFF393939),
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            "Источник: ${context.watch<ApiClient>().newsmModel.articles![arguments['index']].author!}",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          )
      );
    }
  }
}

class DescriptionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
     if(context.watch<ApiClient>().newsmModel.articles![arguments['index']].description==null){
      return Text('Смотри дальше');
    }else{
      return Expanded(child:
      Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 10),
          color: Color(0xFF393939),
          child: Text(context.watch<ApiClient>().newsmModel.articles![arguments['index']].description!,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25))
      )
      );
    }
  }
}

