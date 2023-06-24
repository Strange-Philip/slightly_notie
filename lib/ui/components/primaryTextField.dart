import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextFieldWidget extends StatefulWidget {
  const PrimaryTextFieldWidget({
    Key? key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.onTap,
    this.initialValue,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
    this.maxLines,
    this.suffix,
    this.enabled = true,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hintText;
  final String? initialValue;
  final Widget? prefixIcon;
  final AutovalidateMode? autovalidateMode;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final Widget? suffix;
  final bool enabled;

  final FocusNode? focusNode;

  @override
  _PrimaryTextFieldWidgetState createState() => _PrimaryTextFieldWidgetState();
}

class _PrimaryTextFieldWidgetState extends State<PrimaryTextFieldWidget> {
  @override
  void initState() {
    super.initState();
  }

  // TODO: Add boolean value to determine if controller is disposed or not
  @override
  void dispose() {
    // widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        controller: widget.controller,
        obscureText: false,
        initialValue: widget.initialValue,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
        maxLines: widget.maxLines ?? 1,
        inputFormatters: widget.inputFormatters,
        onEditingComplete: () {
          if (widget.controller!.text.isEmpty) {
            widget.focusNode!.unfocus();
          }
        },
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffix,
          hintText: widget.hintText,
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
        ),
        style: theme.textTheme.bodyLarge!.copyWith(
          color: const Color(0xFF2B2E30),
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
