import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isHiddenPassword = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _loginController = TextEditingController();

  List<String> _countries = ['Ukraine', 'Russia', 'Germany', 'USA'];
  String _selectedCountry;

  final _loginFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _countryFocus = FocusNode();

  void _fieldFocusChange(
      BuildContext context, FocusNode curFocus, FocusNode nextFocus) {
    curFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    super.dispose();
    _loginController.dispose();

    _loginFocus.dispose();
    _phoneFocus.dispose();
    _countryFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepOrange[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        brightness: Brightness.dark,
        title: Text(
          'Test inputs form',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              focusNode: _loginFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _loginFocus, _phoneFocus);
              },
              controller: _loginController,
              decoration: InputDecoration(
                labelText: 'Login *',
                icon: Icon(Icons.person),
              ),
              validator: _validateLogin,
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _countryFocus);
              },
              decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: 'How we can call you',
                  prefixIcon: Icon(Icons.phone),
                  suffixIcon: Icon(
                    Icons.close,
                    color: Colors.red[800],
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  helperText: 'Format: 0#########'),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                // FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter(
                  RegExp(r'^[()\d -]{1,15}'),
                  allow: true,
                )
              ],
              maxLength: 10,
              // validator: (value) => _validatePhoneNumber(value),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 25,
            ),
            DropdownButtonFormField(
              focusNode: _countryFocus,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.location_city),
                  labelText: 'Country'),
              items: _countries.map((country) {
                return DropdownMenuItem(child: Text(country), value: country);
              }).toList(),
              onChanged: (data) {
                setState(() {
                  _selectedCountry = data;
                });
              },
              value: _selectedCountry,
              validator: (val) {
                return val == null ? 'Please, select a country' : null;
              },
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              obscureText: isHiddenPassword,
              decoration: InputDecoration(
                labelText: 'Password *',
                icon: Icon(Icons.security),
                suffixIcon: IconButton(
                  icon: Icon(isHiddenPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isHiddenPassword = !isHiddenPassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              obscureText: isHiddenPassword,
              decoration: InputDecoration(
                labelText: 'Repeat password *',
                icon: Icon(Icons.border_color),
                // suffixIcon: IconButton(
                //   icon: Icon(isHiddenPassword
                //       ? Icons.visibility
                //       : Icons.visibility_off),
                //   onPressed: () {
                //     setState(() {
                //       isHiddenPassword = !isHiddenPassword;
                //     });
                //},
                //),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: _handleSubmitForm,
              color: Colors.green,
              child: Text('Validate'),
            ),
          ],
        ),
      ),
    );
  }

  String _validateLogin(String value) {
    final _loginExp = RegExp(r'^[A-Za-z]+$');

    if (value.isEmpty) {
      return 'Name is required';
    } else if (!_loginExp.hasMatch(value)) {
      return 'Enter correct login';
    }
  }

  void _handleSubmitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    print('Login: ${_loginController.text}');

    // _showMessage(message: 'Form submited successful');

    _showDialog(name: _loginController.text);
  }

  void _showMessage({String message}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        message,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.0),
      ),
      backgroundColor: Colors.green[300],
    ));
  }

  void _showDialog({String name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Validation',
              style: TextStyle(color: Colors.green),
            ),
            content: Text(
              'Validation successful! Name: ${name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.green),
                  ))
            ],
          );
        });
  }
}
