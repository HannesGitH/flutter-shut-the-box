import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/player.dart';
import '../models/game.dart';

class GameVM extends StateNotifier<Game> {
  GameVM() : super(Game.playerAmount(0));

  addPlayers(Iterable<Player>? newPlayers) =>
      state.players.addAll(newPlayers ?? [Player()]);
}
