import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewsDetail extends StatefulWidget {
  String title, description, image, author, date;
  NewsDetail(
      {Key? key,
      required this.title,
      required this.description,
      required this.image,
      required this.author,
      required this.date})
      : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  String category = "Technology";
  String title = "";
  String imageUrl = "";
  String author = "";
  String date = "";
  String description = "";
  String error = "Not Known";

  void getData() {
    setState(() {
      title = widget.title;
      imageUrl = widget.image;
      author = widget.author;
      date = widget.date.substring(0, 10);
      description = widget.description;
    });

    if (author == "null") {
      setState(() {
        author = error;
      });
    }

    if (title == "null") {
      setState(() {
        title = error;
      });
    }

    if (date == "null") {
      setState(() {
        date = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: imageUrl == "null"
                    ? Image.asset(
                        "assets/default.jpg",
                        fit: BoxFit.cover,
                        width: size.width / 1.15,
                        height: size.height / 3,
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        height: size.height / 3,
                        width: size.width / 1.15,
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    "Author: ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  const Text(
                    "Date:  ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              description == "null"
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
