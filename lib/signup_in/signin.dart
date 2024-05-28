import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp/contenent/home.dart';
import 'signup.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String username = '';
  String password = '';
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _authenticated = false;

  Future<void> _signIn(String emailSignin, String passwordSignin) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailSignin,
        password: passwordSignin,
      );
      print('Utilisateur connecté: ${userCredential.user?.email}');
      _passwordController.clear();
      _usernameController.clear();
      username = '';
      password = '';
      Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: Home(),
                          );
                        },
                      ),
                    );
                    _authenticated ?false:false;
    } catch (e) {
      print('Erreur de connexion: $e');
      setState(() {
        _authenticated=true;
      });
    }
  }

  void _resetPassword(String emailReset) async {
    try {
      if (_validateEmail(emailReset) == null) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailReset);
        print("Email envoyé");
      }
    } catch (e) {
      print("Erreur : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _resetPassword(username);
            },
            icon: const Icon(Icons.lock_reset_outlined),
          ),
        ],
        title: Container(
          child: ClipOval(
            child: Image.asset(
              'bb.jpg',
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(211, 184, 46, 227),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('bb.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontFamily: 'Jokerman',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: _emailError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _emailError = _validateEmail(value);
                      username = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: _passwordError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _passwordError = _validatePassword(value);
                      password = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_emailError == null && _passwordError == null && password.isNotEmpty && username.isNotEmpty) {
                      _signIn(username, password);
                      
                      


                    }

                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Sign In', style: TextStyle(fontSize: 18)),
                ),
               
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // Logic for Google Sign In
                    print("sign in with google");
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: Home(),
                          );
                        },
                      ),
                    );
                  },
                  icon: Image.asset('google.jpg', height: 24.0),
                  label: Text('Sign in with Google'),
                  style: ElevatedButton.styleFrom(
                    
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // Logic for GitHub Sign In
                    print("sign in with github");
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: Home(),
                          );
                        },
                      ),
                    );
                  },
                  icon: Image.asset('github.jpg', height: 24.0),
                  label: Text('Sign in with GitHub'),
                  style: ElevatedButton.styleFrom(
                   
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                 SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SignUpPage(),
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: const Color.fromARGB(255, 66, 56, 56), fontFamily: 'Tw Cen MT',fontSize: 17),
                  ),
                ),
               SizedBox(height: 10),
                _authenticated ?  
                Text("Email or password is incorrect", style: TextStyle(color: Colors.red)):
                Container() ,

                
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }
}
