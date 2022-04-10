import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../navigation.dart';


class Serch extends StatefulWidget
{
  const Serch({Key? key}) : super(key: key);

  @override
  State<Serch> createState() => _SerchState();
}

class _SerchState extends State<Serch> {

  String serchCity = '';

  @override
  Widget build(BuildContext context)
  {
    Size SizePage = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: Grey,

        ///ШАПКА
        appBar: PreferredSize(preferredSize: Size.fromHeight(SizePage.height/5),
            child: AppBar(backgroundColor:Grey,
                leading: Container(),
                flexibleSpace:Stack(alignment: Alignment.topLeft,
                    children: [
                      Column(children: [
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          alignment: Alignment.center,
                          child: Text("Поиск",style: Montserrat(color:Blue,size: 40,style: Bold)),
                          padding: EdgeInsets.symmetric(horizontal: SizePage.width/20),
                        ),

                        Container(padding: EdgeInsets.symmetric(horizontal: SizePage.width/20),
                            margin: EdgeInsets.only(top: 20),
                            child: TextFieldWithShadow(
                                TextField(style: Montserrat(color:Blue,size: 15),
                                  decoration: TextFieldDecoration(
                                    hintText: 'Введите название города',
                                    prefixIcon: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Blue,
                                        ),
                                        width: 40,
                                        padding: EdgeInsets.all(6),
                                        child: iconMagnifier
                                    ),
                                  ).InputDecor(),
                                  onChanged: (String value)
                                  {
                                    setState(()=>this.serchCity = value);
                                  },
                                )
                            ),
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


        ///ТЕЛО
        body: CityPagination(this.serchCity)
    );
  }
}

class CityPagination extends StatefulWidget {

  String request = '';
  CityPagination(this.request);

  @override
  State<CityPagination> createState() => _CityPaginationState();
}

class _CityPaginationState extends State<CityPagination> {
  List data = [];

  @override
  Widget build(BuildContext context) {
    return InfiniteList<Widget>(
        padding: const EdgeInsets.all(0),
        itemLoader: itemLoader,
        builder: InfiniteListBuilder<Widget>(
          empty: (context) => WaitDialog(iLoading,"Города не загруженны"),
          loading: (context) => Center(child: CircularProgressIndicator(color: Blue,)),
          success: (context, item) => item,
          error: (context, retry, error) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(error.toString(),style: Montserrat(color: Blue,size: 15,style: SemiBold),),
                TextButton(onPressed: retry,
                    child: Text('Повторить',style: Montserrat(color: Red,size: 17,style: SemiBold),))
              ],
            ));
          },
        ),
        errorLoader: (context, retry, error) => TextButton(onPressed: retry,
            child: Text('Повторить',style: Montserrat(color: Red,size: 17,style: SemiBold),)),

        bottomLoader: (context) => Center(child: Container(padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(color: Blue))
        )
      //errorLoader: (context, retry, error) => _ErrorLoader(retry: retry),
    );
  }

  Future<List<Widget>?> itemLoader(int limit, {int start = 0}) async {
    await FirebaseFirestore.instance.collection('city').get().then((snapshot) => {
      setState(()=>this.data = snapshot.docs)
    });

    print(widget.request);

    List<Widget> city = [];
    for (int i = 0; i < this.data.length; i++) {
      city.add(CardCity(this.data[i].id, this.data[i]['name'],this.data[i]['photo']));
    }
    limit = 5;
    if (start >= city.length) return null;
    if (false) throw Exception();
    if (false) throw InfiniteListException();
    if (city.length - start > 0 && city.length - start  < limit){
      int count = city.length - start;
      return List.generate(count, (index) {
        return city[index+start];
      });
    }

    return List.generate(limit, (index) {
      return city[index+start];
    });
  }
}


class CardCity extends StatelessWidget{
  String name = '';
  String id = '';
  String photo = '';

  CardCity(this.id , this.name, this.photo);

  @override
  Widget build(BuildContext context) {

    return Container(margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/20-5, 0, MediaQuery.of(context).size.width/20-5, 10),
      child: TextButton(onPressed:() async {
        /// ЗАПИСАТЬ ID ГОРОДА
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('city', this.id);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> Navigation()), (route) => false);
      },
        child: Stack(alignment: AlignmentDirectional.bottomStart,
            children: [
              //КАРТИНКА
              ClipRRect(borderRadius: BorderRadius.circular(30),
                child: Image.network(this.photo,fit: BoxFit.cover,
                  width: double.infinity, height: MediaQuery.of(context).size.height/7,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Placholder(double.infinity, MediaQuery.of(context).size.height/7);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(excursionDef,
                        fit: BoxFit.cover,
                        width: double.infinity, height: MediaQuery.of(context).size.height/10+20
                    );
                  },
                ),


              ),
              //НАЗВАНИЕ
              Stack(alignment: Alignment.center,
                  children: [
                    Container(height: 40,width: MediaQuery.of(context).size.width/3 + this.name.length.toDouble()*11,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),topRight: Radius.circular(30)))
                    ),
                    Container(
                      child: Text(this.name.toUpperCase(),style: Montserrat(size: 25,style: Bold)),
                    )
                  ]),
            ]
        ),),
    );
  }
}