import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/consts/vars.dart';
import 'package:newsapp/services/utils.dart';
import 'package:newsapp/widgets/verfical_spaceing.dart';

class NewsDetailsScreen extends StatefulWidget {
  static const routename = "/NewsDetailsScreen";
  const NewsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'By Author',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
          ),
        ),
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(
        //       IconlyLight.arrowLeft,
        //       color: color,
        //     )),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'titke' * 10,
                  textAlign: TextAlign.justify,
                  style: titleTextStyle,
                ),
                const VerticalSpace(25),
                Row(
                  children: [
                    Text(
                      '20/20/2015',
                      style: smallTextStyle,
                    ),
                    const Spacer(),
                    Text(
                      'readingTimetext',
                      style: smallTextStyle,
                    ),
                  ],
                ),
                const VerticalSpace(20),
              ],
            ),
          ),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: FancyShimmerImage(
                    boxFit: BoxFit.fill,
                    errorWidget: Image.asset('assets/images/empty_image.png'),
                    imageUrl: 'https://picsum.photos/200',
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 10,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              IconlyLight.send,
                              size: 28,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 10,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              IconlyLight.bookmark,
                              size: 28,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const VerticalSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextContent(
                  label: 'Description',
                  fontsize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const VerticalSpace(10),
                TextContent(
                  label: "description " * 12,
                  fontsize: 18,
                  fontWeight: FontWeight.normal,
                ),
                const VerticalSpace(20),
                const TextContent(
                  label: 'Contents',
                  fontsize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const VerticalSpace(10),
                TextContent(
                  label: "contents " * 12,
                  fontsize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({
    Key? key,
    required this.label,
    required this.fontsize,
    required this.fontWeight,
  }) : super(key: key);
  final String label;
  final double fontsize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return SelectableText(label,
        textAlign: TextAlign.justify,
        style: GoogleFonts.roboto(fontSize: fontsize, fontWeight: fontWeight));
  }
}
