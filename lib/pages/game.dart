import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:num_play/const/app_colors.dart';
import 'package:num_play/managers/sound.dart';

import '../components/button.dart';
import '../components/empy_board.dart';
import '../components/score_board.dart';
import '../components/tile_board.dart';
import '../const/colors.dart';
import '../managers/board.dart';
import '../models/sound.dart';



class Game extends ConsumerStatefulWidget {
  const Game({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameState();
}

class _GameState extends ConsumerState<Game>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final String guide =
      'Use the arrow keys (Up, Down, Left, Right) or your mouse to swipe and combine matching tiles. Merge tiles with the same number to reach higher scores!';

  late final AnimationController _moveController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  )..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      ref.read(boardManager.notifier).merge();
      _scaleController.forward(from: 0.0);
    }
  });

  late final CurvedAnimation _moveAnimation = CurvedAnimation(
    parent: _moveController,
    curve: Curves.easeInOut,
  );

  late final AnimationController _scaleController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  )..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      if (ref.read(boardManager.notifier).endRound()) {
        _moveController.forward(from: 0.0);
      }
    }
  });

  late final CurvedAnimation _scaleAnimation = CurvedAnimation(
    parent: _scaleController,
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    // Start playing background music
    // playBackgroundMusic(ref: ref, soundPath: 'sounds/bg_music.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (ref.read(boardManager.notifier).onKey(event)) {
          playSound(ref: ref, soundPath: 'sounds/merge.wav');
          _moveController.forward(from: 0.0);
        }
      },
      child: SwipeDetector(
        onSwipe: (direction, offset) {
          if (ref.read(boardManager.notifier).move(direction)) {
            playSound(ref: ref, soundPath: 'sounds/move.mp3');
            _moveController.forward(from: 0.0);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              // Background Image
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_img.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Main Game Layout
              LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,

                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const SizedBox(height: 100.0),
                                const ScoreBoard(),
                                SizedBox(height: 16,),
                                Stack(
                                  children: [
                                    const EmptyBoardWidget(),
                                    TileBoardWidget(
                                      moveAnimation: _moveAnimation,
                                      scaleAnimation: _scaleAnimation,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Guide: ',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: guide,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Transparent Blur Navigation Bar
              Positioned(
                top: 10,
                left: 10,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Game Title
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NumPlay',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            '2048 Challenge',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      // Navigation Bar Buttons

                      topButtons()

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row topButtons() {
    return Row(
      children: [
        Column(
          children: [
            ButtonWidget(
              icon: Icons.undo,
              onPressed: () {
                ref.read(boardManager.notifier).undo();
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "BACK",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
         SizedBox(width: 1.sp),
        Column(
          children: [
            ButtonWidget(
              icon: Icons.refresh,
              onPressed: () {
                ref.read(boardManager.notifier).newGame();
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "RESTART",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 1.sp),
        Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final isSoundOn = ref.watch(soundProvider);

                return ButtonWidget(
                  icon: isSoundOn ? Icons.volume_off : Icons.volume_up, // Toggle icon
                  onPressed: () {
                    ref.read(soundProvider.notifier).toggleMute(); // Toggle sound
                  },
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final isSoundOn = ref.watch(soundProvider);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isSoundOn ? "MUTE" : "SOUND", // Toggle text
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        )

//         // Column(
//         //   children: [
//         //     ButtonWidget(
//         //       icon: Icons.volume_up,
//         //       onPressed: () {
//         //         // ref.read(boardManager.notifier).newGame();
//         //       },
//         //     ),
//         //     const Padding(
//         //       padding: EdgeInsets.all(8.0),
//         //       child: Text(
//         //         "SOUND",
//         //         style: TextStyle(
//         //           color: AppColors.white,
//         //           fontSize: 16,
//         //           fontWeight: FontWeight.bold,
//         //         ),
//         //       ),
//         //     ),
//         //   ],
//         // ),
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      ref.read(boardManager.notifier).save();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _moveAnimation.dispose();
    _scaleAnimation.dispose();
    _moveController.dispose();
    _scaleController.dispose();
    // Stop background music when leaving the game
    ref.read(audioPlayerProvider).stop();
    super.dispose();
  }
}
