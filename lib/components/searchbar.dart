import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_news/backend/functions.dart';
import 'package:tech_news/utils/colors.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);
  static TextEditingController searchController =
      TextEditingController(text: "",);


  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const SizedBox(width: 20,),
        Flexible(
          flex: 4,
          child: Container(
            height: 50,
            width: 300,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      fetchnews();
                    },
                    controller: SearchBar.searchController,
                    decoration: InputDecoration(
                      
                      hintText: "Business/Entertainment/Health...",
                      hintStyle: GoogleFonts.lato(),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              fetchnews();
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: AppColors.darkGrey, shape: BoxShape.circle),
              child: const Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }
}
