import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../assets/style.dart';
import '../../assets/finally.dart';
import '../../libary/customSnackBar.dart';
import '../../libary/topSnackBart.dart';

class doublePsw extends StatefulWidget
{
  const doublePsw(this.email, {Key? key}) : super(key: key);
  final String? email;

  @override
  State<doublePsw> createState() => _doublePswState();
}

class _doublePswState extends State<doublePsw> {
  bool passwordVisible = true;
  bool passwordVisibleTwo = true;
  bool errorPassword = false;
  bool errorPasswordTwo = false;
  String password = '';
  String passwordTwo = '';
  bool isLoading = false;

  final TextEditingController controllerValidPassword = new TextEditingController();

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
                              child: Text("Введите новый пароль",style: Montserrat(color:Blue,size: 35,style: Bold)),
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
                height: SizePage.height/2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizePage.width/15),
                  child: Column(
                      children:[

                        ///PASSWORD
                        Container(margin: EdgeInsets.only(bottom: 25),
                            child: Column(
                              children: [
                                ///PASSWORD
                                Container(
                                    child: Column(children: [
                                      Container(width: double.infinity,
                                        margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                        child: Text("Пароль:", style: Montserrat(
                                            color: Blue, style: SemiBold)),
                                      ),

                                      Stack(children: [
                                        Shadow(50, 500), // ТЕНЬ

                                        TextField(
                                            controller: controllerValidPassword,
                                            style: Montserrat(
                                                color: Blue, style: SemiBold),
                                            obscureText: passwordVisible,
                                            onChanged: (String value) {
                                              setState(() {
                                                password = value;
                                                errorPassword = false;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              //ИКОНКА
                                                prefixIcon: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: 15, vertical: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(10)),
                                                      color: Color(0xFF00f069),
                                                    ),
                                                    width: 40,
                                                    padding: EdgeInsets.all(6),
                                                    child: iconPassword
                                                ),

                                                //СКРЫТЬ/ПОКАЗАТЬ
                                                suffixIcon: Container(
                                                    margin: EdgeInsets.only(right: 10),
                                                    child: IconButton(
                                                      icon: passwordVisible == true
                                                          ? iconShow
                                                          : iconHide,
                                                      onPressed: () {
                                                        setState(() {
                                                          passwordVisible =
                                                          !passwordVisible;
                                                        });
                                                      },
                                                    )
                                                ),

                                                //ВЫВОД ОШИБКИ
                                                errorText: '',

                                                //СТИЛЬ
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        500),
                                                    borderSide: BorderSide(width: 0,
                                                        style: errorPassword == true
                                                            ? BorderStyle.solid
                                                            : BorderStyle.none)
                                                ),
                                                fillColor: White,
                                                isDense: true,
                                                filled: true
                                            )
                                        ),
                                      ])
                                    ])
                                ),
                              ],
                            )),

                        ///PASSWORD
                        Container(child: Column(children:[
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Container(margin: EdgeInsets.only(left: 10),
                                  child: Text("Повторите пароль:", style: Montserrat(color:Blue,style: SemiBold)),
                                ),

                              ]
                          ),

                          Stack(children:[
                            Shadow(50,500),// ТЕНЬ

                            TextField(style: Montserrat(color:Blue,style: SemiBold),
                                obscureText: passwordVisibleTwo,
                                onChanged: (String value)
                                {setState(() {
                                  passwordTwo = value;
                                  errorPasswordTwo = false;
                                });},
                                decoration: InputDecoration(
                                  //ИКОНКА
                                    prefixIcon: Container(margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Color(0xFF00f069),
                                        ),
                                        width: 40,
                                        padding: EdgeInsets.all(6),
                                        child: iconPassword
                                    ),

                                    //СКРЫТЬ/ПОКАЗАТЬ
                                    suffixIcon: Container(margin: EdgeInsets.only(right: 10),
                                        child: IconButton(
                                          icon: passwordVisibleTwo == true ? iconShow : iconHide,
                                          onPressed: ()
                                          {
                                            setState(()
                                            {
                                              passwordVisibleTwo = !passwordVisibleTwo;
                                            });
                                          },
                                        )
                                    ),

                                    //ВЫВОД ОШИБКИ
                                    errorText: '',

                                    //СТИЛЬ
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                        borderSide: BorderSide(width: 0, style: errorPasswordTwo == true ? BorderStyle.solid : BorderStyle.none)
                                    ),
                                    fillColor: White,
                                    isDense: true,
                                    filled: true
                                )
                            )
                          ])
                        ])
                        ),

                      ]),
                )
            ),

            Container(
                height: SizePage.height/3-60,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///КНОПКА ВОЙТИ
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

  void Validation()async{
    if(password == '' || passwordTwo == ''){
      setState(()=>errorPassword = true);
      setState(()=>errorPasswordTwo = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Введите пароль',textStyle: Montserrat(size: 15)));
    }
    else if(password.length < 6) {
      setState(()=>errorPassword = true);
      setState(()=>errorPasswordTwo = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Слишком короткий пароль',textStyle: Montserrat(size: 15)));
    }
    else if(password != passwordTwo){
      setState(()=>errorPassword = true);
      setState(()=>errorPasswordTwo = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Пароли не совпадают',textStyle: Montserrat(size: 15)));
    }
    else{
      showTopSnackBar(context, CustomSnackBar.success(message:'Вы успешно сменили пароль',textStyle: Montserrat(size: 15)));
      await Future<void>.delayed(const Duration(seconds: 5));
      Navigator.pop(context);
    }
  }

}
