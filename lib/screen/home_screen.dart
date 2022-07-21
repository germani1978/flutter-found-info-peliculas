// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:libreria_de_peliculas/provider/movies_provider.dart';
import 'package:libreria_de_peliculas/search/search_delegate.dart';
import 'package:libreria_de_peliculas/widgets/widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas de cines'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: MoviesSearchDelegate());
            },
          ),
          SizedBox(width: 10,)
        ],
      ),
      body : SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 20,),


            CardSwiper( movies : moviesProvider.onDisplayMovie ),

            SizedBox(height: 20,),

            MovieSlider(  movies : moviesProvider.popularMovie , title: 'Populares', onNextPage:() => moviesProvider.getPopularMovies() ),
            
          ],
        ),
      ),
    );
  }
}