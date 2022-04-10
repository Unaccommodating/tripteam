import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'finally.dart';


///Функция для строк
TextStyle Montserrat({FontWeight style = Medium, Color color = White, double size = 18, double? heigth})
{
  return TextStyle(
      fontSize: size,
      color: color,
      fontFamily: 'Montserrat',
      fontWeight: style,
      height: heigth,
      decoration:TextDecoration.none
  );
}

///Тень для текстовых полей
class Shadow extends StatelessWidget {
  double? height;
  double? width;
  double radius = 0;

  Shadow(double height, double radius,[double? width]) {
    this.height = height;
    this.radius = radius;
    if(width != null) this.width = width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: height,width: width,
        decoration: BoxDecoration(color:Grey,
          borderRadius: BorderRadius.circular(radius),
          boxShadow:const [BoxShadow(color: Colors.black38,
              blurRadius: 5,
              spreadRadius: 0.5,
              offset: Offset(0, 7)
          )],
        )
    );
  }
}

///Тень для виджетов
BoxShadow ShadowForContainer(){
  return BoxShadow(color: Colors.black38,
      blurRadius: 5,
      spreadRadius: 0.5,
      offset: Offset(0, 7)
  );
}

///Пункты в диалоговом окне
class TextDialogWindows extends StatelessWidget {
  String title = '';
  String text = '';

  TextDialogWindows(String title, String text){
    this.title = title;
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin:EdgeInsets.only(bottom:5),
          child: Text(title, style: Montserrat(color:White,size: 13,style: SemiBold),),
        ),
        Container(margin:EdgeInsets.only(bottom:10),
            child: Text(text, style: Montserrat(color:White,size: 13),)
        ),
      ],
    );
  }
}

class ErrorNet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(iErrorNet,
          width: MediaQuery.of(context).size.width/1.3,
          height: MediaQuery.of(context).size.width/1.3, fit:BoxFit.fill
      ),
      Container( padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/12),
        child:Text("Упс. Нет соединения с интернетом.", style: Montserrat(style: SemiBold,size: 16,color:Blue)),
      ),
      TextButton(onPressed: (){},
        child: Text("Повторить".toUpperCase(), style: Montserrat(style: Bold,size: 16,color:Red)),)
    ]);
  }

}

class WaitDialog extends StatelessWidget {
  String illiustration = '';
  String text = '';

  WaitDialog(String illiustration,String text){
    this.illiustration = illiustration;
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(illiustration,
              width: MediaQuery.of(context).size.width/1.3,
              height: MediaQuery.of(context).size.width/1.3, fit:BoxFit.fill),
          Container( padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/6),
            child:Text(text, style: Montserrat(style: SemiBold,size: 18,color:Blue)),
          )
        ]);
  }
}

class Placholder extends StatelessWidget {

  double? width;
  double? heigth;

  Placholder(double width,double heigth){
    this.width = width;
    this.heigth = heigth;
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.transparent.withOpacity(0.1),
        highlightColor: White,
        child: Container(width: double.infinity,height: this.heigth,
            color: White, alignment: Alignment.center,
            child: Container(width: this.width,height: this.heigth)
        )
    );
  }
}

class ShowDialog extends StatelessWidget {
  const ShowDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> Conditions = [
      TextDialogWindows("Заголовок первый",
          "Условия использования сайта регламентируют взаимодействие путешественников, гидов и Трипстера. Все юридические подробности изложены в документах: политика конфиденциальности, договор между гидом и Трипстером (принимаются при регистрации, а фактически начинает работать после публикации экскурсии) и договоры оказания экскурсионных услуг между гидом и путешественником (принимаются гидом и путешественником при внесении предоплаты за экскурсию)."),
      TextDialogWindows("Заголовок второй",
          "Условия использования сайта регламентируют взаимодействие путешественников, гидов и Трипстера. Все юридические подробности изложены в документах: политика конфиденциальности, договор между гидом и Трипстером (принимаются при регистрации, а фактически начинает работать после публикации экскурсии) и договоры оказания экскурсионных услуг между гидом и путешественником (принимаются гидом и путешественником при внесении предоплаты за экскурсию).")
    ];

    return DraggableScrollableSheet(
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top:25,left: 30,right: 30),
              decoration: BoxDecoration(color: Blue,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: Conditions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Conditions[index];
                },
              ),
            ),

            Container(width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/2.3,vertical: 10),
              height: 4,
              decoration: BoxDecoration(color: White,borderRadius: BorderRadius.all(Radius.circular(500))),
            )
          ],
        );
      },
    );
  }
}


class PhotoAuthor extends StatelessWidget {
  String? url;
  double? size;
  PhotoAuthor(this.url, {this.size = 40,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(url== 'null' || url == null){
      return Image.asset(avatarDef,
        width: this.size, height: this.size,
      );
    }else{
      return ClipRRect(borderRadius: BorderRadius.all(Radius.circular(500)),
          child: Image.network(url.toString(),
            fit: BoxFit.cover,
            width: this.size, height: this.size,
            errorBuilder: (context, error, stackTrace) {
              return CircleAvatar(
                child: Image.asset(avatarDef,
                  width: this.size, height: this.size,
                ),
              );
            },
          )
      );
    }
  }
}

class GuideCheck extends StatelessWidget {
  final bool? check;
  final double? size;
  final double? mSize;
  GuideCheck(this.check,{this.size = 40, this.mSize = 15,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(check == true)
    {
      return Container(width: this.size,height: this.size,
          alignment: Alignment.bottomRight,
          child: Container(width: this.mSize,height: this.mSize,
              child: iconConfirmation)
      );
    }
    else
    {
      return Container(width: this.size, height: this.size);
    }
  }
}

///Для текстовых полей с тенью
class TextFieldWithShadow extends StatelessWidget {
  Widget? textField;

  TextFieldWithShadow(this.textField, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 7.0,
        shadowColor: Colors.black,
        child: this.textField,
    );
  }
}

Widget RichTextMethod(String TextMain,[bool star = false]){
  String starStr = '';
  if(star){
    starStr = ' *';
  }
  return
    Container(
      margin: EdgeInsets.only(left: 10,bottom: 5),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: TextMain,
                style: Montserrat(color: Blue, style: SemiBold)),
            TextSpan(text: starStr, style: Montserrat(color: Red)),
          ],
        ),
      ),
    );
}

class TextFieldDecoration{
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? error;
  final String? hintText;

  TextFieldDecoration({this.error = false,this.hintText,this.prefixIcon,this.suffixIcon});

  InputDecoration InputDecor(){
    return
      InputDecoration(
        hintText: this.hintText,
          counterText: '',
        //ИКОНКИ
          prefixIcon: this.prefixIcon,
          suffixIcon: this.suffixIcon,

          //СТИЛЬ
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(500),
              borderSide: BorderSide(width: 0,
                  style: error == true
                      ? BorderStyle.solid
                      : BorderStyle.none)
          ),
          fillColor: White,
          isDense: true,
          filled: true

      );
  }
}

