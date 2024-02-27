import 'package:flutter/material.dart';
import 'package:tp2/jeu/exo1.dart';
import 'package:tp2/jeu/exo2.dart';
import 'package:tp2/jeu/exo4.dart';
import 'package:tp2/jeu/exo5.dart';
import 'package:tp2/jeu/exo6_1.dart';
import 'package:tp2/jeu/exo6_2.dart';
import 'package:tp2/jeu/exo6_3.dart';
import 'package:tp2/jeu/exo6_final.dart';
import 'package:tp2/jeu/exo7.dart';

class ExerciceModel {
  final String title;
  final String description;
  final Widget page;

  const ExerciceModel(
      {required this.title, required this.description, required this.page});
}

const exercices = [
  ExerciceModel(
    title: "Exercice 1",
    description: 'Display image',
    page: Exercice1(),
  ),
  ExerciceModel(
    title: "Exercice 2",
    description: 'Rotate and scale image + animation',
    page: Exercice2(),
  ),
  ExerciceModel(
    title: "Exercice 4",
    description: 'Display a tile',
    page: Exercice4(),
  ),
  ExerciceModel(
    title: "Exercice 5",
    description: 'GridView from image tile variable size',
    page: Exercice5Screen(),
  ),
  ExerciceModel(
    title: "Exercice 6a",
    description: 'Invert two tiles',
    page: Exercice6aScreen(),
  ),
  ExerciceModel(
    title: "Exercice 6b",
    description: 'Invert two tiles in a grid',
    page: Exercice6bScreen(),
  ),
  ExerciceModel(
    title: "Exercice 6c",
    description: 'Invert tiles in a sizable grid',
    page: Exercice6cScreen(),
  ),
  ExerciceModel(
    title: "Exercice 6d",
    description: 'Invert tiles in a sizable image grid',
    page: Exercice6dScreen(),
  ),
  ExerciceModel(
    title: "Exercice 7",
    description: 'Invert two tiles in a sizable grid',
    page: Exercice7Screen(),
  ),
];