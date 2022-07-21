
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:libreria_de_peliculas/helpers/debounder.dart';
import 'package:libreria_de_peliculas/models/models.dart';
import 'package:libreria_de_peliculas/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {

  final  _baseUrl = 'api.themoviedb.org';
  final  _apiKey = '27af57a1a8237b52a74022d3411f903d';
  final  _language = 'es-ES';
  
  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovie = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration( milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast(); 
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;


  MoviesProvider() {

    getOnProviderMovies();

    getPopularMovies();
  }

   Future<String> _getJson(String endPoint, [int page = 1] ) async{

    try {

     final url = Uri.parse('https://$_baseUrl/$endPoint?api_key=$_apiKey&language=$_language&page=$page');
     final response = await http.get(url);
     return response.body; 

    } catch (e) {

      print(e);
      return '';

    }

   }

  getOnProviderMovies() async {

    try {
      
    final response = await _getJson('3/movie/now_playing'); 
    final nowPlayingResponse = NowPlayingResponse.fromJson( response );
    if (nowPlayingResponse == '')  return '';
    onDisplayMovie = nowPlayingResponse.results;
    notifyListeners();

     } catch (e) {
      print(e);
    }

  }
  
  getPopularMovies() async {

   try {
   
    _popularPage++;
    final response =  await _getJson('3/movie/popular', _popularPage);
    final popularResponse = PopularMovie.fromJson( response );
    popularMovie = [...popularMovie, ...popularResponse.results];
    notifyListeners();

    } catch (e) {
     print(e);
   }

  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    try {

      if ( moviesCast.containsKey(movieId)  ) return  moviesCast[movieId]!;

      final response =  await _getJson('3/movie/$movieId/credits' );
      final creditsResponse = CreditsResponse.fromJson(response);
      moviesCast[movieId] = creditsResponse.cast;
      return creditsResponse.cast;

    }
    catch (e) {

      print(e);
      return [];

    }

  }

  Future<List<Movie>> searchMovie(String query) async {

    try {

     final url = Uri.parse('https://$_baseUrl/3/search/movie/?api_key=$_apiKey&language=$_language&query=$query');
     final response = await http.get(url);
     final searchResponse = SearchResponse.fromJson(response.body);  
     return searchResponse.results; 
    }
    catch (e) {

      print(e);
      return [];
    }
  }

  void getSuggestionByQuery( String searchTerm) {

    debouncer.value = '';

    debouncer.onValue = ( (value) async {
      final results = await searchMovie(value);
      _suggestionStreamController.add( results );
      print('llamo');
    });

    final timer = Timer.periodic( Duration(milliseconds: 300), (value) {
      debouncer.value = searchTerm;
    });

    Future.delayed( Duration(milliseconds: 301)).then(( _ ) => timer.cancel());
      
}



}