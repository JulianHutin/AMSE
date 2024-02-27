import 'package:flutter/material.dart';
import 'package:tp2/package/tuiles.dart';

ImageTile tile = ImageTile(
  id:0,
  factor: 0.3,
  alignment: const Alignment(0, 0),
  imageUrl: 'images/exo4.jpg',
  empty: false,
);

class Exercice4 extends StatelessWidget {
  const Exercice4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Exercice 4"),
      ),
      body: Center(
          child: Column(children: [
        SizedBox(
            width: 150.0,
            height: 150.0,
            child: Container(
                margin: const EdgeInsets.all(20.0),
                child: createTileWidgetFrom(tile))),
        SizedBox(
            height: 200,
            child: Image.asset('images/exo4.jpg', fit: BoxFit.cover))
      ])),
    );
  }

  Widget createTileWidgetFrom(ImageTile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}