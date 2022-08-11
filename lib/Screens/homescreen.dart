import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutternewsapp/Screens/newsdetail.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List articles = [];
  int length = 0;

  Future<void> getdata() async {
    Response response = await get(Uri.parse(
        'http://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=61e6eabc3acc4791a905c8e55b240f8b'));
    Map data = await jsonDecode(response.body);

    setState(() {
      articles = data['articles'];
      // print("map is \n");
      // print(data);
      length = data['totalResults'];
    });

    // print(length);
  }

  @override
  void initState() {
    getdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(data);
    // print(articles.length);
    final size = MediaQuery.of(context).size;
    const String category = "Technology";
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home page"),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 54, 54),
        body: Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: length == 0
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    // itemCount: snapshot.data?.docs.length,

                    itemCount: articles.length,
                    // itemCount: 2,
                    itemBuilder: (context, index) {
                      // var time = (doc![index]['timestamp'] as Timestamp).toDate();
                      String title = articles[index]['title'].toString();

                      if (title.length > 65) {
                        title = "${title.substring(0, 66)}...more";
                      }

                      String description =
                          articles[index]['description'].toString();
                      String author = articles[index]['author'].toString();

                      String imageUrl =
                          articles[index]['urlToImage'].toString();

                      String publishedDate =
                          articles[index]['publishedAt'].toString();

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetail(
                                      title: title,
                                      description: description,
                                      image: imageUrl,
                                      author: author,
                                      date: publishedDate)));

                          // Fluttertoast.showToast(msg: "clicked");
                          // print("clicked");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          height: size.height / 5.5,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),

                                  // height: size.height,
                                  child: imageUrl == "null"
                                      ? Image.asset(
                                          "assets/default.jpg",
                                          fit: BoxFit.cover,
                                          width: size.width / 2.9,
                                          height: size.height / 6.1,
                                        )
                                      : Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          width: size.width / 2.9,
                                          height: size.height / 6.1,
                                        ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 15, right: 10),
                                width: size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      category,
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )));
  }
}
