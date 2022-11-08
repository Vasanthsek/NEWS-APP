// ignore_for_file: deprecated_member_use


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_news/pages/news_details_webview.dart';
import 'package:tech_news/utils/text.dart';
import 'package:url_launcher/url_launcher.dart';




void showMyBottomSheet(BuildContext context, String title, String description, imageurl, url){
   showBottomSheet(
    backgroundColor: Colors.black,
    elevation: 20,
    shape: const RoundedRectangleBorder(
      
      borderRadius:  BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20 ),
    ),),
  
    context: context, builder: (context) {
      return MyBottomSheet(title: title, description: description, imageurl: imageurl, url: url);
    },);
}


class MyBottomSheet extends StatelessWidget {
  final String title,  description, imageurl, url;
   const MyBottomSheet({Key? key,required this.title,required this.description,required this.imageurl,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
       decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20 ),),
       ),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
         BottomSheetImage(imageurl: imageurl, title: title),
         Container(
          padding: EdgeInsets.all(10),
          child: ModifiedText(text: description,color: Colors.white,size: 16,),
          
         ),
         Container(
          padding: EdgeInsets.all(10),
          child: RichText(text: TextSpan(
            children: [
              TextSpan(
                text: "Read Full Article",
                recognizer: TapGestureRecognizer()..onTap = () {
                 // _launchUrl(url);
                 Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsWebview(detailUrl: url,fct: ()async { await _launchUrl(url);},),));
                  },
                style: GoogleFonts.lato(color: Colors.blue.shade400),
              )
            ]
          )),
         )
        ],
       ),
      ),
    );
  }
}

// _launchUrl(String url)async{
//   final Uri _url = Uri.parse(url);
// if (await canLaunch(url)){
//   await launchUrl(Uri.parse(url));
// }else{
//   throw "Could not launch $url";
// }
// }

Future<void> _launchUrl(String _url) async {

  if (!await launchUrl(Uri.parse(_url))) {
    throw 'Could not launch $_url';
  }
}

class BottomSheetImage extends StatelessWidget {
  final String imageurl, title;
  const BottomSheetImage({Key? key,required this.imageurl, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        children: [
          Container(
            foregroundDecoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black,Colors.transparent],begin: Alignment.bottomCenter,end: Alignment.topCenter ),),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20 ),),image: DecorationImage(image: NetworkImage(imageurl),fit: BoxFit.cover),
          ),),
          Positioned(
            bottom: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              width: 300,
              child: BoldText(text: title, size: 18, color:Colors.white),
            ),
          ),

        ],
      ),
    );
  }
}