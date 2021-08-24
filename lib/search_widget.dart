import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWidget extends StatelessWidget {
  final String search;
  final Function(String) onSearchSubmitted;
  SearchWidget({this.onSearchSubmitted, this.search = ''});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        alignment: Alignment.center,
        width: width > 600 ? 600 : width,
        child: TextFormField(
          initialValue: search,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, size: 30.0),
              contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
              hintText: 'Search',
              hintStyle: GoogleFonts.raleway(color: Colors.grey)),
          onFieldSubmitted: (value) {
            onSearchSubmitted(value);
          },
        ),
      ),
    );
  }
}
