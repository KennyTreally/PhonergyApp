import 'package:flutter/material.dart';
import 'package:phonergy/auth.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth.dart';
import 'root_page.dart';
import 'home_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Smart Meter is Active (ON) ✔',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Location Active: Orlando, FL',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      const Text('Amount: 1'),
    ],
  ),
);
class MyApp extends StatelessWidget{

  @override
    Widget build(BuildContext context){


    Color color = Theme.of(context).primaryColor;

  Widget buttonSection = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(color, Icons.call, 'CALL'),
      _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
      _buildButtonColumn(color, Icons.share, 'SHARE'),
    ],
  );
      return new MaterialApp(
        title: 'Phonergy',
        theme: new ThemeData(
            primarySwatch: MaterialColor(0xFFFFEB3B, {
              50:  Color(0xFFFFEB3B),
              100: Color(0xFFFFEB3B),
              200: Color(0xFFFFEB3B),
              300: Color(0xFFFFEB3B),
              400: Color(0xFFFFEB3B),
              500: Color(0xFFFFEB3B),
              600: Color(0xFFFFEB3B),
              700: Color(0xFFFFEB3B),
              800: Color(0xFFFFEB3B),
              900: Color(0xFFFFEB3B),
            })
        ),
        home: new RootPage(auth: new Auth())
      );
    }
  const MyApp({Key? key}) : super(key: key);

  Column _buildButtonColumn(Color color, IconData icon, String label) {
  return Column(
  mainAxisSize: MainAxisSize.min,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Icon(icon, color: color),
  Container(
  margin: const EdgeInsets.only(top: 8),
  child: Text(
  label,
  style: TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: color,
  ),
  ),
  ),
  ],
  );
  }

  }
