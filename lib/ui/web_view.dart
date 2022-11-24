import 'package:flutter/material.dart';
import 'package:news3_0/data/model/news_model.dart';
import 'package:news3_0/data/remote/api_client.dart';
import 'package:news3_0/ui/home_news.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var newsRepositoryProvider = Provider.of<ApiClient>(context,listen: false);
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    return Align(
        alignment: FractionalOffset.bottomCenter,
        child:Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(0xFF393939),),
            child: Text('Читать далее', style: TextStyle(fontSize: 24)),
            onPressed: () => {
              _launchURL(newsRepositoryProvider.newsmModel.articles![arguments['index']].url!.toString()),
            },
          ),
        )
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
