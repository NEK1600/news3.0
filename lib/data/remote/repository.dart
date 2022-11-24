import 'package:flutter/foundation.dart';
import 'package:news3_0/data/model/news_model.dart';
import 'package:news3_0/data/remote/api_client.dart';

class Repository {
  ApiClient _clientProvider = ApiClient();
  Future<NewsModel> getNewsRepository(String qWord) async {
    //notifyListeners();
    return _clientProvider.searchNews(qWord);
  }

}