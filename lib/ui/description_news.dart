import 'package:flutter/material.dart';
import 'package:news3_0/data/model/news_model.dart';
import 'package:news3_0/data/remote/api_client.dart';
import 'package:news3_0/ui/web_view.dart';

class DescriptNews extends StatelessWidget {
  late Future<NewsModel> newsModelList;
  @override
  Widget build(BuildContext context) {
    newsModelList = ApiClient().searchNews('');
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    arguments['exampleArgument'].toString();
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          title: Center(child: Text('Фильтр Слово')),
          backgroundColor: Color(0xFF393939),
        ),) ,
      body:DescriptWidget(newsModelList:newsModelList),
    );
    debugPrint('movieTitle:gh');
  }

}

class DescriptWidget extends StatelessWidget {
  final Future<NewsModel> newsModelList;
  DescriptWidget({
    required this.newsModelList,
  });

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    return Column(
      children:<Widget>[
        Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF393939),
            margin: EdgeInsets.only(bottom:10),
            child:FutureBuilder<NewsModel>(
              future: newsModelList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.articles![arguments['exampleArgument']].title!,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
                  );
                }
                return const CircularProgressIndicator();
              },
            )
        ),
        Container(
            height: 33,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF393939),
            margin: EdgeInsets.only(bottom:10),
            child:FutureBuilder<NewsModel>(
              future: newsModelList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if(snapshot.data!.articles![arguments['exampleArgument']].author==null){
                    debugPrint("успех но");
                    return Text("Источник:",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),);
                  }else{
                    return Text("Источник: ${snapshot.data!.articles![arguments['exampleArgument']].author!}"
                      ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),);
                  }
                }
                return const CircularProgressIndicator();
              },
            )
        ),
        Flexible(
          child:
          Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom:10),
              color: Color(0xFF393939),
              child:FutureBuilder<NewsModel>(
                future: newsModelList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.articles![arguments['exampleArgument']].description!
                      ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),);
                  }
                  return const CircularProgressIndicator();
                },
              )
          ) ,
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child:SizedBox(
              width: double.infinity,
              height: 50,
              child: WebView(futureAlbum: newsModelList)
            )
        ),

      ],
    );
  }

}