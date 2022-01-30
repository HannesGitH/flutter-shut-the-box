import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shut_the_box_engine/shut_the_box_engine.dart' as E;

final _gamep = E.gameProvider(E.Game());

class GameView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamep = ref.watch(_gamep); //.game;
    return Scaffold(
      body: Stack(
        children: [
          PlayerWon(gamep.winner),
          const Players(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(_gamep).addPlayers(null);
        },
      ),
    );
  }
}

class Players extends ConsumerWidget {
  const Players({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamep = ref.watch(_gamep);

    return Column(
      children:
          E.provFromList(gamep.game.players).map((p) => PlayerArea(p)).toList(),
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
    );
  }
}

class PlayerArea extends StatelessWidget {
  const PlayerArea(this.player, {Key? key}) : super(key: key);

  final ChangeNotifierProvider<E.Player> player;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Column(
        children: [
          Row(
            children: [
              Text(ref.watch(player).name),
              const SizedBox(width: 10),
              Text(ref.watch(player).roundEyes.toString()),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: E
                    .provFromList(ref
                        .watch(player)
                        .cards) //BUG: warum hat jeder player die selben karten? //TODO
                    .map((c) => PlayCard(c))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayCard extends ConsumerWidget {
  const PlayCard(this.cardp, {Key? key}) : super(key: key);

  final ChangeNotifierProvider<E.Card> cardp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(cardp);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 0, vertical: 40)),
          elevation: MaterialStateProperty.all(card.isDown ? 0 : 8),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          shadowColor: MaterialStateProperty.all(
              card.isSelected ? theme.primaryColor : null),
          backgroundColor: MaterialStateProperty.all(theme.canvasColor),
        ),
        child: Text(card.number.toString()),
        onPressed: () => card.isSelected ^= true,
      ),
    );
  }
}

class PlayerWon extends StatelessWidget {
  const PlayerWon(this.winner, {Key? key}) : super(key: key);
  final E.Player? winner;

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
        onPressed: () => ref.read(_gamep).restart(),
        icon: const Icon(Icons.restart_alt));
  }
}
