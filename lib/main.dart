import 'package:flutter/material.dart';
import 'package:movieapp/utils/text.dart';
import 'package:movieapp/widgets/toprated.dart';
import 'package:movieapp/widgets/trending.dart';
import 'package:movieapp/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main()=>runApp(new MyApp());

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark,
        primaryColor: Colors.green),

      );
    }
  }
  class Home extends StatefulWidget {
    const Home({Key? key}) : super(key: key);
  
    @override
    State<Home> createState() => _HomeState();
  }
  
  class _HomeState extends State<Home> {
    List trendingmovies = [];
    List topratedmovies = [];
    List tv = [];
    final String apikey = '746896ecf94e873903aa47e53113a615';
    final readaccestoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NDY4OTZlY2Y5NGU4NzM5MDNhYTQ3ZTUzMTEzYTYxNSIsInN1YiI6IjY0NDk0MjI1NDk3NTYwMDRlNmRmNWI3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CDCe7B5Z8Tm9fJ_iFBrxgkKq9GarPiNQXbgd4jQq07s';

    @override
    void initState() {
      loadmovies();
      super.initState();
    }


    loadmovies()async{
TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccestoken),
logConfig: ConfigLogger(
  showLogs: true,
  showErrorLogs: true,
));
Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();
setState(() {
  trendingmovies = trendingresult['results'];
  topratedmovies = topratedresult['results'];
  tv = tvresult['results'];
});

print(tv);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: modified_text(text: 'Flutter Movie App ❤️'),),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search')
        ],),
        body: ListView(
          children: [
            TV(tv: tv,),
            TopRated(toprated: topratedmovies,),
            TrendingMovies(trending: trendingmovies)
          ],
        ),
      );
    }
  }
  

