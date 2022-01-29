import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shut_the_box_engine/shut_the_box_engine.dart' as E;

class GameView extends ConsumerWidget {
  final _gamep = E.gameProvider(E.Game());
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamep = ref.watch(_gamep); //.game;
    return Scaffold(
      body: Center(
        child: Text(gamep.game.players.length.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(_gamep).addPlayers([E.Player()]);
        },
      ),
    );
  }
}
