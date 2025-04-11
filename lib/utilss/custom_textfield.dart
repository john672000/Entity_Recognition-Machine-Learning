import 'package:flutter/material.dart';
import 'package:uilearn/utilss/app_theme.dart';

class Responsefield extends StatefulWidget {
  final int? maxLenght;
  final String hintText;
  final TextEditingController controller;
  const Responsefield({
    super.key,
    this.maxLenght,
    required this.hintText,
    required this.controller,
  });

  @override
  State<Responsefield> createState() => _ResponsefieldState();
}

class _ResponsefieldState extends State<Responsefield> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: null,
      maxLength: widget.maxLenght,
      keyboardType: TextInputType.multiline,
      cursorColor: AppTheme.accent1,
      style: AppTheme.inputStyle,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            color: AppTheme.accent1,
            icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off)),
        hintStyle: AppTheme.hintStyle,
        hintText: widget.hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.accent1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.medium,
          ),
        ),
        border: OutlineInputBorder(
          // Default border for both focused and unfocused
          borderSide: BorderSide(
            color:
                AppTheme.accent1, // Ensure it's the same as enabledBorder color
          ),
        ),
        counterStyle: AppTheme.counterStyle,
      ),
    );
  }
}

class CustomPasswordfield extends StatefulWidget {
  final int? maxLenght;
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;
  const CustomPasswordfield({
    super.key,
    this.maxLenght,
    this.maxLines,
    required this.hintText,
    required this.controller,
  });

  @override
  State<CustomPasswordfield> createState() => _CustomPasswordfieldState();
}

class _CustomPasswordfieldState extends State<CustomPasswordfield> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        height: 100,
        child: TextField(
          controller: widget.controller,
          obscureText: !showPassword,
          maxLines: widget.maxLines,
          maxLength: widget.maxLenght,
          keyboardType: TextInputType.multiline,
          cursorColor: AppTheme.accent1,
          style: AppTheme.inputStyle,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                color: AppTheme.accent1,
                icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off)),
            hintStyle: AppTheme.hintStyle,
            hintText: widget.hintText,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.accent1,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.black,
              ),
            ),
            counterStyle: AppTheme.counterStyle,
          ),
        ),
      ),
    );
  }
}

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    this.maxLenght,
    this.maxLines,
    required this.hintText,
    required this.controller,
    required this.ishidden,
  });
  final int? maxLenght;
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;
  final bool ishidden;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  final _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        height: 100,
        child: TextField(
          focusNode: _focusNode,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          controller: widget.controller,
          maxLines: widget.maxLines,
          maxLength: widget.maxLenght,
          keyboardType: TextInputType.multiline,
          cursorColor: AppTheme.accent1,
          style: AppTheme.inputStyle,
          decoration: InputDecoration(
            hintStyle: AppTheme.hintStyle,
            hintText: widget.hintText,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.accent1,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.black,
              ),
            ),
            counterStyle: AppTheme.counterStyle,
          ),
        ),
      ),
    );
  }
}
