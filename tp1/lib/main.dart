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
    imgUrl: 'assets/imgs/inception.png',
  ),
  MediaModel(
    name: 'The Shawshank Redemption',
    autor: 'Frank Darabont',
    date: '1994',
    description:
        'The Shawshank Redemption is a 1994 American drama film written and directed by Frank Darabont.',
    imgUrl: 'assets/imgs/shawshank.jpg',
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
    imgUrl: 'assets/imgs/abey_road.png',
  ),
  MediaModel(
    name: 'The Dark Side of the Moon',
    autor: 'Pink Floyd',
    date: '1973',
    description:
        'The Dark Side of the Moon is the eighth studio album by the English rock band Pink Floyd.',
    imgUrl: 'assets/imgs/dark_side_of_the_moon.png',
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
    imgUrl: 'assets/imgs/the_great_gatsby.jpg',
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
        home: Scaffold(
          bottomNavigationBar: const MyBottomNavigationBar(),
        ),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = PresentationPage();
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

    return Scaffold(
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Media',
          ),
        ],
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {

  final List<MediaModel> favorites = [];

  void addFavorite(current) {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class PresentationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue !',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Cette application vous permet de découvrir et de gérer vos médias préférés.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, 
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/imgs/med.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(75),
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
            ),
            SizedBox(height: 16),
            ParcourirButton(),
          ],
        ),
      ),
    );
  }
}


class ParcourirButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaPage(),
          ),
        );
      },
      child: Text('Parcourir'),
    );
  }
}


class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Consumer<MyAppState>(
        builder: (context, appState, _) {
          if (appState.favorites.isEmpty) {
            return Center(
              child: Text('No favorites yet.'),
            );
          }

          return ListView.builder(
            itemCount: appState.favorites.length,
            itemBuilder: (context, index) {
              return MediaListButton(appState.favorites, index);
            },
          );
        },
      ),
    );
  }
}



class MediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          MediaCategoryCard('Films', film),
          SizedBox(height: 16),
          MediaCategoryCard('Series', series),
          SizedBox(height: 16),
          MediaCategoryCard('Musique', musique),
          SizedBox(height: 16),
          MediaCategoryCard('Livre', livre),
        ],
      ),
    );
  }
}

class MediaCategoryCard extends StatelessWidget {
  final String categoryName;
  final List<MediaModel> mediaList;

  MediaCategoryCard(this.categoryName, this.mediaList);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MediaList(categoryName, mediaList),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: mediaList.length > 4 ? 4 : mediaList.length,
                itemBuilder: (context, index) {
                  return MediaCard(mediaList[index]);
                },
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MediaList(categoryName, mediaList),
                      ),
                    );
                  },
                  child: Text('Voir tout >'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MediaCard extends StatelessWidget {
  final MediaModel media;

  MediaCard(this.media);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                media.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              media.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
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
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < mediaList.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MediaListButton(mediaList, i),
            ),
        ],
      ),
    );
  }
}


class MediaListButton extends StatelessWidget {
  final List<MediaModel> mediaList;
  final int indice;

  MediaListButton(this.mediaList, this.indice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MediaDescriptionPage(mediaList, indice),
            ),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Image.network(mediaList[indice].imgUrl),
            ),
            SizedBox(width: 10),
            Text(mediaList[indice].name),
          ],
        ),
      ),
    );
  }
}

class MediaDescriptionPage extends StatelessWidget {
  final List<MediaModel> mediaList;
  final int indice;

  MediaDescriptionPage(this.mediaList, this.indice);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    IconData icon;
    if (appState.favorites.contains(mediaList[indice])) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mediaList[indice].name,
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      mediaList[indice].imgUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Date : ${mediaList[indice].date}',
                  style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 16),
                Text(
                  'Auteur : ${mediaList[indice].autor}',
                  style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 16),
                Text(
                  'Description : ${mediaList[indice].description}',
                  style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    appState.addFavorite(mediaList[indice]);
                  },
                  icon: Icon(icon),
                  label: Text('Like', style: TextStyle(fontFamily: 'Montserrat')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

