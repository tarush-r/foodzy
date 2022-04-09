import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/utils/size_config.dart';

buildDoneButton({
  BuildContext context,
  String title,
  Function function,
  bool customHeight = false,
  double height,
  bool maintainConstraints = true,
}) {
  return GestureDetector(
    onTap: () => function(),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: maintainConstraints == null
            ? null
            : BoxConstraints(
                minWidth: SizeConfig.screenWidth * 0.3,
                maxWidth: SizeConfig.screenWidth * 0.6,
              ),
        // alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 8.0, top: 20.0),
        padding: EdgeInsets.only(
          top: 0,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor)),
          ],
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          border: Border.all(color: Theme.of(context).buttonColor),
          borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 7),
        ),

        height: !customHeight ? SizeConfig.screenHeight * 0.055 : height,
      ),
    ),
  );
}
