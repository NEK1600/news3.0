import 'package:flutter/material.dart';
import 'package:news3_0/data/model/news_model.dart';
import 'package:news3_0/data/remote/api_client.dart';
import 'package:news3_0/ui/home_news.dart';
import 'package:news3_0/ui/web_view.dart';
import 'package:provider/provider.dart';

class DescriptNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var homeProv = Provider.of<HomeNewsModel>(context,listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          title: Center(child: Text('Фильтр Слово')),
          backgroundColor: Color(0xFF393939),
        ),
      ),
      body: DescriptWidget(),
      bottomSheet: SizedBox(
          width: double.infinity,
          height: 50,
          child: WebView()),
    );
  }
}

class DescriptWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var homeProv = Provider.of<HomeNewsModel>(context,listen: false);
    return Consumer<ApiClient>(builder: (context, model, child) {
      return Column(
        children: <Widget>[
          Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF393939),
              margin: EdgeInsets.only(bottom: 10),
              child:Text(model.newsmModel.articles![homeProv.indexL].title!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                    )
              ),
          Container(
              height: 33,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF393939),
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                        "Источник: ${model.newsmModel.articles![homeProv.indexL].author!}",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ),
          Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10),
              color: Color(0xFF393939),
              child: Text(model.newsmModel.articles![homeProv.indexL].description!,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25))
                  ),
        ],
      );
    });
  }
}
