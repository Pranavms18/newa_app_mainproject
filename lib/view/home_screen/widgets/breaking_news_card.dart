import 'package:flutter/material.dart';

class breakingNews extends StatelessWidget {
  String image;
  String title;
  String description;
  String author;
  breakingNews(
      {super.key,
      required this.image,
      required this.description,
      required this.author,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 320,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "By $author",
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          SizedBox(height: 70),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
