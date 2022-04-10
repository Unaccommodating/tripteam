import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import 'excursion.dart';


class Excursion extends StatefulWidget
{
  const Excursion({
    Key? key,
    this.id = '//',
    this.data,
    this.gid,
    this.type,
  }) : super(key: key);

  final String? id;
  final DocumentSnapshot? data;
  final DocumentSnapshot? gid;
  final DocumentSnapshot? type;

  @override
  State<Excursion> createState() => _ExcursionState();
}

class _ExcursionState extends State<Excursion>{

  Widget getPhotoExcursion(){
    if(widget.data!["photo"] == 'null'){
      return Image.asset(excursionDef,
          fit: BoxFit.cover,
          width: double.infinity, height: MediaQuery.of(context).size.height/10+20
      );
    }else{
      return Image.network(widget.data!["photo"].toString(),
        fit: BoxFit.cover,
        width: double.infinity, height: MediaQuery.of(context).size.height/10+20,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Placholder(double.infinity,MediaQuery.of(context).size.height/10+20);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(excursionDef,
              fit: BoxFit.cover,
              width: double.infinity, height: MediaQuery.of(context).size.height/10+20
          );
        },
      );
    }
  }

  Widget IconMoment(){
    if(widget.data!["moment"]!){
      return Container(width: 17,height: 17,
        margin: EdgeInsets.only(left: 5),
        child: iconLightning,);
    }else{
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/60),
      child: TextButton(onPressed:()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ExcursionPage(widget.id,widget.data,widget.gid,widget.type)));///передаем index экскурсии
      },
        child: Column(
            children: [
              Stack(alignment: Alignment.topRight,
                children: [
                  Stack(alignment: AlignmentDirectional.bottomStart,
                    children: [
                      //КАРТИНКА
                      ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          child: getPhotoExcursion()
                      ),

                      Container(height: 50,
                          width: widget.data!["name"].toString().length.toDouble()*14 +50 >= MediaQuery.of(context).size.width/1.4 ? MediaQuery.of(context).size.width/1.4 : widget.data!["name"].toString().length.toDouble()*14 + 50,
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(30)))
                      ),
                      Container(width: MediaQuery.of(context).size.width/1.4,
                          height: 50,
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //АВАТАР
                              Container(padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Stack(children: [

                                    PhotoAuthor(widget.gid!["photo"]),
                                    GuideCheck(widget.gid!["verified"]??false)

                                  ])),

                              Flexible(child: Text(widget.data!["name"].toString(),style: Montserrat(size: 15,style: SemiBold)))
                            ],
                          )
                      )

                    ],
                  ),

                  ///ДОБАВЛЕНИЕ В ИЗБРАННОЕ
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50),
                    child: IconButton(icon: iconFavoriteWhite,
                        onPressed:(){}
                    ),
                  )
                ],
              ),

              //ОПИСАНИЕ
              Stack(alignment:Alignment.center,
                  children: [

                    Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      height: 68,width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: White,
                          boxShadow: [ShadowForContainer()],
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            width: MediaQuery.of(context).size.width/1.5,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(widget.type!["name"].toString(),style: Montserrat(size: 17,style: SemiBold, color: Color(0xFF55596A))),
                                        IconMoment()
                                      ]),
                                  Flexible(child: Text(widget.data!["description"].toString(),style: Montserrat(size: 14, color: Blue)),)
                                ]
                            ),
                          ),

                          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(widget.data!["time"].toString() + " часа",style: Montserrat(size: 13, style: Regular,color: Blue)),
                                Text('₽ '+ widget.data!["price"].toString(),style: Montserrat(size: 16, style: Bold,color: Blue)),
                              ]
                          )
                        ],
                      ),
                    )

                  ])
            ]
        ),),
    );
  }
}