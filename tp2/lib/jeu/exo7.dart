import 'dart:async';
import 'dart:math';
import 'package:tp2/package/tuiles.dart';
import 'package:flutter/material.dart';

const int INITIALISATION = 0;

final GlobalKey<PuzzleGridState> _puzzleGridKey = GlobalKey<PuzzleGridState>();
final GlobalKey<ImageSelectionState> _imageSelectionKey =
    GlobalKey<ImageSelectionState>();

const List<String> difficultyLevels = [
  "Facile",
  "Intermédiaire",
  "Difficile"
];

class Exercice7Screen extends StatefulWidget {
  const Exercice7Screen({Key? key}) : super(key: key);

  @override
  State<Exercice7Screen> createState() => _Exercice7ScreenState();
}

class _Exercice7ScreenState extends State<Exercice7Screen> {
  bool _isPlaying = false;
  late PuzzleGrid _puzzleGrid;
  late ImageSelection _imageSelection;
  String selectedLevel = difficultyLevels[0];
  int displayedScore = INITIALISATION;
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer = Timer(Duration.zero, () {});
  String _timerDisplay = '00:00';

  @override
  void initState() {
    super.initState();
    _puzzleGrid = PuzzleGrid(
        key: _puzzleGridKey,
        displayScoreCallback: displayScore,
        displaySuccessCallback: displaySuccess);
    _imageSelection = ImageSelection(
        key: _imageSelectionKey, onImageChangeCallback: onImageChange);
  }

  void togglePlayStop() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    _puzzleGridKey.currentState!.togglePlayStop();
    _imageSelectionKey.currentState!.togglePlayStop();
    if (_isPlaying) {
      startTimer();
    } else {
      stopTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Changement de couleur
        title: const Text("Jeu du Taquin"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Nombre de mouvements : $displayedScore',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)), // Changement de couleur
              Text('Temps : $_timerDisplay',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)) // Changement de couleur
            ],
          ),
          const SizedBox(height: 5),
          _puzzleGrid,
          _imageSelection,
          DropdownButton(
            value: selectedLevel,
            items: difficultyLevels.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              if (_isPlaying == false) {
                setState(() {
                  selectedLevel = value!;
                });
                updateDifficulty(difficultyLevels.indexOf(value!));
              }
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          togglePlayStop();
        },
        tooltip: _isPlaying ? "Play" : "Stop",
        child: _isPlaying
          ?   const Text(
            "Stop",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )
          : const Text(
              "Start",
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.bold, 
              ),
            ),
       ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: goBackToStart,
              icon: const Icon(Icons.autorenew_rounded),
              tooltip: "Reset All",
            ),
            IconButton(
              onPressed: removeColumn,
              icon: const Icon(Icons.remove),
              tooltip: "Remove Tiles",
            ),
            IconButton(
              onPressed: addColumn,
              icon: const Icon(Icons.add),
              tooltip: "Add Tiles",
            ),
            IconButton(
              onPressed: goBackAction,
              icon: const Icon(Icons.undo_rounded),
              tooltip: "Go Back",
            ),
          ],
        ),
      ),
    );
  }

  void onImageChange(String newImageUrl) {
    _puzzleGridKey.currentState?.onImageChange(newImageUrl);
    resetTimer();
  }

  void addColumn() {
    _puzzleGridKey.currentState?.addColumn();
    resetTimer();
  }

  void removeColumn() {
    _puzzleGridKey.currentState?.removeColumn();
    resetTimer();
  }

  void updateDifficulty(int level) {
    _puzzleGridKey.currentState!.updateDifficulty(level);
    resetTimer();
  }

  void displayScore(int nb_mvt) {
    setState(() {
      displayedScore = nb_mvt;
    });
  }

  void goBackAction() {
    _puzzleGridKey.currentState!.goBackAction();
  }

  void goBackToStart() {
    _puzzleGridKey.currentState!.goBackToStart();
    resetTimer();
    startTimer();
  }

  void displaySuccess() {
    stopTimer();
    showDialog(
      context: context,
      builder: (BuildContext context) => SuccessDialog(
          nb_mvt: displayedScore,
          chrono: _timerDisplay,
          resetGameCallback: resetGame,)
    );
  }

  void resetGame() {
    togglePlayStop();
    displayedScore = INITIALISATION;
    _puzzleGridKey.currentState!.resetGame();
    resetTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      setState(() {
        _timerDisplay =
            '${_stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
    _stopwatch.start();
  }

  void stopTimer() {
    _timer.cancel();
    _stopwatch.stop();
  }

  void resetTimer() {
    stopTimer();
    _stopwatch.reset();
    setState(() {
      _timerDisplay = "00:00";
    });
  }
}

class ImageSelection extends StatefulWidget {
  final Function onImageChangeCallback;
  const ImageSelection({Key? key, required this.onImageChangeCallback})
      : super(key: key);

  @override
  State<ImageSelection> createState() => ImageSelectionState();
}

class ImageSelectionState extends State<ImageSelection> {
  List<String> imageUrls = [
    'images/exo4.jpg',
    'images/exo7.jpeg',
    'images/exo7_2.jpeg'
  ];
  late List<ImageButton> imageButtonList;
  int selectedImageIndex = 0;
  bool isPlaying = false;

  @override
  void initState() {
    populateList();
    super.initState();
  }

  void populateList() {
    imageButtonList = List<ImageButton>.generate(
      imageUrls.length,
      (index) => ImageButton(
          id: index,
          imageUrl: imageUrls[index],
          onPressedCallback: onImageButtonPressed,
          isSelected: index == selectedImageIndex),
    );
  }

 @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: imageButtonList,
      ),
    );
  }

  void onImageButtonPressed(int idSelected) {
    if (!isPlaying) {
      setState(() {
        selectedImageIndex = idSelected;
        populateList();
      });
      widget.onImageChangeCallback(imageUrls[idSelected]);
    }
  }

  void togglePlayStop() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }
}

class SuccessDialog extends StatelessWidget {
  final int nb_mvt;
  final String chrono;
  final Function resetGameCallback;
  const SuccessDialog(
      {Key? key,
      required this.nb_mvt,
      required this.chrono,
      required this.resetGameCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Félicitations !",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 10),
            Text("Nombre de mouvements : $nb_mvt", style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 10),
            Text("Temps : $chrono", style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.exit_to_app_rounded),
                  label: const Text("Quitter", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.restart_alt_rounded),
                  label: const Text("Rejouer", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pop(context);
                    resetGameCallback();
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class PuzzleGrid extends StatefulWidget {
  final Function displayScoreCallback;
  final Function displaySuccessCallback;
  const PuzzleGrid(
      {Key? key,
      required this.displayScoreCallback,
      required this.displaySuccessCallback})
      : super(key: key);

  @override
  State<PuzzleGrid> createState() => PuzzleGridState();
}

class PuzzleGridState extends State<PuzzleGrid> {
  late List<ImageTile> tiles;
  late List<ImageTile> initialTiles;
  int emptyIndex = 1;
  int currentDifficulty = 60;
  bool isPlaying = false;
  late ImageTilePlus imageTileService;
  late int nb_mvt;
  late List<int> swapHistory = [];
  late bool isGoingBack = false;

  @override
  void initState() {
    imageTileService = ImageTilePlus();
    nb_mvt = 0;
    updateDifficulty(0);
    swapHistory.add(emptyIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.blueAccent, // Changement de couleur
            height: 300,
            width: 300,
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: tiles.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: imageTileService.getNbColumns()),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: isPlaying
                      ? () => swapTiles(index)
                      : () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content: Text("Appuyez sur le bouton start"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      color: _isAdjacent(index, emptyIndex)
                          ? Colors.blueAccent // Changement de couleur
                          : Colors.transparent,
                      padding: const EdgeInsets.all(4),
                      child: tiles[index].croppedImageTile(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// FUNCTIONS FOR SHUFFLE
  shuffleTilesDependingOnDifficulty(int difficulty) {
    if (isPlaying == false) {
      nb_mvt = INITIALISATION;
      for (int i = 0; i < difficulty; i++) {
        int randomIndex2 = getRandomAdjacentIndex();
        swapTiles(randomIndex2);
      }
    }
  }

  int getRandomAdjacentIndex() {
    int nbColumns = imageTileService.getNbColumns();
    List<int> emptyTileCoordinates = getEmptyTileRowColumn();
    List<int> adjacentIndices = [];

    // Top
    if (emptyTileCoordinates[0] > 0) {
      adjacentIndices.add(emptyIndex - nbColumns);
    }

    // Bottom
    if (emptyTileCoordinates[0] < nbColumns - 1) {
      adjacentIndices.add(emptyIndex + nbColumns);
    }

    // Left
    if (emptyTileCoordinates[1] > 0) {
      adjacentIndices.add(emptyIndex - 1);
    }
    // Right
    if (emptyTileCoordinates[1] < nbColumns - 1) {
      adjacentIndices.add(emptyIndex + 1);
    }

    var randomValue = Random().nextInt(adjacentIndices.length);

    return adjacentIndices[randomValue];
  }

  List<int> getEmptyTileRowColumn() {
    int nbColumns = imageTileService.getNbColumns();
    int comparator = 0;
    int effectiveRow = 0;
    int effectiveColumn = 0;
    int i = 0;

    for (i; i < tiles.length; i++) {
      if (i == emptyIndex) {
        for (int j = 0; j < nbColumns; j++) {
          comparator += nbColumns;
          if (i < comparator) {
            effectiveColumn = i - nbColumns * effectiveRow;
          } else {
            effectiveRow += 1;
          }
        }
      }
    }
    return [effectiveRow, effectiveColumn];
  }

  /// FUNCTION FOR SWAPPING TILES
  swapTiles(int index) {
    if (_isAdjacent(index, emptyIndex)) {
      setState(() {
        ImageTile temp = tiles[emptyIndex];
        tiles[emptyIndex] = tiles[index];
        tiles[index] = temp;
        emptyIndex = index;
      });
      if (isPlaying) {
        updateScore();
        if (!isGoingBack) {
          swapHistory.add(index);
        }
        if (checkSuccess()) widget.displaySuccessCallback();
      }
    }
  }

  bool _isAdjacent(int index1, int index2) {
    int nbColumns = imageTileService.getNbColumns();
    int row1 = index1 ~/ nbColumns;
    int col1 = index1 % nbColumns;
    int row2 = index2 ~/ nbColumns;
    int col2 = index2 % nbColumns;

    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }

  /// FUNCTIONS FOR GAME FUNCTIONALITY
  onImageChange(String newImageUrl) {
    imageTileService.setImageUrl(newImageUrl);
    updatePuzzle();
  }

  addColumn() {
    if (isPlaying == false) {
      if (imageTileService.getNbColumns() < 8) {
        imageTileService.setNbColumns(imageTileService.getNbColumns() + 1);
        updatePuzzle();
      }
    }
  }

  removeColumn() {
    if (isPlaying == false) {
      if (imageTileService.getNbColumns() > 2) {
        imageTileService.setNbColumns(imageTileService.getNbColumns() - 1);
        updatePuzzle();
      }
    }
  }

  updatePuzzle() {
    if (isPlaying == false) {
      setState(() {
        tiles = List.from(imageTileService.getTilesList());
        if (emptyIndex >= tiles.length) emptyIndex = 0;
        int idEmpty = tiles[emptyIndex].id;
        tiles[emptyIndex] = ImageTile(id: idEmpty, empty: true);
        resetInitialTiles();
        shuffleTilesDependingOnDifficulty(currentDifficulty);
        swapHistory = [emptyIndex];
        nb_mvt = INITIALISATION;
      });
    }
    nb_mvt = INITIALISATION;
  }

  void updateDifficulty(int level) {
    int nbColumns = imageTileService.getNbColumns();

    switch (level) {
      case 0:
        currentDifficulty = nbColumns * 20;
        break;
      case 1:
        currentDifficulty = nbColumns * 20;
        break;
      case 2:
        currentDifficulty = nbColumns * 20;
        break;
      case 3:
        currentDifficulty = nbColumns * 20;
        break;
      default:
        currentDifficulty = nbColumns * 20;
    }

    updatePuzzle();
  }

  void updateScore() {
    if (isPlaying == true) {
      nb_mvt = nb_mvt + 1;
      widget.displayScoreCallback(nb_mvt);
    }
  }

  void togglePlayStop() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void goBackAction() {
    isGoingBack = true;
    if (swapHistory.length > 1 && isPlaying) {
      swapTiles(swapHistory[swapHistory.length - 2]);
      swapHistory.removeLast();
      updateScore();
    }
    isGoingBack = false;
  }

  void resetInitialTiles() {
    initialTiles = List.from(tiles);
  }

  bool checkSuccess() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].id != initialTiles[i].id) return false;
    }
    return true;
  }

  void resetGame() {
    emptyIndex = 1;
    isPlaying = false;
    nb_mvt = INITIALISATION;
    updateDifficulty(0);
  }

  void goBackToStart() {
    if (isPlaying) {
      while (swapHistory.length > 1) {
        goBackAction();
      }
      nb_mvt = INITIALISATION;
      widget.displayScoreCallback(nb_mvt);
    }
  }
}

class ImageButton extends StatelessWidget {
  final int id;
  final String imageUrl;
  final Function onPressedCallback;
  final bool isSelected;
  const ImageButton(
      {Key? key,
      required this.id,
      required this.imageUrl,
      required this.onPressedCallback,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: isSelected ? Colors.blue : Colors.white,
        height: 50,
        width: 50,
        child: InkWell(
          onTap: () => onPressedCallback(id),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(imageUrl, height:50,
              width:50,),

            ),
          ),
        ),
      ),
    );
  }
}
