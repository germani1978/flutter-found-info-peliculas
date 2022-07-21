
// To parse this JSON data, do
//
//     final popularMovie = popularMovieFromMap(jsonString);

import 'dart:convert';

import 'package:libreria_de_peliculas/models/movie.dart';

class PopularMovie {
    PopularMovie({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory PopularMovie.fromJson(String str) => PopularMovie.fromMap(json.decode(str));


    factory PopularMovie.fromMap(Map<String, dynamic> json) => PopularMovie(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}
