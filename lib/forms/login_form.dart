// External
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Internal
import '../helpers/user_backend.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
    required Map<String, TextStyle> styles,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _passwordController = passwordController,
        _styles = styles,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final Map<String, TextStyle> _styles;
  final TextEditingController _passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode _passwordFocusNode = FocusNode();

  var _passwordIsVisible = false;
  void _togglePasswordVisibility() {
    setState(() {
      _passwordIsVisible = !_passwordIsVisible;
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  final Map<String, String> _authData = {
    'email': '',
  };

  final Widget _spacer = const SizedBox(
    height: 8,
  );

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      key: widget._formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Sign in to access you account',
                  style: widget._styles['formHeader'],
                ),
              ),
            ]),
            FormBuilderTextField(
              name: 'email',
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  isDense: true,
                  labelStyle: widget._styles['formlabel'],
                  labelText: 'Email',
                  hintText: 'johndoe@mail.com'),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              validator: (value) {
                final RegExp regExp = RegExp(
                  r"[a-z0-9!#$%&'*+/=?^`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)\b",
                  caseSensitive: false,
                  multiLine: false,
                );
                if (value == null) {
                  return 'Email field is not valid';
                }
                if (value.isEmpty) {
                  return 'Email Field can not be empty';
                } else if (!regExp.hasMatch(value)) {
                  return 'Enter a valid Email';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                if (value != null) {
                  _authData['email'] = value.trim();
                } else {}
              },
            ),
            _spacer,
            FormBuilderTextField(
              name: 'password',
              controller: widget._passwordController,
              focusNode: _passwordFocusNode,
              obscureText: !_passwordIsVisible,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                isDense: true,
                labelStyle: widget._styles['formlabel'],
                suffixIcon: IconButton(
                  icon: Icon(_passwordIsVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: _togglePasswordVisibility,
                ),
                labelText: 'Password',
              ),
              validator: (value) {
                final RegExp regExp =
                    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,})");
                if (value == null) {
                  return 'Password is required';
                } else if (!regExp.hasMatch(value)) {
                  return 'Password must have a number, lowercase and uppercase character';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                // _authData['password'] = value;
              },
            ),
            _spacer,
            const SizedBox(
              height: 50.0,
            ),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  // backgroundColor: Theme.of(context).primaryColor.withAlpha(50),
                  fixedSize: const Size(100, 10),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 187, 95, 33),
                    style: BorderStyle.solid,
                    width: 0.5,
                  ),
                  // shape: const RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                child: Text(
                  'Submit',
                  style: widget._styles['submitButton'],
                ),
                onPressed: () {
                  final user = UserBackend();

                  if (widget._formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });

                    widget._formKey.currentState?.save();

                    user.logIn(_authData['email'] as String,
                        widget._passwordController.text, {
                      'context': context,
                      'callback': () {
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    });
                  }
                  // Set state finally. Don't get stuck at logging in
                  // setState(() {
                  //       _isLoading = false;
                  //     });
                },
              )
          ],
        ),
      ),
    );
  }
}
