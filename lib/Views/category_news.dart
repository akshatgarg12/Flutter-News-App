import 'package:flutter/material.dart';
import 'package:newz/helper/news.dart';
import 'package:newz/models/article_model.dart';
import 'article_view.dart';

// ignore: must_be_immutable
class CategoryNews extends StatefulWidget {
  String category;
  CategoryNews({@required this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  bool _isLoading = true;
  List<ArticleModel> news = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async {
    CategoryBasedNews newsClass = CategoryBasedNews();
    await newsClass.getCategoryNews(widget.category);
    news = newsClass.news;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              'Zz',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 33.0,
            )
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    /// articles
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: news.length,
                          itemBuilder: (context, index) {
                            return BlogTitle(
                              title: news[index].title,
                              description: news[index].description,
                              imgUrl: news[index].urlToImage,
                              url: news[index].url,
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class BlogTitle extends StatelessWidget {
  final String imgUrl, title, description, url;
  BlogTitle({this.title, this.description, this.imgUrl, this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      url: url,
                    )));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 200.0,
              width: double.maxFinite,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(description,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0)),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
