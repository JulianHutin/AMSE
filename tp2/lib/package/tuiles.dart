import 'package:flutter/material.dart';

class ImageTile {
  int id;
  String? imageUrl;
  double? factor;
  Alignment? alignment;
  bool empty;

  ImageTile({
    required this.id,
    this.imageUrl,
    this.factor,
    this.alignment,
    required this.empty,
  });

  Widget croppedImageTile() {
    if (!empty) {
      return FittedBox(
        fit: BoxFit.fill,
        child: ClipRect(
          child: Align(
            alignment: alignment!,
            widthFactor: factor,
            heightFactor: factor,
            child: Image.asset(imageUrl!),
          ),
        ),
      );
    } else {
      return FittedBox(
        fit: BoxFit.fill,
        child: Container(color: Colors.white),
      );
    }
  }
}
class ImageTilePlus {
  List<ImageTile> _tilesList = [];
  int _nbColumns = 3;
  String _imageUrl = 'images/exo4.jpg';

  /// CONSTRUCTOR
  ImageTilePlus() {
    _splitImageIntoTiles();
  }

  /// GETTERS AND SETTERS
  List<ImageTile> getTilesList() {
    return _tilesList;
  }

  void setTilesList(List<ImageTile> list) {
    _tilesList = list;
  }

  int getNbColumns() {
    return _nbColumns;
  }

  void setNbColumns(int nbOfColumns) {
    _nbColumns = nbOfColumns;
    _splitImageIntoTiles();
  }

  String getImageUrl() {
    return _imageUrl;
  }

  void setImageUrl(String newImageUrl) {
    _imageUrl = newImageUrl;
    _splitImageIntoTiles();
  }

  /// GAME RULES
  List<double> _computeIndexes() {
    List<double> result = [];
    double temp = 0;

    for (int i = 0; i < _nbColumns; i++) {
      temp = ((2 * i) / (_nbColumns - 1)) - 1;
      result.add(temp);
    }
    return result;
  }

  void _splitImageIntoTiles() {
    List<double> indexes = _computeIndexes();
    _tilesList = [];
    int id = 0;

    for (var y in indexes) {
      for (var x in indexes) {
        _tilesList.add(
          ImageTile(
            id: id,
            factor: 1 / _nbColumns,
            alignment: Alignment(x, y),
            imageUrl: _imageUrl,
            empty: false,
          ),
        );
        id++;
      }
    }
  }
}