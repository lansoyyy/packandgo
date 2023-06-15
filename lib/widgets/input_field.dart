// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget inputField({
  @required controller,
  @required validator,
  prefixIcon,
  suffixIcon,
  hint = "",
  borderRadius = 5.0,
  borderColor = const Color(0xFF664805),
  borderWidth = 2.0,
  onFocusBorderColor = const Color(0xFF9E9E9E),
  type = TextInputType.text,
  onChange = "",
  textAlign = TextAlign.left,
  inputFormatters = const <TextInputFormatter>[],
  hasBorder = true,
  hintColor = Colors.grey,
  fieldColor = Colors.white,
  fontSize = 15.0,
  verticalPadding = 5.0,
  horizontaPadding = 10.0,
  enabled = true,
  autoValidateMode = AutovalidateMode.onUserInteraction,
  isObscureText = false,
  label = "",
  isDense = false,
}) {
  if (isDense) verticalPadding = 10.0;
  return TextFormField(
    textAlign: textAlign,
    inputFormatters: inputFormatters,
    onChanged: onChange == "" ? (text) {} : onChange,
    controller: controller,
    validator: validator,
    keyboardType: type,
    autovalidateMode: autoValidateMode,
    style: TextStyle(fontSize: fontSize),
    enabled: enabled,
    obscureText: isObscureText,
    decoration: InputDecoration(
      filled: true,
      fillColor: fieldColor,
      isDense: isDense,
      prefixIcon: prefixIcon,
      suffix: suffixIcon,
      hintText: hint,
      labelText: label,
      hintStyle: TextStyle(color: Colors.grey[600]),
      contentPadding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontaPadding,
      ),
      errorStyle: TextStyle(),
      border: OutlineInputBorder(
        borderSide: hasBorder
            ? BorderSide(color: borderColor, width: borderWidth)
            : BorderSide(width: 0, style: BorderStyle.none),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: hasBorder
            ? BorderSide(color: onFocusBorderColor, width: borderWidth)
            : BorderSide(width: 0, style: BorderStyle.none),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: hasBorder
            ? BorderSide(color: borderColor, width: borderWidth)
            : BorderSide(width: 0, style: BorderStyle.none),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );
}
