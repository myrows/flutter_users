import 'package:flutter/material.dart';
import 'package:flutter_junior_master/ui/sizing_information.dart';
import 'package:flutter_junior_master/utils/ui_utils.dart';

class BaseWidget extends StatelessWidget {
  final Widget Function( BuildContext context, SizingInformation sizingInformation ) builder;
  const BaseWidget({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var sizingInformation = SizingInformation(
      orientation: mediaQuery.orientation,
      deviceScreenType: getDeviceType(mediaQuery),
      screenSize: mediaQuery.size
    );
    return builder( context, sizingInformation );
  }
}