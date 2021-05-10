import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:shapeyouadmin_web/services/sidebar.dart';
import 'package:shapeyouadmin_web/widgets/category/category_list_widget.dart';
import 'package:shapeyouadmin_web/widgets/category/category_upload_widget.dart';

class CategoryScreen extends StatelessWidget {
  static const String id= 'category-screen';

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black54,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Shape You Dashboard',style: TextStyle(color: Colors.white),),
      ),
      sideBar: _sideBar.sideBarMenus(context, CategoryScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Category Manager Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text(
                'Add New Categories and Sub Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Divider(
                thickness: 5,
              ),
                 CategoryCreateWidget(),
              Divider(
                thickness: 5,
              ),
              CategoryListWidget(),

            ],
          ),
        ),
      ),
    );
  }
}

