import 'package:flutter/material.dart';
import 'package:news3_0/data/model/news_model.dart';
import 'package:news3_0/data/remote/api_client.dart';
import 'package:provider/provider.dart';

class HomeNewsModel extends ChangeNotifier{
  var indexL;
  late Future<NewsModel> newsModelList;
}

class HomeNewsScreen extends StatelessWidget {
  final _wordException = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //var newsRepositoryProvider = Provider.of<ApiClient>(context,listen: false).newsmModel;
    var newsRepositoryProvider = Provider.of<ApiClient>(context,listen: false);
    var homeProv = Provider.of<HomeNewsModel>(context,listen: false);
    homeProv.newsModelList = newsRepositoryProvider.searchNews('');
    /*Provider.of<Repository>(context).getNewsRepository('').then(
            (data) => this.newsModelList2 = data);*/

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(),
        ),
        body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    color: Color(0xFF393939),
                    child: ExpansionTile(
                        backgroundColor: Color(0xFF393939),
                        title: const Center(child: Text("Фильтр слово", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),)),
                        children: <Widget>[
                          TextFormField(
                              controller: _wordException,
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFF7D7D7D)),
                                  filled: true,
                                  fillColor: Color(0xFF202020),
                                  hintText: 'ключевое слово'
                                  ),
                                onFieldSubmitted: (price) {
                                  print('price - ${price}');
                                  homeProv.newsModelList = newsRepositoryProvider.searchNews(price);
                                },
                            ),
                        ])),
                Expanded(
                  flex: 10,
                  child: Consumer<ApiClient>(
                    builder: (context, model, child) {
                      return FutureBuilder(
                        future: homeProv.newsModelList,
                        builder:(context, snapshot){
                          if (snapshot.hasData) {
                            print('успех лист ${snapshot.hasData}');
                            return ListView.builder(
                              itemCount: model.newsmModel!.articles!.length,
                              itemBuilder: (context, index) => GestureDetector(
                                child: CardNew(title: model.newsmModel!.articles[index]!.title,),
                                onTap: () {
                                  homeProv.indexL = index;
                                  Navigator.pushNamed(context, '/one/description');
                                  /*Navigator.push(context, new MaterialPageRoute(
                                      builder: (context) => DescriptNews())
                                  );*/
                                },
                              ),
                            );
                          } else if (snapshot.hasError) {
                            print("ошибка ${snapshot.error}");
                            return Text('${snapshot.error}');
                          }
                          print("другое");
                          return const CircularProgressIndicator();
                        },
                      );

                    },
                  )
                ),
              ])
        );
  }
}

class CardNew extends StatelessWidget {
  final String title;
  CardNew({
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
          color: Color(0xFF393939),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25), maxLines: 3),
              ])),
    );
  }
}
