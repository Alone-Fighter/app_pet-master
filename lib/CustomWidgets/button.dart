import 'package:app_pet/Utils/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnClick = void Function();
typedef ValueChanged<T> = void Function(T value);

class ForwardButtonIntro extends StatelessWidget {
  const ForwardButtonIntro({Key? key, required this.onClick}) : super(key: key);

  final OnClick onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick.call();
      },
      child: Container(
        width: Config.buttonH,
        height: Config.buttonH,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Config.blue, borderRadius: BorderRadius.circular(10)),
        child: Icon(
          Icons.arrow_forward_rounded,
          color: Config.white,
        ),
      ),
    );
  }
}

class BackButtonIntro extends StatelessWidget {
  const BackButtonIntro({Key? key, required this.onClick}) : super(key: key);
  final OnClick onClick;

  @override
  Widget build(context) {
    return InkWell(
      onTap: () {
        onClick.call();
      },
      child: Container(
        width: Config.buttonH,
        height: Config.buttonH,
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_back_rounded,
          color: Config.blue,
        ),
      ),
    );
  }
}

class NextButtonTextIntro extends StatelessWidget {
  const NextButtonTextIntro(
      {Key? key, required this.text, required this.onClick})
      : super(key: key);
  final String text;
  final OnClick onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick.call();
      },
      child: Container(
        width: Config.buttonH,
        height: Config.buttonH,
        alignment: Alignment.center,
        child: Text(
          text,
          style: Config.textStyleM(Config.blue),
        ),
      ),
    );
  }
}

class ForwardButtonIntroText extends StatelessWidget {
  const ForwardButtonIntroText(
      {Key? key, required this.text, required this.onClick})
      : super(key: key);
  final String text;
  final OnClick onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick.call();
      },
      child: Container(
        height: Config.buttonH,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Config.blue, borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: Config.textStyleH(Config.white),
        ),
      ),
    );
  }
}

class SwitchButtonSetting extends StatelessWidget {
  const SwitchButtonSetting(
      {Key? key,required this.text, required this.value, required this.onChange})
      : super(key: key);
  final String text;
  final bool value;
  final ValueChanged<bool> onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Container(
                padding: const EdgeInsets.only(left: 16),
                alignment: Alignment.centerLeft,
                child: Text(text , style: Config.textStyleM(Colors.black),),
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Switch(
                  value: value,
                  onChanged: (value) {
                    onChange.call(value);
                  },
                ),
              ),
            ],
          ),
          Divider(height: 0.5 ,color: Colors.black.withOpacity(.1),)
        ],
      )
    );
  }
}

class TextButtonSetting extends StatelessWidget {
  const TextButtonSetting({Key? key, required this.text, required this.onClick}) : super(key: key);
  final String text;
  final OnClick onClick;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick.call();
      },
      child: SizedBox(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(text , style: Config.textStyleM(Colors.black),)),
            ),
            Divider(height: 0.5 ,color: Colors.black.withOpacity(.1),)
          ],
        ),
      ),
    );
  }
}

