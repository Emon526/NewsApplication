import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/utils.dart';
import '../widgets/empty_screen.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    // Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Bookmarks',
            style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
          ),
        ),
        body: const EmptyNewsWidget(
            text: 'You did\'t add anything yet to your bookmarks',
            imagePath: 'assets/images/bookmark.png')

        // ListView.builder(
        //   itemCount: 20,
        //   itemBuilder: (ctx, index) {
        //     return const ArticleWidget();
        //   },
        // ),
        );
  }
}
