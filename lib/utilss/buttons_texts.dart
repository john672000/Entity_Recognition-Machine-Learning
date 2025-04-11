import 'package:flutter/material.dart';
import 'package:uilearn/utilss/app_theme.dart';

ButtonStyle _buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: AppTheme.accent1,
    foregroundColor: AppTheme.dark,
    disabledBackgroundColor: AppTheme.dbcolor,
    disabledForegroundColor: AppTheme.dfcolor,
  );
}

class ActionButton extends StatefulWidget {
  final Function()? onPressed;
  final IconData icon;
  final bool clr;
  const ActionButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.clr});
  @override
  State<ActionButton> createState() => _Actionbutton();
}

class MainButton extends StatefulWidget {
  final Function()? onPressed;
  final String text;

  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  @override
  State<MainButton> createState() => _Mainbutton();
}

class MainText extends StatefulWidget {
  final String text;
  final String txty;
  final bool clr;
  const MainText(
      {super.key, required this.text, required this.txty, required this.clr});
  @override
  State<MainText> createState() => _Maintext();
}

class _Actionbutton extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      color: AppTheme.accent1,
      icon: Icon(widget.icon,
          color: widget.clr ? AppTheme.black : AppTheme.light),
    );
  }
}

class _Mainbutton extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: _buttonStyle(),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _Maintext extends State<MainText> {
  @override
  Widget build(BuildContext context) {
    if (widget.txty == "Main") {
      return Text(
        widget.text,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 22,
          color: widget.clr ? AppTheme.black : AppTheme.light,
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      if (widget.txty == "Sub") {
        return Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
            color: widget.clr ? AppTheme.black : AppTheme.light,
            fontWeight: FontWeight.bold,
          ),
        );
      } else {
        if (widget.txty == "Par") {
          return Text(
            widget.text,
            style: TextStyle(
              fontSize: 13,
              color: widget.clr ? AppTheme.black : AppTheme.light,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return Text("Hello");
        }
      }
    }
  }
}
