// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:libreria_de_peliculas/models/movie.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({required this.movies, this.title, required this.onNextPage});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final scrollController = ScrollController();

  @override
  void initState() {
    
    scrollController.addListener(() { 

      if ( scrollController.position.pixels >=  scrollController.position.maxScrollExtent  - 500) {
        widget.onNextPage();
      }

    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if (widget.title != null)  
           Padding(
             padding: const EdgeInsets.symmetric( horizontal: 20 ),
             child: Text( widget.title! , style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold )),
           ),

           Expanded(
             child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) { 
                final movie = widget.movies[index];
                return _MoviePoster(movie: movie, heroId: '${ widget.title }-$index-${ widget.movies[index].id }') ;
              }
             ),
           )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final String heroId;

  const _MoviePoster({required this.movie, required this.heroId});

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [

          Hero(
            tag: movie.heroId!,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage("assets/images/jar-loading.gif"), 
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 5,), 

          Text( movie.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

        ],
      ),
    );
  }
}