import 'package:flutter/material.dart';
import 'package:news3_0/data/model/news_model.dart';
import 'package:news3_0/data/remote/api_client.dart';

class HomeNewsScreen extends StatefulWidget {
  const HomeNewsScreen({Key? key}) : super(key: key);
  @override
  HomeNewsState createState() => HomeNewsState();
}

class HomeNewsState extends State<HomeNewsScreen> {
  late Future<NewsModel> newsModelList;
  final _wordException = TextEditingController();

  @override
  void initState() {
    newsModelList = ApiClient().searchNews('');
    super.initState();
  }

  @override
  void dispose() {
    _wordException.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(),
        ),
        body: Builder(builder: (BuildContext context) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _wordException,
                                    decoration: const InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 17, color: Color(0xFF7D7D7D)),
                                        filled: true,
                                        fillColor: Color(0xFF202020),
                                        hintText: 'ключевое слово'
                                    ),
                                    onChanged: (str)async {
                                      /*str = _wordException.text;
                                  futureAlbum2 = ApiClient().fetchAlbumTwo(str);*/
                                      setState(() {
                                        str = _wordException.text;
                                        newsModelList = ApiClient().searchNews(str);
                                      });
                                    },
                                  ),
                                ),
                              ])
                        ])),
                Expanded(
                  flex: 10,
                  child: FutureBuilder<NewsModel>(
                    future: newsModelList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.articles?.length,
                          itemBuilder: (context, index) => GestureDetector(
                            child: CardNew(
                              title: snapshot.data!.articles![index].title!,
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/description',
                                  arguments: {'exampleArgument': index});
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        //print("ошибка ${snapshot.error}");
                        return Text('${snapshot.error}');
                      }
                      //print("другое");
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ]);
        }));
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
                Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                    maxLines: 3),
              ])),
    );
  }
}
