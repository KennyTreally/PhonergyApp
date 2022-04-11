import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'auth.dart';
import 'login_page.dart';
import 'root_page.dart';
class LoginPage extends StatefulWidget {
  LoginPage({required this.auth, required this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}
enum FormType{
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey<FormState>();
  late String _email;
  late String _password;
  late String _ProductCode;
  late String _Phonenumber;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login){
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
      }else{
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
        }
      catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState!.reset();
    setState(() {
      _formType = FormType.register;
    });
  }
  void moveToLogin() {
    formKey.currentState!.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Phonergy Smart Meter'),
        ),
        resizeToAvoidBottomInset: false,
        body: new Container(
            padding: EdgeInsets.all(16.0),
            child: new Form(
              key: formKey,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildInputs() + buildSubmitButtons(),
              ),
            )
        )
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) => value!.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value!,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) =>
        value!.isEmpty
            ? 'Password can\'t be empty'
            : null,
        onSaved: (value) => _password = value!,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Phone Number'),
        obscureText: true,
        validator: (value) =>
        value!.isEmpty
            ? 'Phone Number can\'t be empty'
            : null,
        onSaved: (value) => _Phonenumber = value!,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'ProductCode'),
        obscureText: true,
        validator: (value) =>
        value!.isEmpty
            ? 'ProductCode can\'t be empty'
            : null,
        onSaved: (value) => _ProductCode = value!,
      ),

    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new ElevatedButton(
          child: new Text('Login', style: new TextStyle(fontSize: 15.0)),
          onPressed: validateAndSubmit,
        ),
        new TextButton(
          child: new Text(
              'Create an account', style: new TextStyle(fontSize: 15.0)),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
      new ElevatedButton(
        child: new Text('Create an account', style: new TextStyle(fontSize: 15.0)),
        onPressed: validateAndSubmit,
      ),
    new TextButton(
    child: new Text(
    'Have an account? Login', style: new TextStyle(fontSize: 15.0)),
    onPressed: moveToLogin,
    ),
    ];
    }
  }
}