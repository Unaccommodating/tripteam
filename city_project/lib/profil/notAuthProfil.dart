import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/style.dart';
import '../assets/finally.dart';

import 'settings.dart';
import 'authorization.dart';
import 'registration.dart';

class NotAuthProfil extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Size SizePage = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: Grey,

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

        body:Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iProfil, width: SizePage.width/1.3, height: SizePage.width/1.3, fit:BoxFit.fill),
              Container( padding: EdgeInsets.symmetric(horizontal: SizePage.width/6),
                child:Text("Авторизуйтесь что бы пользоваться всеми функциями TripTeam.",
                    textAlign: TextAlign.center,
                    style: Montserrat(style: SemiBold,size: 16,color:Blue)),
              ),
              Container(margin: EdgeInsets.only(top: 20),
                  child: TextButton(onPressed: (){
                    showModalBottomSheet<void>(
                        backgroundColor:White.withOpacity(0),
                        context: context,
                        builder: (BuildContext context) {
                          return ShowDialog();
                        });
                  },
                      child: Container(width: SizePage.width-SizePage.width/5,
                          height: 50,
                          decoration: BoxDecoration(color: Blue,
                              borderRadius: BorderRadius.all(Radius.circular(500))),
                          child: Center(child: Text("Авторизоваться", style: Montserrat(style: SemiBold,size: 19)),)))
              ),
            ]),)
    );
  }
}

class ShowDialog extends StatelessWidget {
  const ShowDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        Container(
          height: 200,
          width: double.infinity,
          padding: EdgeInsets.only(top:25),
          decoration: BoxDecoration(color: Blue,
              borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))),
          child: Column(children: [
            Text("Авторизоваться",style: Montserrat(color:White,style: SemiBold,size: 15)),
            Container(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4),
              margin: EdgeInsets.only(top: 10,bottom: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(alignment: Alignment.center,
                      children: [
                        Container(width: 45,height: 45, decoration:BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),),
                        IconButton(onPressed:(){}, icon: iconVK, iconSize: 50,),
                      ]
                  ),

                  Stack(alignment: Alignment.center,
                      children: [
                        Container(width: 45,height: 45,decoration:BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),),
                        IconButton(onPressed:(){}, icon: iconFacebook, iconSize: 50,),
                      ]
                  ),

                  Stack(alignment: Alignment.center,
                      children: [
                        Container(width: 45,height: 45,decoration:BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),),
                        IconButton(onPressed:(){}, icon: iconGoogle, iconSize: 50,),
                      ]
                  )
                ],
              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> Authorization()));
                },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: White,
                            borderRadius: BorderRadius.all(Radius.circular(500))),
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text("Войти", style: Montserrat(style: SemiBold,size: 18,color:Blue))
                        )
                    )
                ),

                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> Registration()));
                },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: White,
                            borderRadius: BorderRadius.all(Radius.circular(500))),
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text("Регистрация", style: Montserrat(style: SemiBold,size: 18,color:Blue))
                        )
                    )
                ),
              ],
            )
          ]),
        ),

        Container(
            alignment: Alignment.topCenter,
            height: 200,
            padding: EdgeInsets.only(top: 10),
            child: Container(width: 50,
              height: 4,
              decoration: BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),
            ),
        )
    ]);
  }
}