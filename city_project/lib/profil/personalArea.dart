import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../assets/style.dart';
import '../assets/finally.dart';

import '../service.dart';
import 'settings.dart';

class personalArea extends StatelessWidget {
  dynamic user;
  personalArea(this.user);
  AuthService authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(50),
          child: AppBar(backgroundColor:Grey, elevation: 0.0,
            actions: [
              Container(
                child: IconButton(icon: iconSetting,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> Local()));
                  },),
              )
            ],
          )
      ),

      body: ListView(shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 150,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                        width: double.infinity,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(children: [
                              PhotoAuthor(user!['photo'],size: MediaQuery.of(context).size.width/7),
                              GuideCheck(this.user!["verified"]??false,size:MediaQuery.of(context).size.width/7,mSize: MediaQuery.of(context).size.width/7/4,)
                            ]),
                            Container(margin: EdgeInsets.only(left: 20),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Text(user!['name'].toString(), style: Montserrat(style: Bold, color: Blue, size: 24), textAlign: TextAlign.left),
                                      CheckStatus(this.user!["verified"]??false)
                                    ]
                                )
                            )
                          ],
                        )
                    ),

                    TextButton(onPressed:(){},
                        child: ButtonProfilStyle('Управление профилем','Доступные проверки и расширения',
                            Icon(Icons.person_outlined, color: Blue,size: 30,)
                        )
                    ),
                    Container(height: 1,width: MediaQuery.of(context).size.width, color: Blue),
                    ButtonForGuid(this.user!["guidePermit"]),
                    Container(height: 1,width: MediaQuery.of(context).size.width, color: Blue),
                    TextButton(onPressed:(){},
                        child: ButtonProfilStyle('Статистика','Описание статистики',
                            Icon(Icons.person_outlined, color: Blue,size: 30,)
                        )
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(onPressed:(){},
                        child: ButtonProfilStyleEazy('О приложении')
                    ),
                    Container(height: 1,width: MediaQuery.of(context).size.width, color: Blue),
                    TextButton(onPressed:(){
                      showModalBottomSheet(
                          backgroundColor:White.withOpacity(0),
                          context: context,
                          builder: (BuildContext context) {
                            return ShowWeContacts();
                          });
                    },
                        child: ButtonProfilStyleEazy('Служба поддержки')
                    ),
                    TextButton(onPressed: (){
                      authService.loyaut();
                    },
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(color: Red,
                                borderRadius: BorderRadius.all(Radius.circular(500))),
                            child: Center(child: Text("Выйти из аккаута", style: Montserrat(style: SemiBold,size: 19,color: White)))
                        )
                    )
                  ],
                )
              ],
            ),
          )
      ],
      )
    );
  }

  Widget CheckStatus(bool check){
    if(check) return Text('Личность подтверждена', style: Montserrat(color: Blue, size: 14));
    else return RichText(
      text: TextSpan(text: "Подтвердить личность", style: Montserrat(style: SemiBold,size: 14, color:Red),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            print('+');
          })
    );
  }

  Widget ButtonForGuid(bool check){
    if(check){
      return TextButton(onPressed:(){},
          child: ButtonProfilStyle('Мои экскурсии','Экскурсии в которых вы являетесь гидом',
              Icon(Icons.person_outlined, color: Blue,size: 30,)
          )
      );
    }else{
      return TextButton(onPressed:(){},
          child: ButtonProfilStyle('Стать гидом','Станьте гидом, чтобы опубликовывать ваши экскурсии',
              Icon(Icons.person_outlined, color: Blue,size: 30,)
          )
      );
    }
  }
}

class ButtonProfilStyle extends StatelessWidget{

  String title = 'Title';
  String discription = 'Discription';
  Widget icon = Icon(Icons.ten_k);
  ButtonProfilStyle(this.title,this.discription,this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(margin: EdgeInsets.only(right: 10),
              child: this.icon,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.title, style: Montserrat(style: SemiBold, color: Blue, size: 16)),
                Container(width: MediaQuery.of(context).size.width/1.5,
                  child: Text(this.discription, style: Montserrat(color: Blue, size: 14))
                )
              ],
            ),
            Icon(Icons.arrow_forward_ios,color: Blue)
          ],
        )
    );
  }
}

class ButtonProfilStyleEazy extends StatelessWidget{

  String title = 'Title';
  ButtonProfilStyleEazy(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(this.title, style: Montserrat(style: SemiBold, color: Blue, size: 16)),
            Icon(Icons.arrow_forward_ios,color: Blue)
          ],
        )
    );
  }
}


class ShowWeContacts extends StatelessWidget {
  const ShowWeContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 180,
        width: double.infinity,
        padding: EdgeInsets.only(top:25),
        decoration: BoxDecoration(color: Blue,
            borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))),
        child: Column(children: [
          Text("Служба поддержки",style: Montserrat(color:White,style: SemiBold,size: 15)),
          Container(margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8),
            child: Text("Для решения вопросов, можете связаться с нами лично",style: Montserrat(size: 14),textAlign: TextAlign.center)
          ),
          Container(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8),
            margin: EdgeInsets.only(top: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Stack(alignment: Alignment.center,
                    children: [
                      Container(width: 45,height: 45, decoration:BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),),
                      IconButton(onPressed:()async{}, icon: iconVK, iconSize: 50,),
                    ]
                ),


                Stack(alignment: Alignment.center,
                    children: [
                      Container(width: 45,height: 45, decoration:BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),),
                      IconButton(onPressed:(){
                        launchURL('');
                      }, icon: iconWhatsapp, iconSize: 50,),
                    ]
                ),

                Stack(alignment: Alignment.center,
                    children: [
                      Container(width: 45,height: 45,decoration:BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),),
                      IconButton(onPressed:(){
                        launchURL('https://www.instagram.com/asl_astro/');
                      }, icon: iconInstagram, iconSize: 50,),
                    ]
                ),

                Stack(alignment: Alignment.center,
                    children: [
                      Container(width: 45,height: 45,decoration:BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),),
                      IconButton(onPressed:(){
                        launchURL('https://t.me/astroasl');
                      }, icon: iconTelegram, iconSize: 50,),
                    ]
                )
              ],
            ),
          ),
        ]),
      ),

      Container(
        alignment: Alignment.topCenter,
        height: 180,
        padding: EdgeInsets.only(top: 10),
        child: Container(width: 50,
          height: 4,
          decoration: BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),
        ),
      )
    ]);
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}