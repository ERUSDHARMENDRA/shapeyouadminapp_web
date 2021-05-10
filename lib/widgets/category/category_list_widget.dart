import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shapeyouadmin_web/services/firebase_services.dart';
import 'package:shapeyouadmin_web/widgets/category/category_card_widget.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({Key key}) : super(key: key);

  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();

    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: _services.category.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Center(child: Text('Something went wrong'));
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            return Wrap(
              direction: Axis.horizontal,
              children: snapshot.data.docs.map((DocumentSnapshot document){
                return CategoryCard(document);
              }).toList(),
            );
        },
      ),
    );
  }
}
