import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../consts/styles.dart';
import '../inner_screens/blog_details.dart';
import '../inner_screens/news_details_webview.dart';
import '../models/news_model.dart';
import '../services/utils.dart';
import 'verfical_spaceing.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({Key? key}) : super(key: key);
  // final String imageUrl, title, url, dateToShow, readingTime;
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final newsModelProvider = Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              NewsDetailsScreen.routename,
            );
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                        height: size.height * 0.12,
                        width: size.height * 0.12,
                        boxFit: BoxFit.fill,
                        errorWidget:
                            Image.asset('assets/images/empty_image.png'),
                        imageUrl: newsModelProvider.utlToImage,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          newsModelProvider.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: smallTextStyle,
                        ),
                        const VerticalSpace(5),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            '⏱${newsModelProvider.readingTimeText} ',
                            style: smallTextStyle,
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: NewsDetailsWebView(
                                          url: newsModelProvider.url,
                                        ),
                                        inheritTheme: true,
                                        ctx: context,
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.link,
                                    color: Colors.blue,
                                  )),
                              Text(
                                newsModelProvider.dateToShow,
                                maxLines: 1,
                                style: smallTextStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
