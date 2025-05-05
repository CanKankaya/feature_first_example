import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Mask to be used for a phone number input
var phoneMaskFormatter = MaskTextInputFormatter(
  mask: '### ### ## ##',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

//Function that returns the number without the mask to send to API
String removeSeparators(String seperator, String str) {
  return str.replaceAll(seperator, '');
}

// Function that formats a given string with the specified mask
String formatWithMask(String format, String str) {
  if (str == '') return '';
  var mask = format;
  int strIndex = 0;
  for (int i = 0; i < mask.length; i++) {
    if (mask[i] == 'x' && strIndex < str.length) {
      mask = mask.replaceFirst('x', str[strIndex]);
      strIndex++;
    }
  }
  return mask;
}
