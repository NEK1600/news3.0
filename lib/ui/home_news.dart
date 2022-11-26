import 'package:flutter/material.dart';
import 'package:news3_0/data/model/news_model.dart';
import 'package:news3_0/data/remote/api_client.dart';
import 'package:provider/provider.dart';

class HomeNewsModel extends ChangeNotifier {
  int indexL = 1;
  late Future<NewsModel> newsModelList;

  int get getIndex => indexL;
  Future<NewsModel> get getNewsList => newsModelList;

  void funIn(int index) {
    indexL = index;
    print('Индекс ${getIndex}');
    notifyListeners();
  }
}

class HomeNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var newsRepositoryProvider = Provider.of<ApiClient>(context, listen: false);
    var homeProv = Provider.of<HomeNewsModel>(context, listen: false);
    homeProv.newsModelList = newsRepositoryProvider.searchNews('');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormFieldWidget(),
              ListBuilderWidget(),
            ]));
  }
}

class TextFormFieldWidget extends StatelessWidget {
  final _wordException = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var homeProv = Provider.of<HomeNewsModel>(context, listen: false);
    var newsRepositoryProvider = Provider.of<ApiClient>(context, listen: false);
    return Container(
        color: Color(0xFF393939),
        child: ExpansionTile(
            backgroundColor: Color(0xFF393939),
            title: const Center(
                child: Text(
              "Фильтр слово",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            children: <Widget>[
              TextFormField(
                controller: _wordException,
                decoration: const InputDecoration(
                    hintStyle:
                        TextStyle(fontSize: 17, color: Color(0xFF7D7D7D)),
                    filled: true,
                    fillColor: Color(0xFF202020),
                    hintText: 'ключевое слово'),
                onFieldSubmitted: (price) {
                  homeProv.newsModelList = newsRepositoryProvider.searchNews(price);
                },
              )
            ]));
  }
}

class ListBuilderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext contextM) {
    var homeProv = Provider.of<HomeNewsModel>(contextM, listen: false);
    return Expanded(
        flex: 10,
        child: Consumer<ApiClient>(
          builder: (context, model, child) {
            return FutureBuilder(
              future: homeProv.newsModelList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: model.newsmModel!.articles!.length,
                    itemBuilder: (context, index) => GestureDetector(
                      child: CardNewWidget(
                        title: model.newsmModel!.articles[index]!.title,
                      ),
                      onTap: () {
                        homeProv.funIn(index);
                        Navigator.pushNamed(context, '/one/description',
                            arguments: {
                              "index": homeProv.getIndex,
                              "newsList": homeProv.getNewsList});
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            );
          },
        ));
  }
}

class CardNewWidget extends StatelessWidget {
  final String title;
  CardNewWidget({required this.title,});
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
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25), maxLines: 3),
              ])),
    );
  }
}
