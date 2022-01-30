import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shut_the_box/game/player.dart';
import 'package:shut_the_box_engine/shut_the_box_engine.dart' as e;

import 'globals.dart';

class GameView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamep = ref.watch(gamep_); //.game;
    return Scaffold(
      body: Stack(
        children: [
          PlayerWon(gamep.winner),
          const Players(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(gamep_).addPlayers(null);
        },
      ),
    );
  }
}

class PlayerWon extends StatelessWidget {
  const PlayerWon(this.winner, {Key? key}) : super(key: key);
  final e.Player? winner;

  @override
  Widget build(BuildContext context) {
    if (winner == null) return Container();
    return Card(
      child: Row(children: [
        Text('Player "${winner!.name}" won'),
        const ReplayButton(),
      ]),
    );
  }
}

class ReplayButton extends ConsumerWidget {
  const ReplayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () => ref.read(gamep_).restart(),
        icon: const Icon(Icons.restart_alt));
  }
}
