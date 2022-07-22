import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../consts/vars.dart';
import '../models/bookmark_model.dart';
import '../provider/bookmark_provider.dart';
import '../services/utils.dart';
import '../widgets/article_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/empty_screen.dart';
import '../widgets/loading_widget.dart';

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
      drawer: const DrawerWidget(),
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
      body: Column(
        children: [
          FutureBuilder<List<BookMarkModel>>(
              future: Provider.of<BookMarkProvider>(context, listen: false)
                  .fatchBookmarks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(newsType: NewsType.allNews);
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: EmptyNewsWidget(
                        text: "an error occured ${snapshot.error}",
                        imagePath: "assets/images/no_news.png"),
                  );
                } else if (snapshot.data == null) {
                  return const EmptyNewsWidget(
                      text: 'You did\'t add anything yet to your bookmarks',
                      imagePath: 'assets/images/bookmark.png');
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                          value: snapshot.data![index],
                          child: const ArticleWidget(
                            isBookmark: true,
                          ));
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
