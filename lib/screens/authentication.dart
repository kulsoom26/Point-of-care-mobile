// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:test/screens/passwordReset.dart';
import 'package:test/services/auth_services.dart';

enum AuthMode { Signup, Login }

class Authentication extends StatelessWidget {
  static const routeName = '/auth';

  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          const Image(
            image: AssetImage('assets/images/eclipse.png'),
          ),
          SafeArea(
            child: Container(
                margin: EdgeInsets.only(
                  left: deviceSize.width * 0.6,
                  top: deviceSize.height * 0.035,
                ),
                child: SizedBox(
                  width: deviceSize.width * 0.3,
                  height: deviceSize.height * 0.07,
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Image(
                      image: AssetImage('assets/images/Point of Care.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: const AuthCard(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cPasswordController = TextEditingController();

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  bool _typeActive = false;
  String _errorMessage = '';
  String _errorMessage1 = '';
  String _errorMessage2 = '';
  String _errorMessage3 = '';
  String role = "Select the type";
  final AuthService authService = AuthService();

  //signup function
  void signupUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        name: _nameController.text,
        role: role,
        password: _passwordController.text);
  }

  void signinUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup
              ? deviceSize.height * 0.5
              : deviceSize.height * 0.3),
      width: deviceSize.width * 0.85,
      padding: EdgeInsets.all(deviceSize.width * 0.04),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Login Heading
              if (_authMode == AuthMode.Login)
                Container(
                  margin: EdgeInsets.only(
                      top: deviceSize.height * 0.09,
                      left: deviceSize.width * 0.008),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.09,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Signup Heading
              if (_authMode == AuthMode.Signup)
                Container(
                  margin: EdgeInsets.only(
                    top: deviceSize.height * 0.09,
                    left: deviceSize.width * 0.008,
                    //bottom: deviceSize.height * 0.02
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.08,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Login Tagline
              if (_authMode == AuthMode.Login)
                Container(
                  margin: EdgeInsets.only(
                      bottom: deviceSize.height * 0.03,
                      top: deviceSize.height * 0.02,
                      left: deviceSize.width * 0.008),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Please Sign in to continue',
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.035,
                        color: Colors.black38,
                        fontFamily: 'League Spartan',
                      ),
                    ),
                  ),
                ),

              // Signup name field
              if (_authMode == AuthMode.Signup)
                FocusScope(
                  child: Focus(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                        prefixIcon: const Icon(Icons.account_circle_outlined),
                        prefixIconColor: Colors.black,
                      ),
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'League Spartan',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        validateName(val);
                      },
                      controller: _nameController,
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage2,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: deviceSize.width * 0.03,
                      fontFamily: 'League Spartan',
                    ),
                  ),
                ),
              ),

              // Email field
              FocusScope(
                child: Focus(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: const Icon(Icons.email_outlined),
                      prefixIconColor: Colors.black,
                    ),
                    onChanged: (val) {
                      validateEmail(val);
                    },
                    controller: _emailController,
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: deviceSize.width * 0.03,
                      fontFamily: 'League Spartan',
                    ),
                  ),
                ),
              ),

              // Password Field
              FocusScope(
                child: Focus(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      prefixIconColor: Colors.black,
                    ),
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    onChanged: (val) {
                      validatePass(val);
                    },
                  ),
                ),
              ),
              if (_errorMessage1 != '' || _authMode == AuthMode.Signup)
                Padding(
                  padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _errorMessage1,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: deviceSize.width * 0.03,
                        fontFamily: 'League Spartan',
                      ),
                    ),
                  ),
                ),

              // Signup confirm password
              if (_authMode == AuthMode.Signup)
                FocusScope(
                  child: Focus(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                        prefixIcon: const Icon(Icons.lock_outlined),
                        prefixIconColor: Colors.black,
                      ),
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'League Spartan',
                      ),
                      obscureText: true,
                      controller: _cPasswordController,
                      onChanged: (val) {
                        validateCPass(val);
                      },
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: deviceSize.height * 0.01),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _errorMessage3,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: deviceSize.width * 0.03,
                      fontFamily: 'League Spartan',
                    ),
                  ),
                ),
              ),
              if (_authMode == AuthMode.Login)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PasswordReset(),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontFamily: 'League Spartan',
                        fontSize: deviceSize.width * 0.04,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              if (_authMode == AuthMode.Signup)
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Select the user type:',
                        style: TextStyle(
                          fontFamily: 'League Spartan',
                          fontSize: deviceSize.width * 0.04,
                          color: const Color(0xFF949494),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        width: deviceSize.width * 0.03,
                      ),
                      DropdownButton(
                        value: role,
                        style: TextStyle(
                          color: const Color(0xFF8587DC),
                          fontSize: deviceSize.width * 0.038,
                          fontFamily: 'League Spartan',
                        ),
                        items: dropdownItems,
                        onChanged: (String? newValue) {
                          setState(() {
                            role = newValue!;
                            if (role == 'Select the type') {
                              _typeActive = false;
                            } else {
                              _typeActive = true;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              if (_authMode == AuthMode.Login)
                SizedBox(
                  height: deviceSize.height * 0.03,
                ),
              if (_authMode == AuthMode.Signup)
                SizedBox(
                  height: deviceSize.height * 0.025,
                ),

              //Login and signup button
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_authMode == AuthMode.Login) {
                      signinUser();
                    }
                    if (_authMode == AuthMode.Signup) {
                      if (_typeActive) {
                        signupUser();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(deviceSize.width * 0.09),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFFB9A0E6),
                          Color(0xFF8587DC),
                        ],
                      ),
                      borderRadius:
                          BorderRadius.circular(deviceSize.width * 0.09),
                    ),
                    child: Container(
                      width: deviceSize.width * 0.45,
                      height: deviceSize.height * 0.06,
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: deviceSize.width * 0.1,
                              right: deviceSize.width * 0.02,
                            ),
                          ),
                          Text(
                            _authMode == AuthMode.Login
                                ? 'LOGIN  '
                                : 'SIGN UP  ',
                            style: TextStyle(
                              fontSize: deviceSize.width * 0.056,
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Image(
                            image: AssetImage('assets/images/right-arrow.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height: _authMode == AuthMode.Login
                    ? deviceSize.height * 0.06
                    : deviceSize.height * 0.05,
              ),

              //Login and Signup Login option
              Text(
                _authMode == AuthMode.Login
                    ? 'Or Login with'
                    : 'Or Signup with',
                style: TextStyle(
                  fontSize: deviceSize.width * 0.048,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                height: deviceSize.height * 0.02,
              ),

              //Google facebook button
              Row(
                children: <Widget>[
                  SizedBox(
                    width: deviceSize.width * 0.35,
                    height: deviceSize.height * 0.07,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(deviceSize.width * 0.02),
                        ),
                        side: BorderSide(
                          width: deviceSize.width * 0.01,
                          color: const Color(0xFF4267B2),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: deviceSize.width * 0.014),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.facebook,
                              size: deviceSize.width * 0.07,
                              color: const Color(0xFF4267B2),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: deviceSize.width * 0.01),
                              child: Text(
                                'Facebook',
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.039,
                                  color: const Color(0xFF4267B2),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: deviceSize.width * 0.03,
                  ),
                  SizedBox(
                    width: deviceSize.width * 0.35,
                    height: deviceSize.height * 0.07,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(deviceSize.width * 0.02),
                        ),
                        side: BorderSide(
                          width: deviceSize.width * 0.01,
                          color: const Color(0xFF5C8DF0),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: deviceSize.width * 0.05),
                        child: Row(
                          children: <Widget>[
                            Image(
                              image:
                                  const AssetImage('assets/images/google.png'),
                              width: deviceSize.width * 0.056,
                              height: deviceSize.width * 0.056,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: deviceSize.width * 0.01),
                              child: Text(
                                'Google',
                                style: TextStyle(
                                  fontSize: deviceSize.width * 0.039,
                                  color: const Color(0xFF4267B2),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //switch between signup and sign in
              Container(
                margin: EdgeInsets.only(
                    left: deviceSize.width * 0.09,
                    top: deviceSize.height * 0.0167),
                child: Row(children: <Widget>[
                  Text(
                    _authMode == AuthMode.Login
                        ? "Don't have an account?"
                        : 'Already have an account?',
                    style: TextStyle(
                      fontSize: deviceSize.width * 0.04,
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF858383),
                    ),
                  ),
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      '${_authMode == AuthMode.Login ? 'Sign up' : 'Sign in'} ',
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.04,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF8587DC),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  void validateName(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage2 = "Invalid Name";
      });
    } else {
      setState(() {
        _errorMessage2 = "";
      });
    }
  }

  void validatePass(String val) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    var passNonNullValue = val;
    if (passNonNullValue.isEmpty) {
      setState(() {
        _errorMessage1 = "Password is required";
      });
    } else if (passNonNullValue.length < 6) {
      setState(() {
        _errorMessage1 = "Password Must be more than 5 characters";
      });
    } else if (!regex.hasMatch(passNonNullValue)) {
      setState(() {
        _errorMessage1 =
            "Password should contain upper,lower,digit and Special character";
      });
    } else {
      setState(() {
        _errorMessage1 = "";
      });
    }
  }

  void validateCPass(String val) {
    var passNonNullValue = val;
    if (passNonNullValue.isEmpty) {
      setState(() {
        _errorMessage3 = "Confirm your Password";
      });
    }
    // } else if (passNonNullValue != _authData['password']) {
    //   setState(() {
    //     _errorMessage3 = "Passwords don't match";
    //   });
    // }
    else {
      setState(() {
        _errorMessage3 = "";
      });
    }
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select the type", child: Text("Select the type")),
      const DropdownMenuItem(value: "Doctor", child: Text("Doctor")),
      const DropdownMenuItem(
          value: "Patient", child: Text("Patient/Radiologist")),
    ];
    return menuItems;
  }
}
