import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import 'navigation.dart';

class IntroPage extends StatefulWidget{
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>{

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: Image.asset("image/illiustration/iErrorNet.png"),
          title: "Добро пожаловать в команду TripTeam",
          body: "Планируйте свой отдых,\n"
              "бронируйте билеты\n"
              " и посещайте экскурсии",
        decoration: pageDecor()
          ),
      PageViewModel(
        image: Image.asset("image/illiustration/iErrorNet.png"),
        title: "Зарабатывай с нами",
        body: "Зовите друзей\n и становитесь партнерами,\n"
            "получайте процент\nс каждой покупки друга",
        decoration: pageDecor()
      ),
      PageViewModel(
        image: Image.asset("image/illiustration/iErrorNet.png"),
        title: "Стань гидом",
        body: "В TripTeam можно не только\n"
            "посещать экскурсии,\n"
            "но и предлагать собственные",
        decoration: pageDecor()
      ),
    ];
  }

  PageDecoration pageDecor(){
    return PageDecoration(
      titleTextStyle: Montserrat(size: 24,color: Blue,style: SemiBold),
      bodyTextStyle: Montserrat(size: 18,color: Blue),
    );
  }

  void setLook()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('look', 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        showNextButton: true,
        showSkipButton: true,
        showDoneButton: true,
        back: const Text("Back"),
        next: const Text("Next"),
        skip: const Text("Skip"),
        done: const Text("Done"),
        onDone: (){
            setLook();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> Navigation()), (route) => false);
        },
        onSkip: (){
          setLook();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> Navigation()), (route) => false);
        },
        pages: getPages(),
      )
    );
  }
}