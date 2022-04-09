import 'package:flutter/material.dart';
import 'package:kjsce_hack_2022/utils/size_config.dart';

Widget customTextField(context,
    {String title,
    TextEditingController controller,
    String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool isEnabled = true,
    int maxLines,
    EdgeInsets titleMargin,
    EdgeInsets contentMargin,
    EdgeInsets contentPadding = const EdgeInsets.symmetric(horizontal: 8.0),
    bool limitHeight = true,
    Color fillColor = Colors.white,
    Color titleColor = const Color.fromRGBO(92, 80, 82, 1),
    bool validate = false,
    bool showTitle = true,
    Function(String) onChanged,
    TextStyle textStyle,
    IconData suffixIcon,
    int maxLength,
      TextInputAction textInputAction = TextInputAction.done
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (showTitle)
        Container(
          margin: titleMargin,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: titleColor),
          ),
        ),
      Container(
        margin: contentMargin,
        width: SizeConfig.screenWidth,
        height: limitHeight ? SizeConfig.screenHeight * 0.07 : null,
        child: TextFormField(
          onChanged: onChanged,
          validator: (s) {
            if (!validate) {
              return null;
            } else if (s.isEmpty) {
              return "* Required";
            } else {
              return null;
            }
          },
          enabled: isEnabled,
          textAlign: TextAlign.start,
          style: textStyle ?? Theme.of(context).textTheme.subtitle2,
          maxLines: maxLines,
          maxLength: maxLength,
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            suffixIcon: suffixIcon != null
                ? Icon(
                    suffixIcon,
                    color: Theme.of(context).buttonColor,
                  )
                : null,
            contentPadding: contentPadding,
            filled: true,
            fillColor: fillColor,
            hintStyle: textStyle ??
                Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.2)),
            hintText: hintText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical),
            ),
            // errorText: validator ? null : errorMsg,
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}
