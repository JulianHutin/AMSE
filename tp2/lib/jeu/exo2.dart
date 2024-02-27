import 'dart:math';
import 'package:flutter/material.dart';

class Exercice2 extends StatefulWidget {
  const Exercice2({Key? key}) : super(key: key);

  @override
  State<Exercice2> createState() => _EtatExercice2();
}

class _EtatExercice2 extends State<Exercice2>
    with SingleTickerProviderStateMixin {
  double angleRotationX = 0;
  double angleRotationZ = 0;
  double facteurEchelle = 1;

  late AnimationController controleurAnimation;

  @override
  void initState() {
    super.initState();
    controleurAnimation = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..addListener(() {
        setState(() {
          _animer();
        });
      });
  }

  void _animer() {
    if (angleRotationX + 0.1 <= 2 * pi) {
      angleRotationX += 0.1;
    } else {
      angleRotationX = 0;
    }
    if (angleRotationZ - 0.2 >= 0) {
      angleRotationZ -= 0.2;
    } else {
      angleRotationZ = 2 * pi;
    }

    if (facteurEchelle > 1) {
      facteurEchelle = 0.2;
    } else {
      facteurEchelle += 0.05;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text("Exercice 2"),
        ),
        body: Column(
          children: [
            Transform(
                transform: Matrix4.rotationX(angleRotationX)
                  ..rotateZ(angleRotationZ)
                  ..scale(facteurEchelle),
                alignment: Alignment.center,
                child: SizedBox(
                    height: 350,
                    width: 1000,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 8),
                      child:
                          Image.network('https://picsum.photos/512.jpg'),
                    ))),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Rotation sur l'axe X : "),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                    child: Slider(
                        value: angleRotationX,
                        min: 0,
                        max: 2 * pi,
                        onChanged: (value) {
                          setState(() {
                            angleRotationX = value;
                          });
                        }),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Rotation sur l'axe Z : "),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Slider(
                        value: angleRotationZ,
                        min: 0,
                        max: 2 * pi,
                        onChanged: (value) {
                          setState(() {
                            angleRotationZ = value;
                          });
                        }),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Facteur d'échelle : "),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Slider(
                        value: facteurEchelle,
                        min: 0.1,
                        max: 2,
                        onChanged: (value) {
                          setState(() {
                            facteurEchelle = value;
                          });
                        },
                        
                        ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Animation : "),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    icon: Icon(controleurAnimation.isAnimating
                        ? Icons.stop
                        : Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        if (controleurAnimation.isAnimating) {
                          controleurAnimation.stop();
                        } else {
                          controleurAnimation.repeat();
                        }
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
