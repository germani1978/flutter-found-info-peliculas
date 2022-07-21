import 'package:flutter/material.dart';
import 'package:libreria_de_peliculas/provider/movies_provider.dart';
import 'package:libreria_de_peliculas/screen/screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MoviesProvider(), lazy: false,)
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home':(context) => const HomeScreen(),
        'details':(context) => const DetailScreen(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.indigo,
        )
      ),
    );
  }
}