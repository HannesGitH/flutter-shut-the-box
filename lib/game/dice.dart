import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shut_the_box_engine/shut_the_box_engine.dart' as e;
import 'package:shut_the_box/game/globals.dart';

class MultipleDice extends ConsumerWidget {
  const MultipleDice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamep = ref.watch(gamep_);
    final game = gamep.game;
    final dice = e.provFromList(game.dice);
    return Row(
      children: [
        IconButton(
          onPressed: () => ref.read(gamep_).addDice(null),
          icon: const Icon(Icons.add),
        ),
        const SizedBox(width: 10),
        ...dice
            .mapIndexed((i, e) =>
                [Dice(e), Text(i < game.dice.length - 1 ? "+" : "= ")])
            .expand((i) => i)
            .toList(),
        Text(
          dice
              .fold<int>(
                  0,
                  (previousValue, element) =>
                      previousValue + ref.watch(element).top)
              .toString(),
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }
}

class Dice extends ConsumerWidget {
  const Dice(this.dicep, {Key? key}) : super(key: key);

  final ChangeNotifierProvider<e.Dice> dicep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dice = ref.watch(dicep);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dice.top.toString(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}
