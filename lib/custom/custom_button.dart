
import 'package:flutter/material.dart';

import 'custom_text.dart';
import '../constant/color_const.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
        required this.onPressed,
        required this.buttonText,
        required this.weight})
      : super(key: key);
  final VoidCallback onPressed;
  final String buttonText;
  final bool weight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            //minimumSize: const Size.fromHeight(50),
            // elevation: 10,
              elevation: 1,
              shadowColor: ColorConst.grey,
              backgroundColor: ColorConst.buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: onPressed,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Text(

                buttonText,
                style: TextStyle(color: ColorConst.white,fontWeight: FontWeight.bold),
                //weight: weight,
              )
          )),
    );
  }
}