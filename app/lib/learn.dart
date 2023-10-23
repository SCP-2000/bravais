import 'package:flutter/material.dart';
import 'dart:html' as html;

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  });

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Expanded(
          child: Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ),
        Text(
          author,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
          ),
        ),
        Text(
          '$publishDate - $readDuration',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListItemExample extends StatelessWidget {
  const CustomListItemExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          InkWell(
            child: CustomListItemTwo(
              thumbnail: Container(
                decoration: const BoxDecoration(color: Colors.pink),
              ),
              title: 'ASD is more common than you think',
              subtitle: 'One in 36 (2.8%) 8-year-old children have been identified with autism spectrum disorder (ASD), according to an analysis published today in CDC’s Morbidity and Mortality Weekly Report (MMWR).',
              author: 'CDC',
              publishDate: 'Mar 23',
              readDuration: '5 mins',
            ),
            onTap: () => html.window.open('https://www.cdc.gov/media/releases/2023/p0323-autism.html', 'new tab')
          ),
          InkWell(
            child: CustomListItemTwo(
              thumbnail: Container(
                decoration: const BoxDecoration(color: Colors.blue),
              ),
              title: 'ASD is hard to diagnose',
              subtitle: 'Diagnosing autism spectrum disorder (ASD) can be difficult since there are no medical tests to diagnose it, and it’s exhibited as a spectrum of closely related symptoms.',
              author: 'Virtua Health',
              publishDate: 'Jan 14',
              readDuration: '3 mins',
            ),
            onTap: () => html.window.open('https://www.virtua.org/articles/why-autism-spectrum-disorder-is-so-hard-to-diagnose', 'new tab')
          )
        ],
      ),
    );
  }
}

