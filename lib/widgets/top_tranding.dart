import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../consts/styles.dart';
import '../inner_screens/blog_details.dart';
import '../inner_screens/news_details_webview.dart';
import '../services/utils.dart';

class TopTrandingWidget extends StatelessWidget {
  const TopTrandingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              NewsDetailsScreen.routename,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  height: size.height * 0.33,
                  width: double.infinity,
                  boxFit: BoxFit.fill,
                  errorWidget: Image.asset('assets/images/empty_image.png'),
                  imageUrl: 'https://picsum.photos/200',
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const NewsDetailsWebView(),
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
                    '10-12-1999',
                    style: smallTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
