import 'package:flutter/material.dart';
import 'package:tp2/jeu.dart';

class MenuTile extends StatelessWidget {
  final ExerciceModel exercice;
  const MenuTile({super.key, required this.exercice});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.account_balance_rounded,
        ),
        title: Text(exercice.title),
        subtitle: Text(exercice.description),
        trailing: const Icon(Icons.play_arrow_rounded),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => exercice.page,
            ),
          );
        },
      ),
    );
  }
}