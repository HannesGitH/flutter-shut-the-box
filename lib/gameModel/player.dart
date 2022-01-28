import 'package:shut_the_box/gameModel/card.dart';
import 'package:shut_the_box/gameModel/cardSets.dart';

class Player {
  bool hasWon;
  late List<Card> cards;

  Player({this.hasWon = false, List<Card>? cardset})
      : cards = cardset ?? defaultCardSet;
}
