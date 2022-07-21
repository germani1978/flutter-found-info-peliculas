
import 'package:flutter/material.dart';
import 'package:libreria_de_peliculas/models/models.dart';
import 'package:libreria_de_peliculas/provider/movies_provider.dart';
import 'package:provider/provider.dart';

class MoviesSearchDelegate extends SearchDelegate {

  @override
  String? get searchFieldLabel => 'Buscar pelicula';


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [ 
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear)
      ),
    ];
  }


  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
            onPressed: () => close(context, null), 
            icon: Icon(Icons.arrow_back)
      );
  }


  @override
  Widget buildResults(BuildContext context) {
    return Text('Results');
  }


  Widget _EmptyContainer() =>  Container(
        child:  const Center(child: Icon(Icons.movie_creation_outlined, size: 130, color: Colors.black38,)),
  );


  @override
  Widget buildSuggestions(BuildContext context) {

    if (query.isEmpty) return _EmptyContainer();
    final moviesProvider = Provider.of<MoviesProvider>(context , listen: false);
    moviesProvider.getSuggestionByQuery(query);

    return StreamBuilder(
      stream : moviesProvider.suggestionStream,
      builder: (_ , AsyncSnapshot<List<Movie>> snapshot) {

        if (!snapshot.hasData) () => _EmptyContainer(); 
        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return MovieItem(movies[index]);
          },
        );        
      },
    );
  }
}

class MovieItem extends StatelessWidget {

  final Movie movie;

  const MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${ movie.id }';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage("assets/images/no-image.png"), 
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.pushNamed(context,'details', arguments: movie ),
    );
  }
}