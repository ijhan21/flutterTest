import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie>? movies;

  CarouselImage({this.movies});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  List<Movie>? movies;
  List<Widget>? images;
  List<String>? keywords;
  List<bool>? likes;
  int _currentPage = 0;
  late String _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies!.map((e) => Image.asset('./images/' + e.poster)).toList();
    keywords = movies!.map((e) => e.keyword).toList();
    likes = movies!.map((e) => e.like).toList();
    _currentKeyword = keywords![0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
          ),
          Container(
            child: Text(_currentKeyword),
          )
        ],
      ),
    );
  }
}
