import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum NewsType {
  topTrending,
  allNews,
}

enum SortByEnum {
  relevancy, //closely related
  popularity, //popular source and publisher
  publishedAt, // newest articles
}

TextStyle smallTextStyle = GoogleFonts.montserrat(fontSize: 15);
