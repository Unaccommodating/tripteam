import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lan_code/assets/style.dart';

import '../assets/finally.dart';

class Local extends StatelessWidget {
  const Local({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Grey,
      ///ШАПКА
        appBar: PreferredSize(preferredSize: Size.fromHeight(50),
            child: AppBar(backgroundColor:Grey, elevation: 0.0,
                leading: Container(
                  width: 70,
                  decoration: BoxDecoration(color: Blue,borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
                  child: IconButton(icon: Icon(Icons.arrow_back_ios),
                      onPressed: (){
                        Navigator.pop(context);
                      })
                )
            )
        ),

      body: Center(
        child:  TextButton(onPressed: (){
          showModalBottomSheet(
              backgroundColor:White.withOpacity(0),
              context: context,
              builder: (BuildContext context) {
                return Language();
              });
        },
          child: Text("...",style: Montserrat(color: Blue)),
        )
      )
    );
  }
}


class Language extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<Widget> Lang = [
      Container(alignment: Alignment.topCenter,
        child: Text("Заголовок",style: Montserrat(color:White,size: 13,style: SemiBold),)
      ),
    ];

    double MaxHength()
    {
      if(Lang.length >= 3)
      {
        double n = 0.5+0.17*(Lang.length-3);
        if(n >= 1)
          {
            n = 1;
          }
        return n;
      }
      else
        {
          return 0.5;
        }
    }

    return DraggableScrollableSheet(
      maxChildSize: MaxHength(),
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top:25),
              decoration: BoxDecoration(color: Blue,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: Lang.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(margin:EdgeInsets.only(bottom: 10),
                    child: Lang[index]
                  );
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
