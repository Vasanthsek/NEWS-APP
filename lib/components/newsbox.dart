import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_news/components/bottomsheet.dart';
import 'package:tech_news/utils/colors.dart';
import 'package:tech_news/utils/text.dart';

class NewsBox extends StatelessWidget {
  final String imageurl,title, time, description,url;
  const NewsBox({Key? key, required this.description,required this.imageurl,required this.title,required this.url,required this.time,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
           showMyBottomSheet(context, title, description, imageurl, url);
          },
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(left: 5,right: 5,top: 5),
            width: MediaQuery.of(context).size.width,
            color: AppColors.black,
            child: Row(
              children: [
                CachedNetworkImage(imageUrl: imageurl,
                imageBuilder: (context, imageProvider) => Container(
                  height: 100,
                  width: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider,fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellow,
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(color: AppColors.primary),
                
                errorWidget: (context, url, error) => const Icon(Icons.error),),
                const SizedBox(width: 8,),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModifiedText(text: title, size: 16, color: AppColors.white),
                    const SizedBox(height: 5,),
                    ModifiedText(text: time, size: 12, color: AppColors.lightWhite)
                  ],
                ))
              ],
            ),
          ),),
      ],
    );
  }
}

