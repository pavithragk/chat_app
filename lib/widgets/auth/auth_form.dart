import 'dart:io';

import 'package:chat_app_firebase/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  void Function(
    String email,
    String password,
    String userName,
    File image,
    bool islogin,
    BuildContext ctx,
  ) submitFn;
  bool isLoading;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _islogin = true;
  var _userEmail = '';
  var _userName = '';
  File _userImageFile;

  var _userPassword = '';

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    // setState(() {
    //  isL
    // });
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_islogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _userImageFile, _islogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_islogin) UserImagePicker(_pickedImage),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email address'),
                ),
                if (!_islogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter a valid name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                    decoration: InputDecoration(labelText: 'User name'),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'password must be more than 7 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: _trySubmit,
                    child: Text(_islogin ? 'Login' : 'Sign up'),
                  ),
                if (!widget.isLoading)
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _islogin = !_islogin;
                      });
                    },
                    child: Text(_islogin
                        ? 'Create new account'
                        : 'I already have an account'),
                    textColor: Theme.of(context).primaryColor,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
