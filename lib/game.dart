import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:num_play/const/app_colors.dart';

import 'components/button.dart';
import 'components/empy_board.dart';
import 'components/score_board.dart';
import 'components/tile_board.dart';
import 'const/colors.dart';
import 'managers/board.dart';
import 'models/sound.dart';

class Game extends ConsumerStatefulWidget {
  const Game({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameState();
}

class _GameState extends ConsumerState<Game>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final  guide='Use the arrow keys (Up, Down, Left, Right) or your mouse to swipe and combine matching tiles. Merge tiles with the same number to reach higher scores!';
 //sounds testing:


  //The contoller used to move the the tiles
  late final AnimationController _moveController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  )..addStatusListener((status) {
      //When the movement finishes merge the tiles and start the scale animation which gives the pop effect.
      if (status == AnimationStatus.completed) {
        ref.read(boardManager.notifier).merge();
        _scaleController.forward(from: 0.0);
      }
    });

  //The curve animation for the move animation controller.
  late final CurvedAnimation _moveAnimation = CurvedAnimation(
    parent: _moveController,
    curve: Curves.easeInOut,
  );

  //The contoller used to show a popup effect when the tiles get merged
  late final AnimationController _scaleController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  )..addStatusListener((status) {
      //When the scale animation finishes end the round and if there is a queued movement start the move controller again for the next direction.
      if (status == AnimationStatus.completed) {
        if (ref.read(boardManager.notifier).endRound()) {
          _moveController.forward(from: 0.0);
        }
      }
    });

  //The curve animation for the scale animation controller.
  late final CurvedAnimation _scaleAnimation = CurvedAnimation(
    parent: _scaleController,
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    //Add an Observer for the Lifecycles of the App
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        //Move the tile with the arrows on the keyboard on Desktop
        if (ref.read(boardManager.notifier).onKey(event)) {
          // Play move sound when tiles move
          playSound(ref: ref, soundPath: 'sounds/merge.wav');
          _moveController.forward(from: 0.0);
        }
      },
      child: SwipeDetector(
        onSwipe: (direction, offset) {
          if (ref.read(boardManager.notifier).move(direction)) {
            // Play move sound when tiles move
            playSound(ref: ref, soundPath:'sounds/move.mp3');
            _moveController.forward(from: 0.0);
          }
        },
        child: Scaffold(
          // backgroundColor: backgroundColor,
          body:  SingleChildScrollView(

            child: Container(
              height: MediaQuery.of(context).size.height, // Ensures full height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/bg_img.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Num',
                                    style: TextStyle(
                                      color: Colors.white, // First color
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,

                                      fontSize: 52.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Play',
                                    style: TextStyle(
                                      color: Colors.yellow, // Second color
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,

                                      fontSize: 52.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text("2048",style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                            ),),

                          ],
                        ),
                        const ScoreBoard(),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ButtonWidget(
                                  icon: Icons.undo,
                                  onPressed: () {
                                    //Undo the round.
                                    ref.read(boardManager.notifier).undo();
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "BACK",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ButtonWidget(
                                  icon: Icons.refresh,
                                  onPressed: () {
                                    //Restart the game
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Stack(
                    children: [
                      const EmptyBoardWidget(),
                      TileBoardWidget(
                          moveAnimation: _moveAnimation,
                          scaleAnimation: _scaleAnimation)
                    ],
                  ),
                  SizedBox(height: 16,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Guide: ', // The word "Guide" with a blue color
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
                  ),


                ],
              ),
            ),
          ),
      ),
    ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //Save current state when the app becomes inactive
    if (state == AppLifecycleState.inactive) {
      ref.read(boardManager.notifier).save();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    //Remove the Observer for the Lifecycles of the App
    WidgetsBinding.instance.removeObserver(this);

    //Dispose the animations.
    _moveAnimation.dispose();
    _scaleAnimation.dispose();
    _moveController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}
