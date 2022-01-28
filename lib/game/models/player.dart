import 'card.dart';
import 'cardSets.dart';

class Player {
  bool hasWon;
  late List<Card> cards;

  Player({this.hasWon = false, List<Card>? cardset})
      : cards = cardset ?? defaultCardSet;
}
