
import 'package:flutter/material.dart';

class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonHeaderWidget({
    required this.title,
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => HeaderWidget(
        title: title,
        child: ButtonWidget2(
          text: text,
          onClicked: onClicked,
        ),
      );
}

class ButtonWidget2 extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget2({
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, 10)
            ),
          ]
        ),
        height: 40,
        width: 210,
        child: Center(
          child: Text(text,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}


class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderWidget({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20,top: 10),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          child,
        ],
      );
}
