import 'package:flutter/material.dart';

import 'package:tech_news/components/searchbar.dart';
import 'package:tech_news/utils/constants.dart';

import '../backend/functions.dart';
import '../components/newsbox.dart';
import '../utils/colors.dart';
import '../utils/text.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   late Future<List> news;

   @override
  void initState() {
    news = fetchnews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
      backgroundColor: AppColors.black,
      elevation: 0,
      actions: [],
      title: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoldText(text: "Tech", size: 30, color: AppColors.primary),
            ModifiedText(text: "News", size: 25, color: AppColors.lightWhite),
          ],
          
        ),
      ),
      ),
      body: Column(
        children: [
           SearchBar(),
           Expanded(child: Container(
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<List<dynamic>>(
              future: fetchnews(),
              builder: (context, snapshot) {
                var lengthh = snapshot.data?.length;
                print(lengthh);
                if(snapshot.hasData){
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: lengthh ?? 10  ,
                    itemBuilder: (context, index) {
                     return NewsBox(
                       url: snapshot.data![index]["url"] ?? "https://google.com" ,
                       imageurl: snapshot.data![index]["urlToImage"] ?? Constants.imageurl ,
                       title: snapshot.data![index]["title"] ?? "",
                       time: snapshot.data![index]["publishedAt"] ?? "",
                       description: snapshot.data![index]["description"].toString(),
                     ); 
                    },);
                } else if(!snapshot.hasData){return Center(child: CircularProgressIndicator(color: AppColors.primary));}
                return Center(child: CircularProgressIndicator(color: AppColors.primary),);
              },  ),
           ),),
        ],
      ),
    );
  }
}