import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

// StateNotifier to handle audio logic
class SoundNotifier extends StateNotifier<bool> {
  SoundNotifier() : super(false); // Default: sound unmuted

  // Toggle mute state
  void toggleMute() => state = !state;
}

// Provider for sound state
final soundProvider = StateNotifierProvider<SoundNotifier, bool>((ref) {
  return SoundNotifier();
});

// AudioPlayer instance provider
final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  return AudioPlayer();
});

// // StateNotifier to handle audio logic
// class SoundNotifier extends StateNotifier<bool> {
//   SoundNotifier() : super(false); // Default: sound unmuted
//
//   // Toggle mute state
//   void toggleMute() => state = !state;
// }
//
// // Provider for sound state
// final soundProvider = StateNotifierProvider<SoundNotifier, bool>((ref) {
//   return SoundNotifier();
// });
//
// // AudioCache instance provider for short sound effects
// final audioCacheProvider = Provider<AudioCache>((ref) {
//   return AudioCache(); // This will handle caching and playing short sounds
// });
