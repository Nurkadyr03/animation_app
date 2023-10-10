import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isFillSan = true;
  Duration duration = const Duration(seconds: 2);
  @override
  void initState() {
    super.initState();
    changeMode(1);
  }

  Future<void> changeMode(int value) async {
    await Future<void>.delayed(duration);
    if (value == 1) {
      setState(() {
        isFillSan = false;
      });
    }else{
      setState(() {
        isFillSan=true;
      });
    }
  }

  Widget build(BuildContext context) {
    List<Color> lightBgColor = [
      const Color(0xff922A7F),
      const Color(0xffCE577D),
      const Color(0xffFF9484),
      if (isFillSan) const Color(0xffFF9080),
    ];

    var nightBgColor = const [
      Color(0xff0F1746),
      Color(0xff283886),
      Color(0xff376AE2),
    ];
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedContainer(
        duration: duration,
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isFillSan ? lightBgColor : nightBgColor),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              left: 40,
              //right: 100,
              bottom: isFillSan ? 25 : -140,
              duration: duration,
              child: SvgPicture.asset('/sun.svg'),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -34,

              //duration: duration,
              child: Image.asset(
                '/land_tree_light.png',
                height: height * 0.48,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: width * 0.8,
              height: 70,
              margin: const EdgeInsets.only(left: 50, top: 100),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                    indicatorColor: Colors.transparent,
                    unselectedLabelColor: Colors.white,
                    labelStyle:
                        const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tabs: const [
                      Tab(text: 'Morning login'),
                      Tab(text: 'Night login'),
                    ],
                    onTap: (value) async {
                      await changeMode(value);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
