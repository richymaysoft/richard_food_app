import 'package:figma_practice/models/user.dart';
import 'package:figma_practice/riverpod/logged_in_user_provider.dart';
import 'package:figma_practice/riverpod/user_provider.dart';
import 'package:figma_practice/screens/foods_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  String _enteredName = '';
  String _enteredEmail = '';
  String _enteredPassword = '';
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;

// add a dummy uer to the list to make sure it is never null by default.

  @override
  Widget build(BuildContext context) {
    var users = ref.watch(userProvider);

    final addRemoveUser = ref.read(userProvider.notifier);
    final loginOutUser = ref.read(loggedInUserProvider.notifier);

    void processForm() {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      _formKey.currentState!.save();
      if (!_isLogin) {
        addRemoveUser.addUser(User(
            name: _enteredName,
            email: _enteredEmail,
            password: _enteredPassword));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
          height: 100,
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: Text(
              'Sign Up successful',
              style: TextStyle(fontSize: 15, color: Colors.green),
            ),
          ),
        )));
      } else {
        User checkUser = users.firstWhere((user) => user.email == _enteredEmail,
            orElse: () => const User(
                  name: 'name',
                  email: 'email',
                  password: 'password',
                ));

        if (checkUser.email == _enteredEmail) {
          loginOutUser.logUserIn(checkUser);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const FoodScreen(

                  // user: checkUser,
                  )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
            height: 100,
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: Text(
                'Email does Not exist',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          )));
        }
      }
    }

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Container(
        width: screenWidth,
        height: screenHeight * 0.98,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFF2F2F2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: SizedBox(
          height: screenHeight * 0.3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.4,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 30,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(
                              top: 120, left: 50, right: 50, bottom: 35),
                          child: const Image(
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/bellaolonjelogo1111.png'))),
                      Container(
                        padding: EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isLogin = true;
                                });
                              },
                              child: Column(
                                children: [
                                  const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'SF Pro Text',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 134,
                                    height: 3,
                                    decoration: ShapeDecoration(
                                      color: _isLogin
                                          ? Color(0xFFFA4A0C)
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x19C33F15),
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isLogin = false;
                                });
                              },
                              child: Column(
                                children: [
                                  const Text(
                                    'Sign-up',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'SF Pro Text',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 134,
                                    height: 3,
                                    decoration: ShapeDecoration(
                                      color: _isLogin
                                          ? Colors.white
                                          : Color(0xFFFA4A0C),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x19C33F15),
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 60, right: 60, top: 50),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!_isLogin)
                            const Opacity(
                              opacity: 0.40,
                              child: Text(
                                'Full Name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          if (!_isLogin)
                            TextFormField(
                              onSaved: (value) {
                                setState(() {
                                  _enteredName = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.trim().length < 5) {
                                  return 'Kindly enter a valid full name';
                                }
                                return null;
                              },
                              enableSuggestions: true,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  errorStyle: TextStyle(
                                      fontSize: 15, color: Colors.red),
                                  hoverColor: Colors.black,
                                  fillColor: Colors.black,
                                  //  isCollapsed: true,
                                  focusColor: Colors.black),
                            ),
                          if (!_isLogin)
                            const SizedBox(
                              height: 20,
                            ),
                          const Opacity(
                            opacity: 0.40,
                            child: Text(
                              'Email address',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              setState(() {
                                _enteredEmail = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.trim().length < 5 ||
                                  !value.contains('@')) {
                                return 'Kindly enter a valid Email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                                errorStyle:
                                    TextStyle(fontSize: 15, color: Colors.red),
                                hoverColor: Colors.black,
                                fillColor: Colors.black,
                                //  isCollapsed: true,
                                focusColor: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Opacity(
                            opacity: 0.40,
                            child: Text(
                              'Password',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              setState(() {
                                _enteredPassword = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password too short';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            obscureText: true,
                            decoration: const InputDecoration(
                                errorStyle:
                                    TextStyle(fontSize: 15, color: Colors.red),
                                hoverColor: Colors.black,
                                fillColor: Colors.black,
                                //  isCollapsed: true,
                                focusColor: Colors.black),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            'Forgot passcode?',
                            style: TextStyle(
                              color: Color(0xFFFA4A0C),
                              fontSize: 17,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          SizedBox(
                            height: _isLogin ? 110 : 70,
                          ),
                          GestureDetector(
                            onTap: processForm,
                            child: Container(
                              alignment: Alignment.center,
                              width: 314,
                              height: 70,
                              decoration: ShapeDecoration(
                                color: Color(0xFFFA4A0C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                _isLogin ? 'Login' : 'Sign Up',
                                style: const TextStyle(
                                  color: Color(0xFFF6F6F9),
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
