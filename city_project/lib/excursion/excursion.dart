import 'dart:ui';
import 'package:card_swiper/card_swiper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;

import '../assets/style.dart';
import '../assets/finally.dart';
import 'reviews.dart';


class ExcursionPage extends StatefulWidget
{
  const ExcursionPage(this.id,
      this.data,
      this.gid,
      this.type,{
    Key? key,
  }) : super(key: key);

  final String? id;
  final DocumentSnapshot? data;
  final DocumentSnapshot? gid;
  final DocumentSnapshot? type;

  @override
  State<ExcursionPage> createState() => _ExcursionPageState();
}

class _ExcursionPageState extends State<ExcursionPage> {

  List? photos;
  List? reviews;
  bool isLoading = false;

  void getData() async {
    if(this.photos == null) {
      setState(() {isLoading = true;});
      await FirebaseFirestore.instance.collection('photoExcursion').where("idExcursion",isEqualTo:widget.id).get().then((snapshot) => {
        if(!snapshot.docs.isEmpty) this.photos = snapshot.docs[0]['photo']
        else this.photos = [null]
      });

      await FirebaseFirestore.instance.collection('reviewsExcursion').where("idExcursion",isEqualTo:widget.id).get().then((snapshot) => {
        this.reviews = snapshot.docs
      });
      setState(() {isLoading = false;});
      }
  }

  @override
  Widget build(BuildContext context) {
    Size SizePage = MediaQuery.of(context).size;
    getData();

    double rating = (widget.data!["rating"][0]/widget.data!["rating"][1]);

    if (this.isLoading){
      return Container(color: Grey,
          child: Center(
              child: CircularProgressIndicator(color: Blue)
          )
      );
    }
    else{
      return Scaffold(backgroundColor: Grey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(SizePage.height / 5),

            ///ШАПКА
            child: AppBar(flexibleSpace: Stack(alignment: AlignmentDirectional.topStart,
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
                          return Placholder(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(excursionDef,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height
                          );
                        },
                      ),
                      Container(width: double.infinity, height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5))
                      ),
                      Container(alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: Text(widget.data!['name'].toString().toUpperCase(),
                                  style: Montserrat(color: White, size: 25, style: Bold))),
                            ],
                          )
                      )
                    ]),

                    ///АВТОР
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                        children:[
                          Container(padding: EdgeInsets.symmetric(horizontal: 15),
                              height: 50, alignment: Alignment.center,
                              decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                                  color: Colors.black.withOpacity(0.5)),
                              child: Stack(children: [
                                PhotoAuthor(widget.gid!['photo']),
                                GuideCheck(widget.gid!['verified'])
                              ])),
                          Container(color: Colors.black.withOpacity(0.5),height: 50,
                            padding: EdgeInsets.only(right: 15),
                            alignment: Alignment.center,
                            child: Text(widget.gid!['name'],style: Montserrat(size: 15,style: SemiBold))
                          )
                        ])
                  ],
                ),
                Container(
                    height: 70,width: 50,
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
                    child: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: White,),
                        onPressed: (){
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
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          children: [
            ///РЕЙТИНГ И ОТЗЫВЫ
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RatingStars(
                      value: rating,
                      starBuilder: (index, color) => Icon(Icons.star, color: color),
                      starSize: 23,
                      maxValueVisibility: false,
                      valueLabelVisibility: false,
                      animationDuration: Duration(milliseconds: 1000),
                      starOffColor: Colors.black.withOpacity(0.1),
                      starColor: Red,
                    ),
                    Container(child: Text(rating.toStringAsFixed(1),style: Montserrat(color: Blue,size: 18,style: SemiBold)),
                      margin: EdgeInsets.only(left: 15),
                    )
                  ],),

                TextButton(onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RewiewPage(widget.data,reviews)));
                },
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(reviews!.length.toString() + " отзыва",style: Montserrat(color: Color(0xFFF48494a),size: 16,style: Bold)),
                        Icon(Icons.arrow_forward_ios, color: Color(0xFFF48494a))
                      ],)
                ),
              ],
            ),

            ///ОПИСАНИЕ
            Text(widget.data!['description'], style: Montserrat(color: Blue,size: 15)),

            ///ОСНОВНАЯ ИНФОРМАЦИЯ
            Container(margin: EdgeInsets.only(top: 20,bottom: 30),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [ShadowForContainer()],
                        color: White,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.type!['name'], style: Montserrat(color: Blue,size: 16,style: Bold)),
                              Text(widget.data!['time'].toString() + " часа", style: Montserrat(color: Blue,size: 16))
                            ]),
                            margin: EdgeInsets.only(bottom: 20)),
                        Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Тип передвижения:', style: Montserrat(color: Blue,size: 14,style: SemiBold)),
                                Container(child: Text(widget.data!['moveType'].join(', '), style: Montserrat(color: Blue,size: 14,)),
                                  width: MediaQuery.of(context).size.width/2-40),
                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Размер группы:', style: Montserrat(color: Blue,size: 14,style: SemiBold)),
                                Container(child: Text('до ' + widget.data!['groupSize'].toString() + " человек", style: Montserrat(color: Blue,size: 14,)),
                                  width: MediaQuery.of(context).size.width/2-40),
                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Время начала:', style: Montserrat(color: Blue,size: 14,style: SemiBold)),
                                Container(child: Text(widget.data!['startTime'], style: Montserrat(color: Blue,size: 14,)),
                                  width: MediaQuery.of(context).size.width/2-40),
                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Место встречи:', style: Montserrat(color: Blue,size: 14,style: SemiBold)),
                                Container(child: Text(widget.data!['meetPoint'], style: Montserrat(color: Blue,size: 14,)),
                                  width: MediaQuery.of(context).size.width/2-40),
                              ],
                            )
                          ],
                        ),
                        Container(width: double.infinity,height: 0.5,color: Blue.withOpacity(0.5),
                          margin: EdgeInsets.symmetric(vertical: 15),
                        ),
                        RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "₽ " + widget.data!['price'].toString(), style: Montserrat(style: Bold,size: 17, color:Blue)),
                              TextSpan(text: " за человека", style: Montserrat(size: 16, color:Blue)),
                            ])
                        ),

                        Container(margin: EdgeInsets.only(top: 10),
                            child: TextButton(onPressed: (){},
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(color: Red,
                                        borderRadius: BorderRadius.all(Radius.circular(500))),
                                    child: Center(child: Text("Бронировать", style: Montserrat(style: SemiBold,size: 19,color: White)))
                                )
                            )
                        )
                      ],
                    )
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      boxShadow: [ShadowForContainer()],
                      color: Blue,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                  ),
                  child: Column(
                    children: [
                      CheckMoment(widget.data!['moment'])
                    ],
                  ),
                )
              ],
            )),

            ///ПОДРОБНАЯ ИНФОРМАЦИЯ
            Container(margin: EdgeInsets.only(bottom: 15),
              child: Text("Подробнее об экскурсии", style: Montserrat(style: Bold,size: 16,color: Blue))),

            Card("Что включено"),
            Container(width: double.infinity,height: 0.5,color: Blue.withOpacity(0.5)),
            Card("Дополнительные услуги"),
            Container(width: double.infinity,height: 0.5,color: Blue.withOpacity(0.5)),
            Card("Организационные детали"),
            Container(width: double.infinity,height: 0.5,color: Blue.withOpacity(0.5)),
            Card("Правила экскурсии"),

            ///ФОТОГРАФИИ
            PhotosBlock(this.photos)
          ],
        ),
      );
    }
  }

  Widget CheckMoment(bool moment){
    if(moment){
      return Row(
        children: [
          Container(margin: EdgeInsets.only(right: 10),
              child: iconLightning),
          Column(children: [
            Text("Мгновенное бронирование", style: Montserrat(style: Bold,size: 14,color: White)),
            Container(width: MediaQuery.of(context).size.width/1.4,
              child: Text("Без ожидания ответа от гида", style: Montserrat(size: 13,color: White)),
            )
          ],
            crossAxisAlignment: CrossAxisAlignment.start,)
        ],
      );
    }else{
      return Row(
        children: [
          Container(margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.access_time_rounded,color: Red,)),
          Column(children: [
            Text("Ожидание", style: Montserrat(style: Bold,size: 14,color: White)),
            Container(width: MediaQuery.of(context).size.width/1.4,
              child: Text("Вы должны будете ожидать ответа гида", style: Montserrat(size: 13,color: White)),
            )
          ],
            crossAxisAlignment: CrossAxisAlignment.start,)
        ],
      );
    }
  }

  Widget GuideCheck(bool check){
    if(check)
    {
      return Container(width: 40,height: 40,
          alignment: Alignment.bottomRight,
          child: Container(width: 15,height: 15,
              child: iconConfirmation)
      );
    }
    else
    {
      return Container();
    }
  }
}


class Card extends StatelessWidget {
  String title = 'null';
  Card(this.title);

  Widget buildList() {
    return Container(padding: EdgeInsets.only(bottom: 20,left: 5,right: 5),
        child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            style: Montserrat(size: 15,color: Blue)
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      theme: ExpandableThemeData(hasIcon: false),
      header: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(this.title, style: Montserrat(style: SemiBold,size: 16,color: Blue)),
              ExpandableIcon(
                theme: const ExpandableThemeData(
                  expandIcon: Icons.arrow_forward_ios,
                  collapseIcon: Icons.arrow_forward_ios,
                  iconRotationAngle: math.pi / 2,
                  iconColor: Blue,
                ),
              ),
            ],
          ),
        ),
      ),
      collapsed: Container(),
      expanded: buildList(),
    );
  }
}

class PhotosBlock extends StatelessWidget {
  PhotosBlock(this.images);
  List? images;
  @override
  Widget build(BuildContext context) {
    if(images![0] == null) return Container();
    else{
      return Container(padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 10,bottom: 25),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: [ShadowForContainer()],
              color: White,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: ifMoreOne(context)
      );
    }
  }

  Widget ifMoreOne(context){
    if(this.images!.length > 1)
      {
        return Row(
          children: [
            TextButton(onPressed:()=>showPhotoDialog(context),
                child: ClipRRect(borderRadius: BorderRadius.circular(5),
                  child: Image.network(this.images![0],fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width/3*1.5+15,
                    width: MediaQuery.of(context).size.width/2.5,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Placholder(MediaQuery.of(context).size.width/2.5, MediaQuery.of(context).size.width/3*1.5+15);
                    },
                  ),
                )
            ),
            ifTwoMore(context)
          ],
        );
      }
    else{
      return TextButton(onPressed:()=>showPhotoDialog(context),
          child: ClipRRect(borderRadius: BorderRadius.circular(5),
            child: Image.network(this.images![0],fit: BoxFit.cover,
              height: MediaQuery.of(context).size.width/3*1.5+15,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Placholder(MediaQuery.of(context).size.width, MediaQuery.of(context).size.width/3*1.5+15);
              },
            ),
          )
      );
    }
  }

  Widget ifTwoMore(context){
    if(this.images!.length > 2){
      return Column(children: [
        TextButton(onPressed:()=>showPhotoDialog(context),
            child: ClipRRect(borderRadius: BorderRadius.circular(5),
              child: Image.network(this.images![1],fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width/3*1.5/2,
                width: MediaQuery.of(context).size.width/2.5,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Placholder(MediaQuery.of(context).size.width/2.5, MediaQuery.of(context).size.width/3*1.5/2);
                },
              ),
            )
        ),
        TextButton(onPressed:()=>showPhotoDialog(context),
            child: Stack(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(5),
                  child: Image.network(this.images![2],fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width/3*1.5/2,
                    width: MediaQuery.of(context).size.width/2.5,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Placholder(MediaQuery.of(context).size.width/2.5, MediaQuery.of(context).size.width/3*1.5/2);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width/3*1.5/2,
                  width: MediaQuery.of(context).size.width/2.5,
                  child: Text('+'+(images!.length-2).toString(),style: Montserrat(size: 40,style: SemiBold)),
                )
              ],
            )
        )
      ]);
    }else{
      return TextButton(onPressed:()=>showPhotoDialog(context),
          child: ClipRRect(borderRadius: BorderRadius.circular(5),
            child: Image.network(this.images![1],fit: BoxFit.cover,
              height: MediaQuery.of(context).size.width/3*1.5+15,
              width: MediaQuery.of(context).size.width/2.5,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Placholder(MediaQuery.of(context).size.width/2.5, MediaQuery.of(context).size.width/3*1.5+15);
              },
            ),
          )
      );
    }
  }

  void showPhotoDialog(context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PhotoCarousel(this.images);
      },
    );
  }

}


class PhotoCarousel extends StatefulWidget {

  PhotoCarousel(this.images,{Key? key}) : super(key: key);
  final List? images;
  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  int indexNow = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Swiper(
          onIndexChanged:(index)=>setState(()=>indexNow = index+1),
          itemBuilder: (context, index) {
            return Container(width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: InteractiveViewer(
                child: Image.network(widget.images![index],
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator(color: White));
                    }
                ),
              )
            );
          },
          curve: Curves.decelerate,
          indicatorLayout: PageIndicatorLayout.NONE,
          itemCount: widget.images!.length,
        ),
        Container(height: MediaQuery.of(context).size.height/13,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(onPressed:(){Navigator.pop(context);},
                child:Icon(Icons.arrow_back_ios, color: White,)
              ),

              Container(padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Фотографии с экскурсии', style: Montserrat(style: Bold,size:17)),
                    Text(this.indexNow.toString() + ' из ' + widget.images!.length.toString(), style: Montserrat(style: SemiBold,size:15))
                  ],
                ),
              )
            ]
          )
        )
      ],
    );
  }
}