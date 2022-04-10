import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'dart:math' as math;


import '../assets/style.dart';
import '../assets/finally.dart';
import '../libary/dropdown.dart';

class AddExcursion extends StatefulWidget
{
  const AddExcursion({Key? key}) : super(key: key);

  @override
  State<AddExcursion> createState() => _AddExcursionState();
}

class _AddExcursionState extends State<AddExcursion> {
String cityChoose = '';
String nameExcursion = '';
String typeExcursion = '';
List categoryExcursion = [];
String descriptionExcursion = '';
String includeExcursion = '';
String startPlaceExcursion = '';
String peopleNumExcursion = '';
String priceExcursion = '';
String detailsExcursion = '';
String optionsExcursion = '';
List photoExcursion = [];
List dateExcursion = [];
List dataCity = [];
List dataType = [];

bool cityChooseError = false;
bool nameError = false;
bool typeError= false;
bool categoryError = false;
bool descriptionError = false;
bool includeError = false;
bool startPlaceError = false;
bool peopleNumError = false;
bool priceError = false;
bool dateError = false;
bool isLoading = false;
bool withIcon = true;

List<Map<String, dynamic>> rolesCity = [];
List<Map<String, dynamic>> excType = [];
List tagsList = [];
List tagsListText = [];

void firebaseConnection() async {
 if(this.dataCity.isEmpty)
   {
     setState(()=>isLoading = true);
     await FirebaseFirestore.instance.collection('city').orderBy('name').get().then((snapshot) => {
       dataCity = snapshot.docs
     });

     if(rolesCity.isEmpty){
       dataCity.forEach((city){
         rolesCity.add({'name':city['name'],'id':city.id});
       });
     }

     await FirebaseFirestore.instance.collection('tags').orderBy('name').get().then((snapshot) => {
       tagsList = snapshot.docs
     });

     if(tagsList.isEmpty){
       tagsList.forEach((tags){
         tagsListText.add([tags.id,Text(tags['name'],style: Montserrat(color: Blue),)]);
       });
     }

     await FirebaseFirestore.instance.collection('typeExcursion').orderBy('name').where('name',isNotEqualTo:'Все').get().then((snapshot) => {
       dataType = snapshot.docs
     });

     if(excType.isEmpty){
       dataType.forEach((typeExcursion){
         excType.add({'name':typeExcursion['name'],'id':typeExcursion.id});
       });
     }
     setState(()=>isLoading = false);
   }
}

List mockResults = <TagsList>[
  TagsList('DDDDDDDDDD', '08998'),
  TagsList('EEEEEEE', '08996'),
  TagsList('AAAAAAAA', '08995'),
];

final _chipKey = GlobalKey<ChipsInputState>();

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size SizePage = MediaQuery.of(context).size;
    firebaseConnection();
    if (isLoading == true){
      return Scaffold(
        backgroundColor: Grey,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Blue),
          ),
        )
      );
    }
    else {
      return Stack(
        children: [
          Scaffold(backgroundColor: Grey,

              ///ШАПКА
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(SizePage.height / 15),
                  child: AppBar(backgroundColor: Grey, elevation: 0.0,
                      leading: Container(),
                      flexibleSpace: Stack(alignment: Alignment.topLeft,
                          children: [
                            Container(
                                height: 70, width: 50,
                                decoration: BoxDecoration(color: Blue,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(40))),
                                child: IconButton(icon: Icon(
                                  Icons.arrow_back_ios, size: 20,
                                  color: White,),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                            ),

                          ])
                  )
              ),

              body: ListView(shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: SizePage.width / 15),
                children: [

                  Container(
                    alignment: Alignment.center,
                    child: Text("Добавить экскурсию", style: Montserrat(
                        color: Blue, size: 35, style: SemiBold)),
                    padding: EdgeInsets.symmetric(
                        horizontal: SizePage.width / 20),
                  ),

                  /// CITY SELECT
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichTextMethod('Выберите город', true),

                        TextFieldWithShadow(
                          DropdownFormField<Map<String, dynamic>>(
                              searchTextStyle:Montserrat(color: Blue),
                              emptyText:'Данного города нет',
                              emptyTextStyle:Montserrat(color: Blue,size: 15),

                              decoration: TextFieldDecoration(error: cityChooseError,
                                prefixIcon: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Color(0xFF546eff),
                                    ),
                                    width: 40,
                                    padding: EdgeInsets.all(6),
                                    child: iconEmail
                                ),

                                suffixIcon: Transform.rotate(
                                  angle: -90 * math.pi / 180,
                                  child: Icon(Icons.arrow_back_ios, color: Blue),
                                ),
                              ).InputDecor(),

                              onChanged: (dynamic str) {
                                setState(() => cityChoose = str['id']);
                              },
                              displayItemFn: (dynamic item) =>
                                  Text(
                                    (item ?? {})['name'] ?? '',
                                    style: Montserrat(color: Blue, style: SemiBold),
                                  ),

                              findFn: (dynamic str) async => rolesCity,
                              filterFn: (dynamic item, str) => item['name'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
                              dropdownItemFn: (dynamic item, int position,
                                  bool focused,
                                  bool selected, Function() onTap) =>
                              selected ?
                              ListTile(
                                title: Text(item['name'],style: Montserrat(color: Blue,size: 15),),
                                tileColor:Blue.withOpacity(0.5),
                                onTap: onTap,
                              ):
                              ListTile(
                                title: Text(item['name'],style: Montserrat(color: Blue,size: 15),),
                                tileColor: White,
                                onTap: onTap,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///EXC NAME
                  Container(margin: EdgeInsets.only(top: 50),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                        RichTextMethod('Название экскурсии', true),

                        TextFieldWithShadow(
                            TextField(
                                maxLines: null,
                                maxLength: 50,
                                keyboardType: TextInputType.multiline,
                                style: Montserrat(color: Blue),
                                onChanged: (String value) {
                                  setState(() {
                                    nameExcursion = value;
                                    nameError = false;
                                  });
                                },
                                decoration: TextFieldDecoration(error: nameError, prefixIcon: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Color(0xFF546eff),
                                    ),
                                    width: 40,
                                    padding: EdgeInsets.all(6),
                                    child: iconEmail
                                ),
                                ).InputDecor()
                            )
                        )
                      ])
                  ),

                  /// TYPE SELECT
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      RichTextMethod('Выберите тип экскурсии', true),

                        TextFieldWithShadow(
                          DropdownFormField<Map<String, dynamic>>(
                            searchTextStyle:Montserrat(color: Blue),
                            emptyText:'Данный тип не найден',
                            emptyTextStyle:Montserrat(color: Blue,size: 15),

                            decoration: TextFieldDecoration(error: typeError, prefixIcon: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Color(0xFF546eff),
                                ),
                                width: 40,
                                padding: EdgeInsets.all(6),
                                child: iconEmail
                            ),
                              suffixIcon: Transform.rotate(
                                angle: -90 * math.pi / 180,
                                child: Icon(Icons.arrow_back_ios, color: Blue),
                              ),
                            ).InputDecor(),

                            onChanged: (dynamic str) {
                              setState(() => typeExcursion = str['id']);
                            },
                            displayItemFn: (dynamic item) =>
                                Text(
                                  (item ?? {})['name'] ?? '',
                                  style: Montserrat(color: Blue, style: SemiBold),
                                ),

                            findFn: (dynamic str) async => excType,
                            filterFn: (dynamic item, str) => item['name'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
                            dropdownItemFn: (dynamic item, int position,
                                bool focused,
                                bool selected, Function() onTap) =>
                            selected ?
                            ListTile(
                              title: Text(item['name'],style: Montserrat(color: Blue,size: 15),),
                              tileColor:Blue.withOpacity(0.5),
                              onTap: onTap,
                            ):
                            ListTile(
                              title: Text(item['name'],style: Montserrat(color: Blue,size: 15),),
                              tileColor: White,
                              onTap: onTap,
                            )
                        ),
                      )
                      ],
                    ),
                  ),

                  Container(margin: EdgeInsets.only(top: 50),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                        RichTextMethod('Выберите теги', true),
                        TextFieldWithShadow(
                          ChipsInput(
                              textStyle:Montserrat(color: Blue),
                            decoration: TextFieldDecoration().InputDecor(),
                            key: _chipKey,
                            findSuggestions: (String query) {
                              if (query.isNotEmpty) {
                                var lowercaseQuery = query.toLowerCase();
                                return mockResults.where((tag) {
                                  return tag.name
                                      .toLowerCase()
                                      .contains(query.toLowerCase());
                                }).toList(growable: false)
                                  ..sort((a, b) => a.name
                                      .toLowerCase()
                                      .indexOf(lowercaseQuery)
                                      .compareTo(
                                      b.name.toLowerCase().indexOf(lowercaseQuery)));
                              }
                              return mockResults;
                            },
                            onChanged: (data) {
                              print(data);
                            },
                            chipBuilder: (context, state, dynamic tag) {
                              return InputChip(
                                deleteIconColor:White,
                                backgroundColor: Blue,
                                key: ObjectKey(tag.id),
                                label: Text(tag.name, style: Montserrat(color: White, size: 14),),
                                onDeleted: () => state.deleteChip(tag),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              );
                            },
                            suggestionBuilder: (context, state, dynamic tag) {
                              return Container(
                                  color: Color(0xFFC1C1C1),
                                  child: ListTile(
                                    textColor: Blue,
                                    key: ObjectKey(tag.id),
                                    title: Text(tag.name,style: Montserrat(color: Blue,size: 15)),
                                    onTap: () => state.selectSuggestion(tag),
                                  )
                              );
                            },
                          ),
                        )
                      ])
                  ),

                  ///DISCRIPTION
                  Container(margin: EdgeInsets.only(top: 50),
                      child:
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        RichTextMethod('Краткое описание', true),

                        TextFieldWithShadow(
                            TextField(
                                maxLines: null,
                                minLines: 3,
                                maxLength: 250,
                                keyboardType: TextInputType.multiline,
                                style: Montserrat(color: Blue),
                                onChanged: (String value) {
                                  setState(() {
                                    descriptionExcursion = value;
                                  });
                                },
                                decoration: TextFieldDecoration(error: descriptionError).InputDecor()
                            )
                        ),
                      ])
                  ),

                  /// WHAT'S INCLUDE

                  Container(margin: EdgeInsets.only(top: 50),
                      child:
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        RichTextMethod('Что включено', true),

                        TextFieldWithShadow(
                            TextField(
                                maxLines: null,
                                maxLength: 250,
                                minLines: 3,
                                keyboardType: TextInputType.multiline,
                                style: Montserrat(color: Blue),
                                onChanged: (String value) {
                                  setState(() {
                                    includeExcursion = value;
                                    includeError = false;
                                  });
                                },
                                decoration: TextFieldDecoration(error: includeError).InputDecor()
                            )
                        ),
                      ])
                  ),

                  /// PLACE
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child:
                    Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichTextMethod('Место сбора', true),
                        TextFieldWithShadow(
                          TextField(
                              style: Montserrat(color: Blue),
                              maxLines: null,
                              maxLength: 100,
                              keyboardType: TextInputType.multiline,
                              onChanged: (String value) {
                                setState(() {
                                  startPlaceExcursion = value;
                                  startPlaceError = false;
                                });
                              },
                              decoration: TextFieldDecoration(error: includeError, prefixIcon: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Color(0xFF546eff),
                                  ),
                                  width: 40,
                                  padding: EdgeInsets.all(6),
                                  child: iconEmail
                              ),).InputDecor()
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// PEOPLE NUM
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: 
                    Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichTextMethod('Размер группы', true),
                        TextFieldWithShadow(
                          TextField(
                              style: Montserrat(color: Blue),
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                              onChanged: (String value) {
                                setState(() {
                                  peopleNumExcursion = value;
                                  peopleNumError = false;
                                });
                              },
                            decoration: TextFieldDecoration(error: peopleNumError,
                                prefixIcon: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Color(0xFF546eff),
                                    ),
                                    width: 40,
                                    padding: EdgeInsets.all(6),
                                    child: iconEmail
                                )).InputDecor()
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///PRICE
                  Container(margin: EdgeInsets.only(top: 50),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                        RichTextMethod('Стоймость за человека', true),

                        TextFieldWithShadow(
                            TextField(
                                style: Montserrat(color: Blue),
                                onChanged: (String value) {
                                  setState(() {
                                    priceExcursion = value;
                                    priceError = false;
                                  });
                                },
                                decoration: TextFieldDecoration(error: priceError, prefixIcon: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Color(0xFF546eff),
                                    ),
                                    width: 40,
                                    padding: EdgeInsets.all(6),
                                    child: iconEmail
                                ),
                                ).InputDecor()
                            )
                        )
                      ])
                  ),

                  /// DETAILS
                  Container(margin: EdgeInsets.only(top: 50),
                      child:
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        RichTextMethod('Организационные детали'),

                        TextFieldWithShadow(
                            TextField(
                                maxLines: null,
                                maxLength: 250,
                                minLines: 3,
                                keyboardType: TextInputType.multiline,
                                style: Montserrat(color: Blue),
                                onChanged: (String value) {
                                  setState(() {
                                    detailsExcursion = value;
                                  });
                                },
                                decoration: TextFieldDecoration().InputDecor()
                            )
                        ),
                      ])
                  ),

                  /// OPTIONS
                  Container(margin: EdgeInsets.only(top: 50),
                      child:
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        RichTextMethod('Дополнительные услуги'),

                        TextFieldWithShadow(
                            TextField(
                                maxLines: null,
                                maxLength: 250,
                                minLines: 3,
                                keyboardType: TextInputType.multiline,
                                style: Montserrat(color: Blue),
                                onChanged: (String value) {
                                  setState(() {
                                    optionsExcursion = value;
                                  });
                                },
                                decoration: TextFieldDecoration().InputDecor()
                            )
                        ),
                      ])
                  ),

                  /// BUTTON
                  Container(
                    margin: EdgeInsets.only(top: 50),
                      height: SizePage.height / 4.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          ///КНОПКА ВОЙТИ
                          TextButton(onPressed: () {},
                              child: Container(width: SizePage.width -
                                  SizePage.width / 15 * 2,
                                  height: 50,
                                  decoration: BoxDecoration(color: Blue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(500))),
                                  child: Center(child: Text("Добавить",
                                      style: Montserrat(
                                          style: SemiBold, size: 19)),)
                              )
                          ),

                          ///ТЕКСТ
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizePage.width / 5),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "При входе, вы принимаете условия пользования сервисом. ",
                                    style: Montserrat(
                                        style: SemiBold, size: 13, color: Blue),
                                  ),
                                  TextSpan(
                                    text: "Подробнее.",
                                    style: Montserrat(
                                        style: SemiBold, size: 13, color: Red),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showModalBottomSheet(
                                            backgroundColor: White.withOpacity(
                                                0),
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ShowDialog();
                                            });
                                      },
                                  ),
                                ],
                              ),
                            ),
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
        ],
      );
    }
  }
}

class TagsList {
  final String name;
  final String id;

  const TagsList(this.name, this.id,);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TagsList &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return id;
  }
}
