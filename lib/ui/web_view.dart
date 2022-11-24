import 'package:flutter/material.dart';
import 'package:news3_0/data/model/news_model.dart';
import 'package:news3_0/ui/home_news.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WebView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var homeProv = Provider.of<HomeNewsModel>(context,listen: false);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Color(0xFF393939),),
      child: Text('Читать далее', style: TextStyle(fontSize: 24)),
      onPressed: () => {
        homeProv.newsModelList.then((result) =>
            _launchURL(result.articles![homeProv.indexL].url!)
        ),
      },
    );
  }

  _launchURL(String string) async {
    var uri = Uri.parse(string);
    debugPrint("лаунч ${uri}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("кнопка есть${string}");
      throw 'Could not launch $uri';
    }
  }


}