import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/colors.dart';
import '../managers/board.dart';

class ScoreBoard extends ConsumerWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(boardManager.select((board) => board.score));
    final best = ref.watch(boardManager.select((board) => board.best));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Score(label: 'Score', score: '$score'),
         SizedBox(
          width: 2.sp,
        ),
        Score(
            label: 'Best',
            score: '$best',
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
      ],
    );
  }
}

class Score extends StatelessWidget {
  const Score(
      {Key? key, required this.label, required this.score, this.padding})
      : super(key: key);

  final String label;
  final String score;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/bg_img.png"), // Path to your image
            fit: BoxFit.cover, // Ensure the image covers the button area
          ),
          // Rounded corners
          border: Border.all(color: Colors.yellow,width: 3),
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(children: [
        Text(
          label.toUpperCase(),
          style:   TextStyle(fontSize: 8.sp, color: textColorWhite,fontWeight: FontWeight.w800),
        ),
        Text(
          score,
          style:   TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 8.sp),
        )
      ]),
    );
  }
}
