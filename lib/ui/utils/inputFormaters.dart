import 'package:flutter/services.dart';

String? validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern as String);
  if (!regex.hasMatch(value.trim()))
    return 'Email is invalid, try eg:test@email.com';
  else
    return null;
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1)}";
}

String? validatepassword(String val) => val.isEmpty
    ? 'Field cannot be empty'
    : val.length < 6
        ? 'Enter a strong Password with at least 6 characters'
        : val.toLowerCase() == "password"
            ? 'Password cannot be the word $val'
            : null;

String? validatename(String val) => val.isEmpty ? 'Field cannot be empty' : null;

String? comfirmpassword(String val, String password) => val.isEmpty
    ? 'Field cannot be empty'
    : val.length < 6
        ? 'Enter a strong Password with at least 6 characters'
        : val.toLowerCase() == "password"
            ? 'Password cannot be the word $val'
            : null;
