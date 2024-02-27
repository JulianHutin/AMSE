import 'package:flutter/material.dart';
import 'package:tp2/package/tuiles.dart';

class Exercice5Screen extends StatefulWidget {
  const Exercice5Screen({Key? key}) : super(key: key);

  @override
  State<Exercice5Screen> createState() => _Exercice5ScreenState();
}

class _Exercice5ScreenState extends State<Exercice5Screen> {
  double nbElements = 5;

  @override
  Widget build(BuildContext context) {
    List<double> computeIndexes() {
      List<double> result = [];
      double temp = 0;

      for (int i = 0; i < nbElements; i++) {
        temp = ((2 * i) / (nbElements - 1)) - 1;
        result.add(temp);
      }
      return result;
    }

    List<ImageTile> splitImageIntoTiles(String imageUrl) {
      List<ImageTile> list = [];
      List<double> indexes = computeIndexes();

      for (var y in indexes) {
        for (var x in indexes) {
          list.add(
            ImageTile(
              id:0,
              factor: 1 / nbElements,
              alignment: Alignment(x, y),
              imageUrl: imageUrl,
              empty:false,
            ),
          );
        }
      }

      return list;
    }

    List<ImageTile> tiles = splitImageIntoTiles('images/exo4.jpg');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Grille d'images"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: (nbElements * nbElements).toInt(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: nbElements.toInt(),
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(1.0),
                  child: tiles[index].croppedImageTile(),
                );
              },
            ),
          ),
          Slider(
            value: nbElements,
            onChanged: (newNbElements) =>
                setState(() => nbElements = newNbElements),
            min: 2,
            divisions: 6,
            max: 8,
            label: nbElements.round().toString(),
          )
        ],
      ),
    );
  }
}
