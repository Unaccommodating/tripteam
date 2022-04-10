import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tags>? selectedTagsList = [];
  List<Tags> tagList = [];
  bool isLoading = false;

  void firebaseConnection() async {
    if(this.tagList.isEmpty) {
      setState(() => isLoading = true);
      await FirebaseFirestore.instance.collection('tags').orderBy('name')
          .get()
          .then((snapshot) =>
      {
        snapshot.docs.forEach((element) {
          setState(() {
            tagList.add(Tags(name: element["name"], id: element.id));
          });
        })
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    firebaseConnection();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openFilterDialog,
        child: Icon(Icons.add),
      ),
      body: selectedTagsList == null || selectedTagsList!.length == 0
          ? Center(child: Text('Тэги не выбраны'))
          : ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(selectedTagsList![index].name),
          );
        },
        itemCount: selectedTagsList!.length,
      ),
    );
  }

  void openFilterDialog() async {
    await FilterListDialog.display<Tags>(
      context,
      listData: tagList,
      selectedListData: selectedTagsList,
      choiceChipLabel: (tag) => tag!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (tag, query) {
        print(tag.id);
        return tag.name.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedTagsList = List.from(list!);
        });
        Navigator.pop(context);
      },
    );
  }
  
}


class Tags {
  final String name;
  final String id;
  Tags({required this.name,required this.id});
}


