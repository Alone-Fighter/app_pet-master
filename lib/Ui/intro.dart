import 'dart:async';

import 'package:app_pet/CustomWidgets/button.dart';
import 'package:app_pet/Ui/pet_login.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/vet_screens/login_register_vet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'login_register.dart';

class PageOffsetNotifier with ChangeNotifier {
  late double _offset = 0;
  late double _page = 0;
  late int _pageCount = 3;
  bool compile = false;
  late PageController pageController;

  PageOffsetNotifier(PageController pageControllers) {
    pageController = pageControllers;
    pageController.addListener(() {
      _offset = pageController.offset;
      _page = pageController.page!;
      if (_page.round() == _pageCount) {
        compile = true;
      } else {
        compile = false;
      }
      notifyListeners();
    });
  }

  nextPage() {
    if (_pageCount > _page) {
      _page++;
      pageController.animateToPage(_page.toInt(),
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      if (_page.round() == _pageCount) {
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
          compile = true;
          timer.cancel();
          notifyListeners();
        });
      }
      notifyListeners();
    }
  }

  pervPage() {
    if (0 < _page) {
      _page--;
      pageController.animateToPage(_page.toInt(),
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      if (_page.round() < _pageCount) {
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
          compile = false;
          timer.cancel();
          notifyListeners();
        });
      }
      notifyListeners();
    }
  }

  setPageCount(int count) {
    _pageCount = count;
    notifyListeners();
  }

  skip() {
    pageController.animateToPage(_pageCount,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    notifyListeners();
  }

  double get offset => _offset;

  int get pageCount => _pageCount;

  double get page => _page;

  bool get isCompile => compile;
}

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key, required this.vet}) : super(key: key);
  final bool vet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroPages(
          vet: vet,
        ),
      ),
    );
  }
}

class IntroPages extends StatelessWidget {
  IntroPages({Key? key, required this.vet}) : super(key: key);
  final bool vet;
  final PageController _pageController = PageController();

  final List<Widget> vetIntro = const [
    PageViewItem(
      image: 'assets/images/splash_vet_1.png',
      title: '',
      content:'La aplicación que hará que seas más visible para más dueños de mascotas'
    ),
    PageViewItem(
      image: 'assets/images/splash_vet_2.png',
      title: '',
      content:
          'Obtenrás de primera mano la información de los eventos con que reafirmarás tus conocimientos',
    ),
    PageViewItem(
      image: 'assets/images/splash_vet_3.png',
      title: '',
      content: 'Estrás actualizado con las innovaciones de Boehringer Ingelheim',
    ),
  ];

  final List<Widget> petIntro = const [
    PageViewItem(
      image: 'assets/images/splash_1.png',
      title: 'Diario Médico ',
      content:
          'Registra fácilmente la información Médica de tus mascotas en un solo lugary tenla siempre disponible',
    ),
    PageViewItem(
      image: 'assets/images/splash_2.png',
      title: 'Calendario',
      content:
          'Guarda las fechas más importantes para el cuidado de tu mascota y así podrás recordarlas con facilidad',
    ),
    PageViewItem(
      image: 'assets/images/splash_3.png',
      title: 'Cerca de ti',
      content:
          'Encuentra los servicios que tu mascota  necesita en donde estés',
    ),
    PageViewItem(
      image: 'assets/images/splash_4.png',
      title: 'Adopta ',
      content:
          'Conoce algunas mascotas que están esperando un hogar y mascotas que están esperando un hogar y empieza tu proceso de adopción con las fundaciones  ',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageOffsetNotifier(_pageController),
      child: Consumer<PageOffsetNotifier>(builder: (context, value, child) {
        if (vet) {
          value._pageCount = vetIntro.length - 1;
        } else {
          value._pageCount = petIntro.length - 1;
        }
        return Stack(
          children: [
            Positioned(
                child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    children: vet ? vetIntro : petIntro)),
            Positioned(
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: value.isCompile
                            ? BackButtonIntro(
                                onClick: () {
                                  value.pervPage();
                                },
                              )
                            : Container(
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: NextButtonTextIntro(
                                  text: 'Omitir',
                                  onClick: () {
                                    value.skip();
                                  },
                                ),
                              )),
                    const Expanded(
                      flex: 2,
                      child: Image(
                        image: AssetImage('assets/images/splash_top.png'),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: value.isCompile
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: NextButtonTextIntro(
                                  text: 'Omitir',
                                  onClick: () {
                                    kNavigator(context, LoginOrRegister());
                                  },
                                ),
                              )
                            : Container(
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: ForwardButtonIntro(
                                  onClick: () {
                                    value.nextPage();
                                  },
                                ),
                              )),
                  ],
                ),
              ),
            ),
            Positioned(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: value.page > 0
                            ? Container(
                                alignment: Alignment.centerLeft,
                                child: value.isCompile
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(left: 16),
                                        height: 40,
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/images/splash_bottom.png'),
                                        ),
                                      )
                                    : BackButtonIntro(
                                        onClick: () {
                                          value.pervPage();
                                        },
                                      ),
                              )
                            : Container()),
                    Expanded(
                        child: Container(
                            height: 35,
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.only(right: 16),
                            child: value.isCompile
                                ? ForwardButtonIntroText(
                                    text: 'Continuar',
                                    onClick: () {
                                      if (vet) {
                                        kNavigator(context,
                                            const LoginOrRegisterVet());
                                      } else {
                                        kNavigator(
                                            context, const LoginOrRegister());
                                      }
                                    },
                                  )
                                : const Image(
                                    image: AssetImage(
                                        'assets/images/splash_bottom.png'),
                                  ))),
                  ],
                ),
              ),
            )),
          ],
        );
      }),
    );
  }
}

class PageViewItem extends StatelessWidget {
  const PageViewItem(
      {Key? key,
      required this.title,
      required this.image,
      required this.content})
      : super(key: key);

  final String image;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 120, bottom: 96),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.38,
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image(
                  image: AssetImage(image),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: Config.textStyleB(Config.blue),
                    )),
                Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(left: 32, right: 16 , top: 8 , bottom: 8),
                    child: Text(content,
                        textAlign: TextAlign.left,
                        style: Config.textStyleH(Config.gray))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
