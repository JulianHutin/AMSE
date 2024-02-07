import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';

void main() {
   final jsonString = File('chemin_vers_votre_fichier.json').readAsStringSync();

  // Parser le contenu JSON
  final jsonData = json.decode(jsonString);

  // Extraire les données des films du JSON
  final List<dynamic> filmsData = jsonData['films'];

  // Créer une liste de MediaModel à partir des données des films
  final List<MediaModel> films = filmsData.map((film) {
    return MediaModel(
      name: film['titre'],
      autor: film['auteur'],
      date: film['date_sortie'],
      description: film['synopsis'],
      imgUrl: '', // Vous devez définir l'URL de l'image correcte ici
    );
  }).toList();
  
  runApp(MyApp());
}

class MediaModel {
  final String name;
  final String autor;
  final String date;
  final String description;
  final String imgUrl;

  const MediaModel(
    {required this.name, required this.autor, required this.date, required this.description,required this.imgUrl}
  );
}

const film = [
  MediaModel(name: 'OSS117', autor: 'autor', date: 'date', description: 'description', imgUrl: 'assets/imgs/OSS.jpg'),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2 :
        page = MediaPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.movie),
                    label: Text('Media'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.movie),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}

class MediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          MediaButton('Films'),
          MediaButton('Series'),
          MediaButton('Musique'),
          MediaButton('Livre'),
        ],
      ),
    );
  }
}

class MediaButton extends StatelessWidget {
  final String media;

  MediaButton(this.media);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaList(media),
          ),
        );
      },
      child: Text(media),
    );
  }
}


class MediaList extends StatelessWidget {
  final String mediatype;

  MediaList(this.mediatype);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mediatype),
      ),
      body: ListView(
        children: [
          for (var i=0; i<film.length; i++)
            MediaListButton(film.elementAt(i).name,i),
        ],
      ),
    );
  }
}

class MediaListButton extends StatelessWidget {
  final String medianame;
  final int indice;

  MediaListButton(this.medianame,this.indice);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaDescriptionPage(medianame,indice),
          ),
        );
      },
      child: Text(medianame),
    );
  }
}

class MediaDescriptionPage extends StatelessWidget {
  final String medianame;
  final int indice;

  MediaDescriptionPage(this.medianame, this.indice);

  @override
  Widget build(BuildContext context) {
    // Obtenez le chemin d'accès de l'image à partir du modèle MediaModel

    return Scaffold(
      appBar: AppBar(
        title: Text(medianame),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Affichez l'image à partir du fichier
            Image.network(film.elementAt(indice).imgUrl),
            Text('Date : ${film.elementAt(indice).date}'),
            Text('Auteur : ${film.elementAt(indice).autor}'),
            Text('Description : ${film.elementAt(indice).description}'),
          ],
        ),
      ),
    );
  }
}