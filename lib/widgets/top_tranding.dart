import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../consts/styles.dart';
import '../inner_screens/blog_details.dart';
import '../inner_screens/news_details_webview.dart';
import '../models/news_model.dart';
import '../services/utils.dart';

class TopTrandingWidget extends StatelessWidget {
  const TopTrandingWidget({Key? key}) : super(key: key);
  // final String title, imageurl, url, dateToShow;
  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsModelProvider = Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, NewsDetailsScreen.routename,
                arguments: newsModelProvider.publishedAt);
          },
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  height: size.height * 0.33,
                  width: double.infinity,
                  boxFit: BoxFit.fill,
                  errorWidget: Image.asset('assets/images/empty_image.png'),
                  imageUrl: newsModelProvider.utlToImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  newsModelProvider.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Flexible(
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
                        icon: Icon(
                          Icons.link,
                          color: color,
                        )),
                    const Spacer(),
                    SelectableText(
                      newsModelProvider.dateToShow,
                      style: smallTextStyle,
                    ),
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
