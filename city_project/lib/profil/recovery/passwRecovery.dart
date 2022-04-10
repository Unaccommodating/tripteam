import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../libary/customSnackBar.dart';
import '../../libary/topSnackBart.dart';
import 'codeRecovery.dart';

import '../../assets/style.dart';
import '../../assets/finally.dart';

class passwRecovery extends StatefulWidget
{
  const passwRecovery({Key? key}) : super(key: key);

  @override
  State<passwRecovery> createState() => _passwRecoveryState();
}

class _passwRecoveryState extends State<passwRecovery> {
  bool errorEmail = false;
  String email = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size SizePage = MediaQuery.of(context).size;
    return Stack(children: [
        Scaffold(backgroundColor: Grey,

            ///ШАПКА
            appBar: PreferredSize(preferredSize: Size.fromHeight(SizePage.height/5),
                child: AppBar(backgroundColor:Grey, elevation: 0.0,
                    leading: Container(),
                    flexibleSpace:Stack(alignment: Alignment.topLeft,
                        children: [
                          Column(children: [
                            Container(
                              margin: EdgeInsets.only(top: 70),
                              alignment: Alignment.center,
                              child: Text("Восстановление пароля",style: Montserrat(color:Blue,size: 35,style: Bold)),
                              padding: EdgeInsets.symmetric(horizontal: SizePage.width/20),
                            ),
                          ]),
                          Container(
                              height: 70,width: 50,
                              decoration: BoxDecoration(color: Blue,borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
                              child: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: White,),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  })
                          ),

                        ])
                )
            ),

        body:ListView(shrinkWrap: true,
          children: [
            Container(
                height: SizePage.height/20*10,
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.symmetric(horizontal: SizePage.width/15),
                  child: Column(
                      children:[

                        ///EMAIL
                        Container(height: 112,
                            child: Column(children:[
                              Container(width: double.infinity,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Text("Почта:", style: Montserrat(color:Blue,style: SemiBold)),
                              ),

                              Stack(children: [
                                Shadow(50,500), // ТЕНЬ
                                TextField(style: Montserrat(color:Blue,style: SemiBold),
                                    onChanged: (String value)
                                    {setState(() {
                                      email = value;
                                      errorEmail = false;
                                    });},
                                    decoration: InputDecoration(
                                      //ИКОНКА
                                        prefixIcon: Container(margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: Color(0xFF546eff),
                                            ),
                                            width: 40,
                                            padding: EdgeInsets.all(6),
                                            child: iconEmail
                                        ),

                                        //ВЫВОД ОШИБКИ
                                        errorText: '',

                                        //СТИЛЬ
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                            borderSide: BorderSide(width: 0, style: errorEmail == true ? BorderStyle.solid : BorderStyle.none)
                                        ),
                                        fillColor: White,
                                        isDense: true,
                                        filled: true
                                    )
                                )
                              ])
                            ])
                        ),
                        ///ТЕКСТ
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: SizePage.width/10),
                            child: Text("Введите почту с которой вы регистрировались в приложении", textAlign: TextAlign.center,
                              style: Montserrat(style: SemiBold,size: 13, color:Blue),)
                        ),

                      ]),
                )
            ),


            Container(
                height: SizePage.height/4,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///КНОПКА ДАЛЕЕ
                    TextButton(onPressed: (){

                      Validation();
                    },
                        child: Container(width: SizePage.width-SizePage.width/15*2,
                            height: 50,
                            decoration: BoxDecoration(color: Blue,
                                borderRadius: BorderRadius.all(Radius.circular(500))),
                            child: Center(child: Text("Далее", style: Montserrat(style: SemiBold,size: 19)),)
                        )
                    ),

                  ],
                )
            ),
          ],
        )
    ),

      Positioned(
        child: isLoading
            ? Container(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Blue),
            ),
          ),
          color: Colors.white.withOpacity(0.8),
        ) : Container(),
      ),
    ]);
  }

  void Validation() {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
    r"@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if(email == '') {
      setState(()=>errorEmail = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Введите почту',textStyle: Montserrat(size: 15)));
    }
    else if (emailValid == false) {
      setState(()=>errorEmail = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Неверный формат почты',textStyle: Montserrat(size: 15)));
    }
    else{
      setState(() {isLoading = true;});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> codeRecovery(this.email)));
      setState(() {isLoading = false;});
    }
  }
}

