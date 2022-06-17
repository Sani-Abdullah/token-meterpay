// External
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Internal
import '../helpers/user_backend.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
    required Map<String, TextStyle> styles,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _usernameController = usernameController,
        _passwordController = passwordController,
        _styles = styles,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;
  final Map<String, TextStyle> _styles;
  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _telephoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  var _passwordIsVisible = false;
  void _togglePasswordVisibility() {
    setState(() {
      _passwordIsVisible = !_passwordIsVisible;
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _telephoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  final Map<String, String> _authData = {
    'email': '',
    'username': '',
    'telephone': '',
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
                  'Join the smart parking community!',
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
                FocusScope.of(context).requestFocus(_usernameFocusNode);
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
              name: 'username',
              keyboardType: TextInputType.text,
              controller: widget._usernameController,
              focusNode: _usernameFocusNode,
              decoration: InputDecoration(
                isDense: true,
                labelStyle: widget._styles['formlabel'],
                labelText: 'Username',
                hintText: 'johnDoe-56',
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_telephoneFocusNode);
              },
              validator: (value) {
                final RegExp regExp = RegExp(r"^[A-Za-z0-9-]*$");
                if (value == null || value.isEmpty) {
                  return 'Username is required.';
                }
                if (!regExp.hasMatch(value)) {
                  return 'Username can only contain letter, alphabets and hyphen.';
                }
                if (value.length > 15) {
                  return 'Only 15 characters at most allowed.';
                }
                return null;
              },
              onSaved: (value) {
                _authData['username'] = value!.trim();
              },
            ),
            _spacer,
            FormBuilderTextField(
              name: 'telephone',
              focusNode: _telephoneFocusNode,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                isDense: true,
                labelStyle: widget._styles['formlabel'],
                prefixText: '+234-',
                labelText: 'Telephone',
                //hintText: '8140210027',
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              }, // r'^[0-9]$'
              validator: (value) {
                final RegExp regExp = RegExp(
                  r'^[0-9]*$',
                  caseSensitive: false,
                  multiLine: false,
                );
                if (value == null) {
                  return 'Enter your Telephone number without leading 0';
                } else if (!regExp.hasMatch(value)) {
                  return 'Telephone number contains only numbers';
                } else if (value.startsWith('0')) {
                  return 'Remove leading 0';
                } else if (!(value.length == 10)) {
                  return value.length < 10
                      ? 'Telephone number too short'
                      : 'Telephone number too long';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                _authData['telephone'] = '0$value'.trim();
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
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
              },
              validator: (value) {
                final RegExp regExp =
                    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,})");
                if (value == null) {
                  return 'Password is required';
                } else if (value.length < 8) {
                  return 'Password must have at least 8 characters';
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
            FormBuilderTextField(
              name: 'confirmPassword',
              obscureText: true,
              decoration: InputDecoration(
                isDense: true,
                labelStyle: widget._styles['formlabel'],
                labelText: 'Confirm Password',
              ),
              focusNode: _confirmPasswordFocusNode,
              validator: (value) {
                if (widget._passwordController.text != value) {
                  return 'Passwords do not match';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 20.0,
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

                    user.signUp(
                        _authData['email'] as String,
                        widget._passwordController.text,
                        _authData['username'] as String,
                        _authData['telephone'] as String, {
                      'context': context,
                      'callback': () {
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    });
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}
