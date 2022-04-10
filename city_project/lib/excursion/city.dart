import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import 'search.dart';
import 'excursionClass.dart';


class City extends StatefulWidget
{
  const City(this.idCity, this.data, this.types,{Key? key}) : super(key: key);
  final String? idCity;
  final DocumentSnapshot? data;
  final List? types;

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size SizePage = MediaQuery.of(context).size;

    return Scaffold(backgroundColor: Grey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizePage.height / 5),

          ///ШАПКА
          child: AppBar(flexibleSpace: Stack(children: [
            Image.network(widget.data!['photo'],
              fit: BoxFit.cover,
              width: double.infinity,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Placholder(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
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
                    Flexible(child: Text(
                        widget.data!['name'].toString().toUpperCase(),
                        style: Montserrat(
                            color: White, size: 35, style: SemiBold)),),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Serch()));
                    },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Blue, borderRadius: BorderRadius.all(
                              Radius.circular(20))),
                          child: iconMagnifier,
                        ))
                  ],
                )
            )
          ]),
            centerTitle: false,
            titleSpacing: 0.0,
            bottom: TabBar(
              controller: _tabController,
              tabs: Tabs(),
              isScrollable: true,
              indicatorColor: White,
            ),
          )
      ),

      body: TabBarView(
        controller: _tabController,
        children: RequestExcursion(),
      ),
    );
  }

  List<Widget> RequestExcursion(){
    List<Widget> widgets = [];
    for(int i = 0; i < widget.types!.length; i++){
      widgets.add(ExcursionPagination(widget.types![i].id,widget.idCity!));
    }
    return widgets;
  }


  List<Widget> Tabs()
  {
    List<Widget> tabs = [];
    for(int i = 0; i < widget.types!.length; i++) {
      tabs.add(Tab(child: Text(widget.types![i]['name'].toString(),style: Montserrat(color:White,size: 15))),);
    }
    return tabs;
  }
}

class ExcursionPagination extends StatelessWidget {

  String idCity = '';
  String idType = '';
  List dataExcursion = [];
  List dataGid = [];
  List dataType = [];

  ExcursionPagination(this.idType, this.idCity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InfiniteList<Widget>(
          padding: const EdgeInsets.all(0),
          itemLoader: itemLoader,
          builder: InfiniteListBuilder<Widget>(
            empty: (context) => WaitDialog(iLoading,"В данном городе пока что нет активных мероприятий"),
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
      ),
    );
  }



  Future<List<Widget>?> itemLoader(int limit, {int start = 0}) async {

    if(idType == '000'){
      await FirebaseFirestore.instance.collection('excursion').where("idCity",isEqualTo:this.idCity).get().then((snapshot) => {
        this.dataExcursion = snapshot.docs
      });
    }else{
      await FirebaseFirestore.instance.collection('excursion').where("idCity",isEqualTo:this.idCity).where("type",isEqualTo:this.idType).get().then((snapshot) => {
        this.dataExcursion = snapshot.docs
      });
    }

    for (int i = 0; i < this.dataExcursion.length; i++) {
      this.dataGid.add(await FirebaseFirestore.instance.collection('user').doc(dataExcursion[i]['idGid']).get());
      this.dataType.add(await FirebaseFirestore.instance.collection('typeExcursion').doc(dataExcursion[i]['type']).get());
    }

    List<Widget> entertainmentWidgets = [];
    for (int i = 0; i < this.dataExcursion.length; i++) {
      entertainmentWidgets.add(
          Excursion(
            id: this.dataExcursion[i].id,
            data: this.dataExcursion[i],
            gid: this.dataGid[i],
            type: this.dataType[i],
          )
      );
    }
    limit = 5;
    if (start >= entertainmentWidgets.length) return null;
    if (false) throw Exception();
    if (false) throw InfiniteListException();
    if (entertainmentWidgets.length - start > 0 && entertainmentWidgets.length - start  < limit){
      int count = entertainmentWidgets.length - start;

      return List.generate(count, (index) {
        return entertainmentWidgets[index+start];
      });
    }

    return List.generate(limit, (index) {
      return entertainmentWidgets[index+start];
    });
  }
}