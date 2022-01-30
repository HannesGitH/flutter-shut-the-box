import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shut_the_box/game/card.dart';
import 'package:shut_the_box_engine/shut_the_box_engine.dart' as e;
import 'package:shut_the_box/game/globals.dart';

class Players extends ConsumerWidget {
  const Players({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamep = ref.watch(gamep_);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: e
            .provFromList(gamep.game.players)
            .map((p) => PlayerArea(p))
            .toList(),
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}

class PlayerArea extends StatelessWidget {
  const PlayerArea(this.playerp, {Key? key}) : super(key: key);

  final ChangeNotifierProvider<e.Player> playerp;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final player = ref.watch(playerp);

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    player.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(ref.watch(stillMissingProvider)),
                      Text(
                        player.roundEyes.toString(),
                        style: TextStyle(
                            color: player.roundEyes == 0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: e
                      .provFromList(player
                          .cards) //BUG: warum hat jeder player die selben karten? //TODO
                      .mapIndexed((i, c) => PlayCard(
                            c,
                            onPressed: () => ref.read(playerp).toggleCard(i),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
