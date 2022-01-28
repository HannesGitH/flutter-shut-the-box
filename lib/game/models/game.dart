import 'dice.dart';
import 'player.dart';

class Game {
  List<Player> players;
  List<Dice> dice;
  Game.playerAmount(int amount, {List<Dice>? dice})
      : players = List.filled(amount, Player()),
        this.dice = dice ?? List.filled(2, Dice());
}
