import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_news_app/api.dart';
import 'package:my_news_app/menu/detail_news.dart';
import 'package:my_news_app/model/res_get_news.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool isLoading = false;
  List<Data> listNews = [];

  // function for get news from api
  Future<ResGetNews?> getNews() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse("$apiUrl/getNews.php"));
      List<Data>? data = resGetNewsFromJson(res.body).data;
      setState(() {
        isLoading = false;
        listNews = data ?? [];
        log('data news: $listNews');
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      });
    }
    return null;
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout_rounded))
        ],
        title: const Text("News"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: const Text(
              "Popular News",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          CarouselSlider(
            // the e character here is for describe the Data
            items: listNews.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(e.picture.toString()),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        e.title.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            backgroundColor: Colors.black.withOpacity(0.5)),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
            options: CarouselOptions(
                autoPlay: true, height: 200, enlargeCenterPage: true),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: const Text(
              "Hot News",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: ListView.builder(
                  itemCount: listNews.length,
                  itemBuilder: (context, index) {
                    // store the listnews data into variabel to make it easier to access
                    Data data = listNews[index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailNews(data: data),
                            ),
                          );
                        },
                        title: Text(
                          data.title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        subtitle: Text(data.dateNews.toString()),
                        // hero widget used for transition
                        leading: Hero(
                          tag: data.picture.toString(),
                          child: Image.network(
                            data.picture.toString(),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
