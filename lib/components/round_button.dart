import 'package:flutter/material.dart';
import 'package:flutter_blogapp/themes/customTheme.dart';

class roundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;

  roundButton({required this.title, required this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        color: myCustomTheme.lightColorScheme.secondary,
        minWidth: double.infinity,
        height: 50,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: onPress,
      ),
    );
  }
}
