import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shut_the_box_engine/shut_the_box_engine.dart' as E;

class GameView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(E.gameProvider);
    return Scaffold(
      body: Center(
        child: Text(game.players.length.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(E.gameProvider.notifier).addPlayers([E.Player()]);
        },
      ),
    );
  }
}
