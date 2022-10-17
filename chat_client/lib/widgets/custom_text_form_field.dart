import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends TextFormField {
  static const int _defaultMaxLines = 1;
  static const double _focusedBorderWidth = 2.0;
  static const Color _defaultColor = Colors.grey;
  static const BorderSide _defaultEnabledBorderSide =
      BorderSide(color: _defaultColor);
  static const BorderSide _defaultFocusedBorderSide =
      BorderSide(color: Colors.blue, width: _focusedBorderWidth);
  factory CustomTextFormField.email({
    Key? key,
    required String label,
    bool enabled = true,
    bool decorationBorderBool = true,
    String? initialValue,
    Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    required TextEditingController controller,
  }) =>
      CustomTextFormField(
        key: key,
        label: label,
        enabled: enabled,
        decorationBorderBool: decorationBorderBool,
        initialValue: initialValue,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
      );
  factory CustomTextFormField.emailWithValidation({
    Key? key,
    required String label,
    String? initialValue,
    Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    required bool valid,
    bool canValidate = true,
  }) =>
      CustomTextFormField(
        key: key,
        label: label,
        initialValue: initialValue,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        suffixIcon: canValidate
            ? valid
                ? const Icon(
                    Icons.check,
                    color: Colors.blueAccent,
                  )
                : const Icon(
                    Icons.close,
                    color: Colors.red,
                  )
            : null,
        borderSide: canValidate
            ? valid
                ? const BorderSide(color: Colors.blueAccent)
                : const BorderSide(color: Colors.red)
            : null,
      );
  factory CustomTextFormField.password({
    Key? key,
    required String label,
    bool decorationBorderBool = true,
    String? initialValue,
    Function(String)? onChanged,
    required bool obscureText,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
  }) =>
      CustomTextFormField(
        key: key,
        label: label,
        decorationBorderBool: decorationBorderBool,
        initialValue: initialValue,
        onChanged: onChanged,
        obscureText: obscureText,
        suffixIcon: suffixIcon,
        inputFormatters: inputFormatters,
      );
  factory CustomTextFormField.passwordWithValidation({
    Key? key,
    required String label,
    String? initialValue,
    Function(String)? onChanged,
    required bool obscureText,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
    required bool valid,
  }) =>
      CustomTextFormField(
        key: key,
        label: label,
        initialValue: initialValue,
        onChanged: onChanged,
        obscureText: obscureText,
        suffixIcon: suffixIcon,
        inputFormatters: inputFormatters,
        borderSide: valid ? const BorderSide(color: Colors.blue) : null,
      );
  factory CustomTextFormField.withValidation({
    Key? key,
    required String label,
    String? initialValue,
    Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    required bool valid,
    bool showValidtation = false,
  }) =>
      CustomTextFormField(
        key: key,
        label: label,
        initialValue: initialValue,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        suffixIcon: showValidtation
            ? valid
                ? const Icon(
                    Icons.check,
                    color: Colors.blue,
                  )
                : const Icon(
                    Icons.close,
                    color: Colors.red,
                  )
            : null,
        borderSide: showValidtation
            ? valid
                ? const BorderSide(color: Colors.blue)
                : const BorderSide(color: Colors.red)
            : null,
      );
  CustomTextFormField({
    Key? key,
    required String label,
    String? initialValue,
    Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    bool decorationBorderBool = true,
    bool enabled = true,
    bool isMultiLine = false,
    int? maxLines,
    int? minLines,
    bool autocorrect = true,
    bool autofocus = false,
    bool obscureText = false,
    Widget? suffixIcon,
    BorderSide? borderSide,
    int? maxLength,
    MaxLengthEnforcement maxLengthEnforcement = MaxLengthEnforcement.none,
    String? counterText,
  }) : super(
          key: key,
          initialValue: initialValue,
          autocorrect: autocorrect,
          autofocus: autofocus,
          onChanged: onChanged,
          decoration: InputDecoration(
            label: Text(label),
            enabledBorder: OutlineInputBorder(
              borderSide: borderSide ?? _defaultEnabledBorderSide,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: borderSide != null
                  ? borderSide.copyWith(width: _focusedBorderWidth)
                  : _defaultFocusedBorderSide,
            ),
            border: decorationBorderBool
                ? const OutlineInputBorder()
                : InputBorder.none,
            suffixIcon: suffixIcon,
            floatingLabelStyle: TextStyle(color: borderSide?.color),
            counterText: counterText,
          ),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          enabled: enabled,
          maxLines: isMultiLine ? maxLines : _defaultMaxLines,
          minLines: minLines,
          obscureText: obscureText,
          maxLength: maxLength,
          maxLengthEnforcement: maxLengthEnforcement,
        );
}
