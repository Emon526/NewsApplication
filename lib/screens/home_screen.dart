import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../consts/vars.dart';
import '../inner_screens/search_screen.dart';
import '../models/news_model.dart';
import '../provider/news_provider.dart';
import '../services/utils.dart';
import '../widgets/article_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/empty_screen.dart';
import '../widgets/loading_widget.dart';
import '../widgets/tabs.dart';
import '../widgets/top_tranding.dart';
import '../widgets/verfical_spaceing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByEnum.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'News App',
            style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                IconlyLight.search,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const SearchScreen(),
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
            )
          ],
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                TabsWidget(
                  text: 'All news',
                  color: newsType == NewsType.allNews
                      ? Theme.of(context).cardColor
                      : Colors.transparent,
                  function: () {
                    if (newsType == NewsType.allNews) {
                      return;
                    }
                    setState(() {
                      newsType = NewsType.allNews;
                    });
                  },
                  fontsize: newsType == NewsType.allNews ? 22 : 14,
                ),
                const SizedBox(
                  width: 25,
                ),
                TabsWidget(
                  text: 'Top trending',
                  color: newsType == NewsType.topTrending
                      ? Theme.of(context).cardColor
                      : Colors.transparent,
                  function: () {
                    if (newsType == NewsType.topTrending) {
                      return;
                    }
                    setState(() {
                      newsType = NewsType.topTrending;
                    });
                  },
                  fontsize: newsType == NewsType.topTrending ? 22 : 14,
                ),
              ],
            ),
            const VerticalSpace(10),
            newsType == NewsType.topTrending
                ? Container()
                : SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        paginationButton(
                          text: 'Prev',
                          function: () {
                            if (currentPageIndex == 0) {
                              return;
                            }
                            setState(() {
                              currentPageIndex -= 1;
                            });
                          },
                        ),
                        Flexible(
                          flex: 2,
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    color: currentPageIndex == index
                                        ? Colors.blue
                                        : Theme.of(context).cardColor,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentPageIndex = index;
                                        });
                                      },
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${index + 1}"),
                                      )),
                                    ),
                                  ),
                                );
                              })),
                        ),
                        paginationButton(
                          text: 'Next',
                          function: () {
                            if (currentPageIndex == 4) {
                              return;
                            }
                            setState(() {
                              currentPageIndex += 1;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
            const VerticalSpace(10),
            newsType == NewsType.topTrending
                ? Container()
                : Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                            value: sortBy,
                            items: dropDownitems,
                            onChanged: (String? value) {
                              setState(() {
                                sortBy = value!;
                              });
                            }),
                      ),
                    ),
                  ),

            FutureBuilder<List<NewsModel>>(
                future: newsProvider.fatchAllNews(
                    pageIndex: currentPageIndex + 1, sortBy: sortBy),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return newsType == NewsType.allNews
                        ? LoadingWidget(newsType: newsType)
                        : Expanded(child: LoadingWidget(newsType: newsType));
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: EmptyNewsWidget(
                          text: "an error occured ${snapshot.error}",
                          imagePath: "assets/images/no_news.png"),
                    );
                  } else if (snapshot.data == null) {
                    return const Expanded(
                      child: EmptyNewsWidget(
                          text: "No news found",
                          imagePath: "assets/images/no_news.png"),
                    );
                  }
                  return newsType == NewsType.allNews
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (ctx, index) {
                              return ChangeNotifierProvider.value(
                                value: snapshot.data![index],
                                child: const ArticleWidget(
                                    // imageUrl: snapshot.data![index].utlToImage,
                                    // title: snapshot.data![index].title,
                                    // dateToShow: snapshot.data![index].dateToShow,
                                    // readingTime:
                                    //     snapshot.data![index].readingTimeText,
                                    // url: snapshot.data![index].url,
                                    ),
                              );
                            },
                          ),
                        )
                      : SizedBox(
                          height: size.height * 0.6,
                          child: Swiper(
                            autoplayDelay: 8000,
                            autoplay: true,
                            itemWidth: size.width * 0.9,
                            layout: SwiperLayout.STACK,
                            viewportFraction: 0.9,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return TopTrandingWidget(
                                dateToShow: snapshot.data![index].dateToShow,
                                imageurl: snapshot.data![index].utlToImage,
                                title: snapshot.data![index].title,
                                url: snapshot.data![index].url,
                              );
                            },
                          ),
                        );
                }),

            // LoadingWidget(
            //   newsType: newsType,
            // )
          ]),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropDownitems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
          value: SortByEnum.relevancy.name,
          child: Text(
            SortByEnum.relevancy.name,
          )),
      DropdownMenuItem(
          value: SortByEnum.publishedAt.name,
          child: Text(
            SortByEnum.publishedAt.name,
          )),
      DropdownMenuItem(
          value: SortByEnum.popularity.name,
          child: Text(
            SortByEnum.popularity.name,
          )),
    ];
    return menuItem;
  }

  Widget paginationButton({required Function function, required String text}) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: const EdgeInsets.all(6),
          textStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      child: Text(
        text,
      ),
    );
  }
}
