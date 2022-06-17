// External
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Internal
import '../forms/signup_form.dart';
import '../forms/login_form.dart';

class AuthenticationScreen extends StatefulWidget {
  static const routeName = 'auth-screen';
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  final _inFormKey = GlobalKey<FormBuilderState>();
  final _upFormKey = GlobalKey<FormBuilderState>();

  final _usernameController = TextEditingController();
  final _inPasswordController = TextEditingController();
  final _upPasswordController = TextEditingController();

  final Map<String, dynamic> _authStyle = {
      'title': const TextStyle(
        fontFamily: 'ComicNeue',
        fontSize: 25.0,
      ),
      'toolbar': const TextStyle(
        fontFamily: 'Abel',
        fontSize: 19,
      ),
    };

  final Map<String, TextStyle> _formStyle = {
    'formlabel': const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14.0,
    ),
    'submitButton': const TextStyle(
      fontFamily: 'ComicNeue',
      fontSize: 20.0,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    'formHeader': const TextStyle(
      fontFamily: 'ComicNeue',
      fontSize: 16.00,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 17, 26, 21),
    )
  };

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _inFormKey.currentState?.reset();
      _upFormKey.currentState?.reset();
      _usernameController.clear();
      _inPasswordController.clear();
      _upPasswordController.clear();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _device = MediaQuery.of(context);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'WELCOME',
          style: _authStyle['title'],
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          tabs: [
            Tab(
              child: Text(
                'Login',
                style: _authStyle['toolbar'],
              ),
            ),
            Tab(
              child: Text(
                'Sign Up',
                style: _authStyle['toolbar'],
              ),
            ),
          ],
        ),
      ),
      body: Align(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.05,
                      style: BorderStyle.solid,
                      color: const Color.fromARGB(255, 29, 113, 58))),
              height: _device.size.height * .55,
              width: double.infinity,
              alignment: Alignment.center,
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  LoginForm(
                      formKey: _inFormKey,
                      styles: _formStyle,
                      passwordController: _inPasswordController),
                  SignUpForm(
                      formKey: _upFormKey,
                      styles: _formStyle,
                      usernameController: _usernameController,
                      passwordController: _upPasswordController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
