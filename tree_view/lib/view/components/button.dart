import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tree_view/view_model/tree_view_model.dart';

class CustomButton extends StatefulWidget {
  final String title;

  final String logo;

  bool filter;

  CustomButton(
      {super.key,
      required this.filter,
      required this.title,
      required this.logo});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(widget.filter
                ? Color.fromARGB(255, 33, 136, 255)
                : Colors.white)),
        onPressed: () {
          setState(() {
            widget.filter = !widget.filter;
          });
        },
        child:
            Row(children: [SvgPicture.asset(widget.logo), Text(widget.title)]));
  }
}
