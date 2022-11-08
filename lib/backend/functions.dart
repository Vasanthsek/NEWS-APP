import 'dart:convert';



import 'package:http/http.dart' as http;
import 'package:tech_news/components/searchbar.dart';


Future<List> fetchnews()async {
  
  String search = SearchBar.searchController.text.toLowerCase().trim();
  final response = await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=$search&pageSize=100&apiKey=e4a90d8f29734d4d874199f6fb82a7bb"));
  Map result = jsonDecode(response.body);
  if(response.statusCode == 200){
    
     return result["articles"];
  } else{
    return result["articles"];
  }
  
 
  
}