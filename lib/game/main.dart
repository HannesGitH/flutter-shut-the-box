import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shut_the_box/game/dice.dart';
import 'package:shut_the_box/game/player.dart';
import 'package:shut_the_box_engine/shut_the_box_engine.dart' as e;

import 'globals.dart';

class GameView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamep = ref.watch(gamep_); //.game;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Shut The Box Game"),
      // ),
      body: Stack(
        children: [
          const Players(),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    MultipleDice(),
                    NextRoundButton(),
                  ],
                ),
              )),
          PlayerWon(gamep.winner),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add_alt_1),
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

class NextRoundButton extends ConsumerWidget {
  const NextRoundButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
        onPressed: () => ref.read(gamep_).nextRound(),
        child: const Icon(Icons.arrow_forward));
  }
}
