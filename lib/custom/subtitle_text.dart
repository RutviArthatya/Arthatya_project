import 'package:flutter/material.dart';

import '../constant/color_const.dart';


class SubTitleText extends StatelessWidget {
  const SubTitleText({Key? key,this.color,this.align,this.size, required this.text,this.weight,this.overflow, this.ls}): super(key: key);
  final String text;
  final bool? weight;
  final double? ls;
  final double? size;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,textAlign: align ?? TextAlign.center,style: TextStyle(
      fontSize: size ?? 12,
      letterSpacing: ls,
      color: color ?? ColorConst.subColor,
      fontWeight: weight ?? false ? FontWeight.bold : FontWeight.normal,
      overflow: overflow ?? TextOverflow.fade,
    ),
    );
  }
}