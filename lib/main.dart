import 'package:flutter/material.dart';
import 'package:shapeyouadmin_web/screens/admin_users.dart';
import 'package:shapeyouadmin_web/screens/category_screen.dart';
import 'package:shapeyouadmin_web/screens/home_screen.dart';
import 'package:shapeyouadmin_web/screens/login_screen.dart';
import 'package:shapeyouadmin_web/screens/manage_banners.dart';
import 'package:shapeyouadmin_web/screens/notification_screen.dart';
import 'package:shapeyouadmin_web/screens/order_screen.dart';
import 'package:shapeyouadmin_web/screens/setting_screen.dart';
import 'package:shapeyouadmin_web/screens/splash_screen.dart';
import 'package:shapeyouadmin_web/screens/vendor_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shape You Admin App',
      theme: ThemeData(
        primaryColor: Color(0xFF995F06),
      ),
      home: SplashScreen(),
      routes: {
        HomeScreen.id:(context)=>HomeScreen(),
        SplashScreen.id:(context)=>SplashScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        BannerScreen.id:(context)=>BannerScreen(),
        CategoryScreen.id:(context)=> CategoryScreen(),
        SettingScreen.id:(context)=>SettingScreen(),
        OrderScreen.id:(context)=> OrderScreen(),
        NotificationScreen.id:(context)=> NotificationScreen(),
        AdminUsers.id:(context)=> AdminUsers(),
        VendorScreen.id:(context)=> VendorScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
