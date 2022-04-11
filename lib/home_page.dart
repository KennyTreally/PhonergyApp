import 'package:flutter/material.dart';
import 'package:phonergy/auth.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'auth.dart';
import 'main.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

const String _url = 'http://3.95.155.202:3000/d/GGSGtJzgk/energy-monitoring?orgId=1';
const String _url1 = 'http://3.95.155.202:1880/#flow/c455155f6bcdd318';
class Homepage extends StatelessWidget{
  Homepage({required this.auth, required this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async{
    try{
      await auth.signOut();
      onSignedOut();
    } catch (e){
      print(e);
    }
  }
  Widget textSection = const Padding(
    padding: EdgeInsets.all(32),
    child: Text(
      'For technical support please phone 321-5669-7545 open weekdays only.'
          '                                                          '
          '                                                          '
          'To view you system please follow the generated links below:',
      softWrap: true,
    ),
  );


  @override
    Widget build(BuildContext context){

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0xFFFFEB3B),
        title: new Text('Welcome to Phonergy App'),
        actions:<Widget>[
          new TextButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0,color: Colors.white)),
          onPressed: _signOut
          )
        ],
      ),

        body: Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 80, 90),
            child: Column(children: <Widget>[
              Expanded(
                  child: titleSection
                  ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(80, 10, 10, 10),
                      child: OutlinedButton(
                        onPressed: _launchURL,
                        child: const Text('Grafana Dashboard'),
                        style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.all(20)),
                      ))),
              Expanded(
              child: Padding(
              padding: EdgeInsets.fromLTRB(80, 10, 10, 10),
    child: OutlinedButton(
    onPressed: _launchURL1,
    child: const Text('Node Red Flow'),
    style: OutlinedButton.styleFrom(
    primary: Colors.black,
    backgroundColor: Colors.amber,
    padding: const EdgeInsets.all(35)),
    )))

            ])));
  }
}

void _launchURL() async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
void _launchURL1() async {
  if (!await launch(_url1)) throw 'Could not launch $_url';
}
