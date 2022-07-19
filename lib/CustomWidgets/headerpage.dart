import 'package:app_pet/Record/sound_recorder.dart';
import 'package:flutter/material.dart';

class HeaderPage extends StatelessWidget {
  final Widget widget;
  final String background;

  final Color color;

  HeaderPage(
      {required this.widget,
      required this.background,

      required this.color});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(background),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: [


                widget
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderPageLocation extends StatelessWidget {
  final Widget widget;
  final String background;
  final String text1;
  final Color color;

  HeaderPageLocation(
      {required this.widget,
      required this.background,
      required this.text1,
        required this.color});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(background),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 45),
                    width: double.infinity,
                    child: Text(
                      text1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  widget
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerCalendar extends StatelessWidget {
  final Color color;
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const ContainerCalendar(
      {Key? key,
      required this.color,
      required this.child,
      required this.margin,
      required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      // width: double.infinity,
      // height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5, top: 5, bottom: 10),
            width: 100,
            height: 20,
            child: Material(
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                    image: const DecorationImage(
                        image: AssetImage("assets/images/histo.png"),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: margin,
            padding: padding,
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 7,
                  spreadRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class ContainerExaminMedico extends StatefulWidget {
  final Color color;
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double height;
  final bool histo;
  final bool dowidget;
  final VoidCallback historial;
  final VoidCallback agregar;

  const ContainerExaminMedico(
      {Key? key,
      required this.color,
      required this.child,
      required this.margin,
      required this.padding,
      required this.histo,
      required this.dowidget,
      required this.height,required this.historial,required this.agregar})
      : super(key: key);

  @override
  State<ContainerExaminMedico> createState() => _ContainerExaminMedicoState();
}


class _ContainerExaminMedicoState extends State<ContainerExaminMedico> {
  final _recorder = SoundRecorder();
  bool _recorderProcessing = true;
  bool IsRecording = false;


  @override
  void initState() {
    super.initState();

    _recorder.init().then((_) => setState(() {
          _recorderProcessing = false;
        }));
  }


  @override
  void dispose() {
    _recorder.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      // width: double.infinity,
      // height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          widget.histo
              ? Container(
                  margin: const EdgeInsets.only(left: 0, top: 30, bottom: 10),
                  width: 100,
                  height: 20,
                  child: Material(
                    child: InkWell(
                      onTap: widget.historial,
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.transparent,
                          image: const DecorationImage(
                              image: AssetImage("assets/images/histo.png"),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Container(
            margin: widget.margin,
            padding: widget.padding,
            width: double.infinity,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 7,
                  spreadRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: widget.dowidget
                ? Row(
                    children: [
                      Image(
                        width: size.width * 0.27,
                        height: size.height * 0.5,
                        image: const AssetImage(
                            'assets/images/examenesmedicos.png'),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: size.width * 0.4,
                        height: size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Agrega los resultados de exámenes médicos y radiografías",style: TextStyle(fontSize: 9),),
                            Material(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                onTap: widget.agregar,
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  height: 33,
                                  width: 95,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.transparent,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Agregar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      children: [
                        Container(
                          child: const Text(
                            "Registre la información importante de esta visita (Voz y Texto)",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: const EdgeInsets.only(bottom: 20),
                        ),
                        Row(
                          children: [
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              child: InkWell(
                                onTap:
                                  _recorderProcessing
                                      ? null
                                      : () {
                                          setState(() {
                                            _recorderProcessing = true;
                                            _recorder.isRecording ? IsRecording =false : IsRecording = true;
                                          });
                                          _recorder
                                              .toggleRecording(context)
                                              .then((_) => setState(() {
                                                    _recorderProcessing = false;
                                          }));
                                        },

                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          image: AssetImage(IsRecording
                                              ? "assets/images/IconMic.png"
                                              : "assets/images/IconMic2.png"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: const Text(
                                    "Comentarios :",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                  padding: const EdgeInsets.only(left: 5),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: 180,
                                  height: 50,
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: const TextStyle(fontSize: 10),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: widget.color),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: widget.color),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: 'Escribe aqui...',
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(_recorderProcessing
                              ? 'Processing'
                              : _recorder.isRecording
                                  ? 'Recording'
                                  : 'Record'),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  IconMic() {
    setState(() {});
  }
}
