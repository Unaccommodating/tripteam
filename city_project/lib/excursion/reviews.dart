import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../assets/style.dart';
import '../assets/finally.dart';


class RewiewPage extends StatefulWidget
{
  const RewiewPage(this.data,this.reviews,{Key? key,}) : super(key: key);
  final DocumentSnapshot? data;
  final List? reviews;

  @override
  State<RewiewPage> createState() => _RewiewPageState();
}

class _RewiewPageState extends State<RewiewPage> {

  List users = [];
  bool isLoading = false;
  List<Widget> reviews = [];

  void getData() async {
    if (this.users.isEmpty) {
      setState(()=>isLoading = true);
      if(widget.reviews!.isEmpty)
        {
          reviews.add(Container(width: double.infinity/2,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 50,horizontal: 30),
              child: Text('У данного мероприятия пока что нет отзывов.',style: Montserrat(color: Blue,size: 15,style: SemiBold)),
          ));
        }else{
        for (int i = 0; i < widget.reviews!.length; i++) {
          this.users.add(await FirebaseFirestore.instance.collection('user').doc(
              widget.reviews![i]['idUser']).get());
          reviews.add(Review(this.users[i],widget.reviews![i]));
          if(i!=widget.reviews!.length-1){
            reviews.add(Container(width: double.infinity,height: 1,color: Blue.withOpacity(0.5)));
          }
        }
      }
      setState(()=>isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size SizePage = MediaQuery.of(context).size;
    getData();

    if (this.isLoading) {
      return Container(color: Grey,
          child: Center(
            child: CircularProgressIndicator(color: Blue)
          ));
    }
    else {
      return Scaffold(backgroundColor: Grey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(SizePage.height / 5),

            ///ШАПКА
            child: AppBar(
              flexibleSpace: Stack(alignment: AlignmentDirectional.topStart,
                children: [
                  Stack(alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Stack(children: [
                        Image.network(widget.data!['photo'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Placholder(MediaQuery
                                .of(context)
                                .size
                                .width, MediaQuery
                                .of(context)
                                .size
                                .height);
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(excursionDef,
                                fit: BoxFit.cover,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width, height: MediaQuery
                                    .of(context)
                                    .size
                                    .height
                            );
                          },
                        ),
                        Container(
                            width: double.infinity, height: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5))
                        ),
                        Container(alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child: Text(widget.data!['name']
                                    .toString()
                                    .toUpperCase(),
                                    style: Montserrat(
                                        color: White, size: 25, style: Bold))),
                              ],
                            )
                        )
                      ]),

                      ///КОЛ-ВО ОТЗЫВОВ
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                                    color: Colors.black.withOpacity(0.5)),
                                child: Stack(children: [
                                  ClipRRect(borderRadius: BorderRadius.all(
                                      Radius.circular(500)),
                                      child: Text(widget.reviews!.length.toString() + " отзыва", style: Montserrat(size: 15, style: SemiBold))
                                  ),
                                ])),
                          ])
                    ],
                  ),
                  Container(
                      height: 70, width: 50,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40))),
                      child: IconButton(icon: Icon(
                        Icons.arrow_back_ios, size: 20, color: White,),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                  ),
                ],),
              leading: Container(),

              centerTitle: false,
              titleSpacing: 0.0,
            )
        ),

        body: ListView(shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(text: "Написать отзыв могут только посетившие экскурсию путешествинники. ", style: Montserrat(size: 13, color:Blue),),
                    TextSpan(text: "Подробнее.", style: Montserrat(style: SemiBold,size: 13, color:Red),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showModalBottomSheet(
                              backgroundColor:White.withOpacity(0),
                              context: context,
                              builder: (BuildContext context) {
                                return ShowDialog();
                              });
                          },),
                  ],
                ),
              ),
            ),
            Container(
              width: SizePage.width,
              decoration: BoxDecoration(
                  boxShadow: [ShadowForContainer()],
                  color: White,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: this.reviews,
              ),
            )
          ],
        ),
      );
    }
  }
}

class Review extends StatelessWidget {
  DocumentSnapshot? user;
  DocumentSnapshot? reviews;
  String month = '';

  Review(this.user,this.reviews){
    if(this.reviews!['date'].toDate().month.toString().length == 1){
      this.month = '0'+this.reviews!['date'].toDate().month.toString();
    }else{
      this.month = this.reviews!['date'].toDate().month.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(children: [
                    PhotoAuthor(this.user!["photo"]),
                    GuideCheck(this.user!["verified"]??false)
                  ]),
                  Container(margin: EdgeInsets.only(left: 15),
                    child: Text(this.user!['name'],style: Montserrat(style: SemiBold,color: Blue,size: 15),),
                  )
                ],
              ),
              Text(this.reviews!['date'].toDate().day.toString()+'.'
                  +this.month+'.'
                  +this.reviews!['date'].toDate().year.toString(),
                  style: Montserrat(style: SemiBold,color: Blue.withOpacity(0.7),size: 15))
            ],
          ),
          Container(margin: EdgeInsets.only(top: 10),
            child: Text(this.reviews!['review'],style: Montserrat(color: Blue,size: 13))
          )
        ],
      )
    );
  }
}