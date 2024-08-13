import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/widgets/custom_card_thumbnail.dart';

class NowPlayingList extends StatefulWidget {
  final List<Movie> movies;
  const NowPlayingList({super.key, required this.movies});

  @override
  State<NowPlayingList> createState() => _NowPlayingListState();
}

class _NowPlayingListState extends State<NowPlayingList> {
  PageController pageController = PageController(viewportFraction: 0.7);
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
currentPage = pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: PageView.builder(
              controller: pageController,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                return CustomCardThumbnail(
                    imageAsset: widget.movies[index].backdropPath);
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicators(),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicators() {
    return List<Widget>.generate(widget.movies.length, (index) {
      return _buildIndicator(index == currentPage);
    });
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
