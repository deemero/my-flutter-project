import 'package:flutter/material.dart';

import '../model/res_get_news.dart';

class DetailNews extends StatelessWidget {
  final Data data;
  const DetailNews({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail News"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        // SingleChildScrollView to make any Widget scrollable
        child: SingleChildScrollView(
          child: Column(
            children: [
              // hero widget used for transition
              Hero(
                  tag: data.picture.toString(),
                  child: Image.network(data.picture.toString())),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${data.title}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Publish date: ${data.dateNews}",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "${data.description}",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(height: 1.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
