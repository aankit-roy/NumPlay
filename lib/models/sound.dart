import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../managers/sound.dart';



Future<void> playSound(
    {required WidgetRef ref, required String soundPath}) async {
  final isMuted = ref.read(soundProvider);
  if (!isMuted) {
    final audioPlayer = ref.read(audioPlayerProvider);

    await audioPlayer.play(AssetSource(soundPath));
  }
}

// Future<void> playSound(
//     {required StateNotifierProviderRef ref, required String soundPath}) async {
//   final isMuted = ref.read(soundProvider);  // Access the sound provider
//   if (!isMuted) {
//     final audioPlayer = ref.read(audioPlayerProvider);  // Access the audio player provider
//
//     await audioPlayer.play(AssetSource(soundPath));  // Play the sound
//   }
// }