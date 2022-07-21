// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:libreria_de_peliculas/models/models.dart';
import 'package:libreria_de_peliculas/widgets/widget.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body : CustomScrollView(
        physics: BouncingScrollPhysics( parent:  AlwaysScrollableScrollPhysics()),
        slivers: [
          _CustomAppBar(movie),

          SliverList(
            delegate: SliverChildListDelegate(
              [ 
                PosterTitle(movie),
                _OverView(movie),
                _OverView(movie),
                _OverView(movie),
                CastingCard( movie.id),
              ]
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

final Movie movie;

  const _CustomAppBar(this.movie);
  
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(0),
        background: FadeInImage(
          placeholder: AssetImage("assets/images/jar-loading.gif"), 
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only( bottom: 10, right: 10, left: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(movie.title, style: TextStyle( fontSize: 16),textAlign: TextAlign.center, ),
        ),
      ),
    );
  }
}

class PosterTitle extends StatelessWidget {
  
  final Movie movie;

  const PosterTitle(this.movie);


  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          //TODO: verificar null aqui  
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                 placeholder: AssetImage("assets/images/jar-loading.gif"), 
                 image: NetworkImage(movie.fullPosterImg),
                 height: 150,
                 width: 110,
              ),
            ),
          ),

          SizedBox( width: 20),

          
           ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 180 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Row(
                  children: [
          
                    Icon(Icons.star_outlined, size: 15, color: Colors.grey),
          
                    SizedBox( width: 5),
                    
                    Text('${movie.voteAverage}', style: Theme.of(context).textTheme.caption, overflow: TextOverflow.ellipsis,maxLines: 2),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {

  final Movie movie;

  const _OverView(this.movie);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 30, vertical: 10),
      child: Text( movie.overview,
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.justify,
      ),
    );
  }
}