import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

///
/// Custom app bar
/// requires bool isMainPage to check if its a main page
///
class CustomAppBar extends AppBar {
  bool isMainPage;

  CustomAppBar({super.key, required this.isMainPage});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 23, 25, 45),
      title: getTitle(),
      centerTitle: true,
    );
  }

  Widget getTitle() {
    return widget.isMainPage
        ? SvgPicture.asset(
            'assets/icons/tractian.svg',
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.35,
          )
        : Text('Assets',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.065,
            ));
  }
}
