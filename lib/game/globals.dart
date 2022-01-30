import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shut_the_box_engine/shut_the_box_engine.dart' as e;

final gamep_ = e.gameProvider(e.Game());

final stillMissingProvider = Provider<String>((_) => "noch: ");
