import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newz_app/models/news_model.dart';

class Api
{
static Future<List<NewsModel>> fetchArticle()async {
    List<NewsModel>listModel = [];
    var url =Uri.parse('https://newsapi.org/v2/top-headlines?country=eg&apiKey=21697b5ec7fb406ea3cac0d2f7b52b09');
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body)['articles'];
    for(var i in responsebody){
      NewsModel object = NewsModel(title: i['title'], description: i['description'], url: i['url'], urlToImage: i['urlToImage']);
      listModel.add(object);
    }
    return listModel;
  }


static Future<List<NewsModel>> fetchArticleByCategory(String category)async {
    List<NewsModel>listModel = [];
    var url =Uri.parse('https://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=21697b5ec7fb406ea3cac0d2f7b52b09');
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body)['articles'];
    for(var i in responsebody){
      NewsModel object = NewsModel(title: i['title'], description: i['description'], url: i['url'], urlToImage: i['urlToImage']);
      listModel.add(object);
    }
    return listModel;
  }


}