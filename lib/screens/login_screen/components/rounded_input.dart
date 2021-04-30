import 'package:flutter/material.dart';

class RoundedInput extends StatefulWidget {
  final String placeholder;
  final IconData icon;
  final Function onSubmitted;

  RoundedInput(this.placeholder, this.icon, [this.onSubmitted]);

  @override
  RoundedInputState createState() => RoundedInputState();
}

class RoundedInputState extends State<RoundedInput> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
          keyboardType: widget.icon == Icons.email ? TextInputType.emailAddress : TextInputType.text,
          obscureText: widget.icon == Icons.lock,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            fillColor: Color(0xFFF1E6FF),
            filled: true,
            hintText: widget.placeholder,
            prefixIcon: Icon(widget.icon, color: Color(0xFF6F35A5), size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            widget.onSubmitted(value);
          },
        ),
      ),
    );
  }
}
