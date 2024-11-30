import 'package:flutter/material.dart';
import 'package:newa_app_mainproject/controller/home_screen_controller.dart';
import 'package:newa_app_mainproject/view/home_screen/widgets/breaking_news_card.dart';
import 'package:newa_app_mainproject/view/news_details_screen/news_details_screen.dart';

import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List catlist = [
    "general",
    "business",
    "sports",
    "entertainment",
    "science",
    "technology"
  ];

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<NewsScreenController>();
      controller.getData();
      controller.getcatdata(catlist[selectedCategoryIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Today News",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [Icon(Icons.notifications)],
      ),
      body: Consumer<NewsScreenController>(
        builder: (context, controller, child) {
          if (controller.isLoading && controller.isCategoryLoading == false) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: "Search for news",
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        suffixIcon: Icon(
                          Icons.mic,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Breaking News",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  BreakingnewsSection(controller),
                  SizedBox(height: 20),
                  categorylistrowsection(controller),
                  SizedBox(height: 20),
                  categorynewssection(controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox BreakingnewsSection(NewsScreenController controller) {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.latestNewsList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Newsdetailsscreen(
                    image:
                        controller.latestNewsList[index].urlToImage.toString(),
                    author: controller.latestNewsList[index].author.toString(),
                    title: controller.latestNewsList[index].title.toString(),
                    des: controller.latestNewsList[index].content.toString(),
                    time:
                        controller.latestNewsList[index].publishedAt.toString(),
                  ),
                ));
          },
          child: breakingNews(
            author: controller.latestNewsList[index].author.toString(),
            image: controller.latestNewsList[index].urlToImage.toString(),
            title: controller.latestNewsList[index].title.toString(),
            description:
                controller.latestNewsList[index].description.toString(),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  SingleChildScrollView categorylistrowsection(
      NewsScreenController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          catlist.length,
          (index) => InkWell(
            onTap: () {
              setState(() {
                selectedCategoryIndex = index;
              });
              controller.getcatdata(catlist[index]);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selectedCategoryIndex == index
                    ? Colors.grey
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                catlist[index],
                style: TextStyle(
                  color: selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox categorynewssection(NewsScreenController controller) {
    return SizedBox(
      child: controller.isCategoryLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.categoryNewsList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Newsdetailsscreen(
                          image: controller.categoryNewsList[index].urlToImage
                              .toString(),
                          author: controller.categoryNewsList[index].author
                              .toString(),
                          title: controller.categoryNewsList[index].title
                              .toString(),
                          des: controller.categoryNewsList[index].content
                              .toString(),
                          time: controller.categoryNewsList[index].publishedAt
                              .toString(),
                        ),
                      ));
                },
                child: breakingNews(
                  author: controller.categoryNewsList[index].author.toString(),
                  title: controller.categoryNewsList[index].title.toString(),
                  description:
                      controller.categoryNewsList[index].description.toString(),
                  image:
                      controller.categoryNewsList[index].urlToImage.toString(),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
    );
  }
}
