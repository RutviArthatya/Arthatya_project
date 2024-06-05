import 'package:flutter/cupertino.dart';

Widget buildSize({double? height, double? width}) {
  return SizedBox(
    height: height ?? 10,
    width: width ?? 10,
  );
}