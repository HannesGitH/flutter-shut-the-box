import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shut_the_box_engine/shut_the_box_engine.dart' as e;

class PlayCard extends ConsumerWidget {
  const PlayCard(this.cardp, {required this.onPressed, Key? key})
      : super(key: key);

  final ChangeNotifierProvider<e.Card> cardp;

  final Function() onPressed;

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
        onPressed: onPressed,
      ),
    );
  }
}
