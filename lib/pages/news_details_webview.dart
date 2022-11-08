import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsWebview extends StatefulWidget {
  final String detailUrl;
  final VoidCallback fct; 
  const NewsDetailsWebview({Key? key,required this.detailUrl, required this.fct}) : super(key: key);

  @override
  State<NewsDetailsWebview> createState() => _NewsDetailsWebviewState();
}

class _NewsDetailsWebviewState extends State<NewsDetailsWebview> {
  late WebViewController _webViewController;
  double _progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
         if(await _webViewController.canGoBack()){
          _webViewController.goBack();
          return false; //stay in webpage
         }else{return true;}
         
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation:0,
          automaticallyImplyLeading: true,
          title: Text(widget.detailUrl,style: const TextStyle(color: Colors.white,),overflow: TextOverflow.fade,),
          actions: [IconButton(onPressed: ()async{await _showModalSheetFct((){widget.fct();} );}, icon:const Icon(Icons.more_vert))],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(value: _progress,color: _progress==1.0 ? Colors.transparent:Colors.blue,backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
            Expanded(
              flex: 2,
              child: WebView(
                initialUrl:widget.detailUrl ,
                onProgress: (progress) {
                  setState(() {
                     _progress = progress/100;
                  });
                 
                },
                zoomEnabled: true,
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );

  }
  Future<void> _showModalSheetFct(VoidCallback fct) async{
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context, builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
        ),
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20,),
            Center(
              child: Container(
                height: 5,
                width: 35,
                
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
             
            ),
             const SizedBox(height: 20,),
            const  Text("More Options",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey),),
            const SizedBox(height: 20,),
            const Divider(thickness: 1.3,color:Colors.grey,),
            ListTile(leading:const Icon(Icons.share),title: const Text("Share"),onTap: ()async{
              try{await Share.share(widget.detailUrl);}
              catch(e){log("error occured$e");}
            },textColor: Colors.grey,iconColor:  Colors.grey,),
            ListTile(leading:const Icon(Icons.open_in_browser),title:const Text("Open in Browser"),onTap: (){
             try { fct();}
             catch(e){log(e.toString());}
             finally{Navigator.pop(context);}
              },textColor: Colors.grey,iconColor:  Colors.grey,),
            ListTile(leading:const Icon(Icons.refresh),title:const Text("Refresh"),onTap: ()async{
              try{await _webViewController.reload();}
              catch(e){
                log("error occured$e");
              }finally{Navigator.pop(context);}
              },
              textColor: Colors.grey,iconColor:  Colors.grey,),
          ],

        ),
        );
    },);
  }
}