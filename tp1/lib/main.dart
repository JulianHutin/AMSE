import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
  MediaModel(
    name: 'Inception',
    autor: 'Christopher Nolan',
    date: '2010',
    description:
        'Inception is a 2010 science fiction action film written and directed by Christopher Nolan.',
    imgUrl: 'assets/imgs/inception.jpg',
  ),
  MediaModel(
    name: 'The Shawshank Redemption',
    autor: 'Frank Darabont',
    date: '1994',
    description:
        'The Shawshank Redemption is a 1994 American drama film written and directed by Frank Darabont.',
    imgUrl: 'assets/imgs/shawshank_redemption.jpg',
  ),
  MediaModel(
    name: 'The Godfather',
    autor: 'Francis Ford Coppola',
    date: '1972',
    description:
        'The Godfather is a 1972 American crime film directed by Francis Ford Coppola.',
    imgUrl: 'assets/imgs/godfather.jpg',
  ),
  MediaModel(
    name: 'Pulp Fiction',
    autor: 'Quentin Tarantino',
    date: '1994',
    description:
        'Pulp Fiction is a 1994 American neo-noir black comedy crime film written and directed by Quentin Tarantino.',
    imgUrl: 'assets/imgs/pulp_fiction.jpg',
  ),
];

const series = [
  MediaModel(
    name: 'Breaking Bad',
    autor: 'Vince Gilligan',
    date: '2008-2013',
    description:
        'Breaking Bad is an American neo-Western crime drama television series created and produced by Vince Gilligan.',
    imgUrl: 'assets/imgs/breaking_bad.jpg',
  ),
  MediaModel(
    name: 'Game of Thrones',
    autor: 'David Benioff, D. B. Weiss',
    date: '2011-2019',
    description:
        'Game of Thrones is an American fantasy drama television series created by David Benioff and D. B. Weiss.',
    imgUrl: 'assets/imgs/game_of_thrones.jpg',
  ),
  MediaModel(
    name: 'Stranger Things',
    autor: 'The Duffer Brothers',
    date: '2016-present',
    description:
        'Stranger Things is an American science fiction horror mystery-thriller streaming television series created by the Duffer Brothers.',
    imgUrl: 'assets/imgs/stranger_things.jpg',
  ),
  MediaModel(
    name: 'Friends',
    autor: 'David Crane, Marta Kauffman',
    date: '1994-2004',
    description:
        'Friends is an American television sitcom created by David Crane and Marta Kauffman.',
    imgUrl: 'assets/imgs/friends.jpg',
  ),
];

const musique = [
  MediaModel(
    name: 'Thriller',
    autor: 'Michael Jackson',
    date: '1982',
    description:
        'Thriller is the sixth studio album by American singer Michael Jackson, released on November 30, 1982.',
    imgUrl: 'assets/imgs/thriller.jpg',
  ),
  MediaModel(
    name: 'Abbey Road',
    autor: 'The Beatles',
    date: '1969',
    description:
        'Abbey Road is the eleventh studio album by the English rock band the Beatles, released on 26 September 1969.',
    imgUrl: 'assets/imgs/abbey_road.jpg',
  ),
  MediaModel(
    name: 'The Dark Side of the Moon',
    autor: 'Pink Floyd',
    date: '1973',
    description:
        'The Dark Side of the Moon is the eighth studio album by the English rock band Pink Floyd.',
    imgUrl: 'assets/imgs/dark_side_of_the_moon.jpg',
  ),
  MediaModel(
    name: 'Back in Black',
    autor: 'AC/DC',
    date: '1980',
    description:
        'Back in Black is the seventh studio album by Australian rock band AC/DC.',
    imgUrl: 'assets/imgs/back_in_black.jpg',
  ),
];

const livre = [
  MediaModel(
    name: '1984',
    autor: 'George Orwell',
    date: '1949',
    description:
        '1984 is a dystopian social science fiction novel by English novelist George Orwell.',
    imgUrl: 'assets/imgs/1984.jpg',
  ),
  MediaModel(
    name: 'To Kill a Mockingbird',
    autor: 'Harper Lee',
    date: '1960',
    description:
        'To Kill a Mockingbird is a novel by Harper Lee published in 1960.',
    imgUrl: 'assets/imgs/to_kill_a_mockingbird.jpg',
  ),
  MediaModel(
    name: 'The Great Gatsby',
    autor: 'F. Scott Fitzgerald',
    date: '1925',
    description:
        'The Great Gatsby is a 1925 novel by American writer F. Scott Fitzgerald.',
    imgUrl: 'assets/imgs/great_gatsby.jpg',
  ),
  MediaModel(
    name: 'The Catcher in the Rye',
    autor: 'J. D. Salinger',
    date: '1951',
    description:
        'The Catcher in the Rye is a novel by J. D. Salinger, partially published in serial form in 1945–1946 and as a novel in 1951.',
    imgUrl: 'assets/imgs/catcher_in_the_rye.jpg',
  ),
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
          MediaButton('Films',film),
          MediaButton('Series',series),
          MediaButton('Musique', musique),
          MediaButton('Livre', livre),
        ],
      ),
    );
  }
}

class MediaButton extends StatelessWidget {
  final String media;
  final List<MediaModel> mediaList;

  MediaButton(this.media, this.mediaList);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaList(media,mediaList),
          ),
        );
      },
      child: Text(media),
    );
  }
}


class MediaList extends StatelessWidget {
  final String mediatype;
  final List<MediaModel> mediaList;

  MediaList(this.mediatype, this.mediaList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mediatype),
      ),
      body: ListView(
        children: [
          for (var i=0; i<mediaList.length; i++)
            MediaListButton(mediaList[i].name,i),
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