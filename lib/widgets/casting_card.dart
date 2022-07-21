
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:libreria_de_peliculas/models/models.dart';
import 'package:libreria_de_peliculas/models/models.dart';
import 'package:libreria_de_peliculas/provider/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {

  final int movieId;

  const CastingCard(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {

          if (!snapshot.hasData) {
            return Container(
              height: 190,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final List<Cast> casts = snapshot.data!;

          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 190,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => _CastCard( casts[index]),
            ),
          );

        });
  }
}

class _CastCard extends StatelessWidget {

  final Cast cast;
  const _CastCard( this.cast );


  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
            placeholder: AssetImage("assets/images/jar-loading.gif"), 
            image: NetworkImage("${cast.fullprofilePath}"),
            height: 140,
            width: 100,
            fit: BoxFit.cover,
           ),
          ),

          SizedBox(height: 5),

          Text(
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,

          ),
        ],
      ),
    );
  }
}