import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:num_play/const/app_colors.dart';

import '../const/colors.dart';

// class ButtonWidget extends ConsumerWidget {
//   const ButtonWidget(
//       {super.key, this.text, this.icon, required this.onPressed});
//
//   final String? text;
//   final IconData? icon;
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     if (icon != null) {
//       //Button Widget with icon for Undo and Restart Game button.
//       return Container(
//
//
//         decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/icons/Button6.png"), // Path to your background image
//               fit: BoxFit.cover, // Adjust the fit to cover the entire container
//             ),
//             // color: scoreColor,
//
//             borderRadius: BorderRadius.circular(8.0)),
//
//         child: IconButton(
//             color: textColorWhite,
//             onPressed: onPressed,
//             icon: Icon(
//               icon,
//               size: 24.0,
//             )),
//       );
//     }
//     //Button Widget with text for New Game and Try Again button.
//     return ElevatedButton(
//         style: ButtonStyle(
//             padding: MaterialStateProperty.all<EdgeInsets>(
//                 const EdgeInsets.all(16.0)),
//             backgroundColor: MaterialStateProperty.all<Color>(buttonColor)),
//         onPressed: onPressed,
//         child: Text(
//           text!,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/colors.dart';

class ButtonWidget extends ConsumerWidget {
  const ButtonWidget({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
  });

  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (icon != null) {
      // Button Widget with an image background for Icon Buttons (e.g., Undo/Restart).
      return Container(

        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/bg_img.png"), // Path to your image
            fit: BoxFit.cover, // Ensure the image covers the button area
          ),
          // Rounded corners
          border: Border.all(color: Colors.yellow,width: 3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: IconButton(
          color: textColorWhite,
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 16.sp,
          ),
        ),
      );
    }

    // Button Widget with text and solid background (for New Game/Try Again).
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/icons/bg_img.png"), // Path to your image
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.transparent, // Make button background transparent
          shadowColor: Colors.transparent, // Remove shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Match the border radius
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white, // Ensure text is visible over the image
          ),
        ),
      ),
    );
  }
}
