import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:lan_code/profil/personalArea.dart';
import 'package:lan_code/service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'assets/finally.dart';
import 'assets/style.dart';

import 'excursion/city.dart';
import 'profil/notAuthProfil.dart';

class Navigation extends StatefulWidget {
  const Navigation({this.index = 0,Key? key}) : super(key: key);
  final int? index;
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late int page = widget.index ?? 0;

  String idCity = '';
  DocumentSnapshot? data;
  bool isLoading = false;
  List types = [];
  List user = [];
  bool isLoadingNavigator = false;

  ///Получаем данные города
  void getDataCity() async {
    if(this.idCity == '') {
      setState(()=>isLoading = true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(()=>this.idCity = prefs.getString('city') ?? 'EZbunvBvO0EJEVg29Qt9');
      this.data = await FirebaseFirestore.instance.collection('city').doc(idCity).get();
      await FirebaseFirestore.instance.collection('typeExcursion').get().then((snapshot) => {
        setState(()=>this.types = snapshot.docs)
      });
      setState(()=>isLoading = false);
    }
  }

  void getDataUser(String? idUser) async {
    if(this.user.isEmpty){
      await FirebaseFirestore.instance.collection('user').where('id',isEqualTo:idUser).get().then((snapshot){
        setState(() {this.user = snapshot.docs;});
      });
      await Future.delayed(const Duration(seconds: 600));
      setState(()=>this.user = []);
    }
  }

  @override
  Widget build(BuildContext context) {
    getDataCity();

    final UserMeth? user = Provider.of<UserMeth?>(context);
    final bool isLoggedIn = user != null;
    if(isLoggedIn) {
      getDataUser(user.id?.trim());
      if(this.user.isEmpty) return Scaffold(body:Center(child: CircularProgressIndicator(color: Blue)));
      else{
        if(this.user.first['guidePermit']){
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
                backgroundColor: Blue,
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
              bottomNavigationBar: BubbleBottomBar(
                  backgroundColor: Blue,
                  hasNotch: true,
                  fabLocation: BubbleBottomBarFabLocation.end,
                  opacity: .2,
                  currentIndex: page,
                  onTap: (index) {setState(()=>page = index!);},
                  elevation: 8,
                  tilesPadding: EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  items: barItem()
              ),

              body: this.isLoading?Center(child: CircularProgressIndicator(color: Blue)):
              WidgetPages(page,this.user)
          );
        }else{
          return Scaffold(
              bottomNavigationBar: BubbleBottomBar(
                  backgroundColor: Blue,
                  hasNotch: true,
                  opacity: .2,
                  currentIndex: page,
                  onTap: (index) {setState(()=>page = index!);},
                  elevation: 8,
                  tilesPadding: EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  items: barItem()
              ),

              body: this.isLoading?Center(child: CircularProgressIndicator(color: Blue)):
              WidgetPages(page,this.user)
          );
        }
      }
    }else{
      return Scaffold(
          bottomNavigationBar: BubbleBottomBar(
            backgroundColor: Blue,
            hasNotch: true,
            opacity: .2,
            currentIndex: page,
            onTap: (index) {setState(()=>page = index!);},
            elevation: 8,
            tilesPadding: EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            items: barItem()
          ),

          body: this.isLoading?Center(child: CircularProgressIndicator(color: Blue)):
          WidgetPages(page)
      );
    }
  }

  List<BubbleBottomBarItem> barItem(){
    return [
      BubbleBottomBarItem(
        backgroundColor: Colors.deepPurple,
        icon: iconMenuExcursion,
        activeIcon: iconMenuExcursion,
        title: Text("Экскурсии",style: Montserrat(color: White,size: 13),),
      ),
      BubbleBottomBarItem(
          backgroundColor: Colors.deepPurple,
          icon: iconMenuTickets,
          activeIcon: iconMenuTickets,
          title: Text("Мои билеты",style: Montserrat(color: White,size: 13),)),
      BubbleBottomBarItem(
          backgroundColor: Colors.deepPurple,
          icon: iconMenuActivity,
          activeIcon: iconMenuActivity,
          title: Text("Активность",style: Montserrat(color: White,size: 13),)),
      BubbleBottomBarItem(
          backgroundColor: Colors.deepPurple,
          icon: iconMenuProfil,
          activeIcon: iconMenuProfil,
          title: Text("Профиль",style: Montserrat(color: White,size: 13),)),
    ];
  }

  Widget WidgetPages(int page, [List? user]){
    if(page == 0) return City(this.idCity,this.data,this.types);
    else if(page ==1) return Container(width: double.infinity, height: double.infinity, color:Grey, child: Center(child: Text("Мои билеты",style: Montserrat(color:Blue,size: 40,style: SemiBold))));
    else if(page ==2) return Container(width: double.infinity, height: double.infinity, color:Grey, child: Center(child: Text("Активность",style: Montserrat(color:Blue,size: 40,style: SemiBold))));
    else if(page == 3) {
      if (user != null) return personalArea(this.user.first);
      else return NotAuthProfil();
    }
    else return Container(width: double.infinity, height: double.infinity, color:Grey, child: Center(child: Text("ОШИБКА",style: Montserrat(color:Blue,size: 40,style: SemiBold))));
  }
}
