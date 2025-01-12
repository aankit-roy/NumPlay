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

Future<void> playBackgroundMusic(  {required WidgetRef ref, required String soundPath}) async {
  final isMuted = ref.read(soundProvider);
  final audioPlayer = ref.read(audioPlayerProvider);
  if (!isMuted) {

    await audioPlayer.setReleaseMode(ReleaseMode.loop); // Loop the music
    await audioPlayer.setVolume(0.3); // Set volume to a low level
    await audioPlayer.play(AssetSource('sounds/bg_music.mp3'));
  } else {
    await audioPlayer.stop(); // Stop music when muted
  }
}

