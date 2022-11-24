import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news3_0/data/model/news_model.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class ApiClient extends ChangeNotifier{
  var _newsmModel;
  get newsmModel => _newsmModel;

  Future<NewsModel> searchNews(String qWord) async {
    final urii = Uri.parse(
        'https://newsapi.org/v2/top-headlines?'
    ).replace(queryParameters: {
      'q': qWord,
      'apiKey': "ab5ce5ad9f2746dca1124e780e89b096",
      'country': 'ru',
    });
    print("проверка ${urii}");
    final response = await http.get(urii);

    if (response.statusCode == 200) {
     // var newsModel = null;
      var jsonMap = json.decode(response.body);
      _newsmModel = NewsModel.fromJson(jsonMap);
      print("успех апи2 ${_newsmModel}");
      notifyListeners();
      return _newsmModel;
    } else {
      print("ошибка апи2 ${json.decode(response.body)}");
      throw Exception('Failed to load album');
    }
  }


}