import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String password = '';
  String username = '';
  String confirmPassword = '';
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

  String ? _emailError;
  String ?_passwordError;
  String ?_confirmPasswordError;

   //
    void _signUp(String emailRege , String passwordRege) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:emailRege ,password: passwordRege
      );
      // Inscription réussie, vous pouvez rediriger l'utilisateur ou effectuer d'autres opérations
      print('Utilisateur enregistré avec l\'ID: ${userCredential.user!.uid}');
      _usernameController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      username = '';
      password = '';
      confirmPassword = '';
      Navigator.pop(context);
    } catch (error) {
      // Gérer les erreurs d'inscription
      print('Erreur d\'inscription: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur d\'inscription: $error')),
      );
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
                  child: ClipOval(
                  child: Image.asset(
                  'bb.jpg',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
          
        ),
       
        backgroundColor: Color.fromARGB(212, 255, 39, 39),),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('background.jpg'), // Add a suitable background image in your assets
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 221, 152, 4),
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
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: _confirmPasswordError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _confirmPasswordError = _validateConfirmPassword(value);
                      confirmPassword = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_emailError == null && _passwordError == null && _confirmPasswordError == null && password!='' && username!='' && confirmPassword!='') {
                      // Handle sign up logic here
                      print("Email: $username ,Password: $password ,Confirm Password: $confirmPassword");
                      _signUp(username,password);
                      
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Sign Up', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Already have an account ? Sign In",
                    style: TextStyle(color: Colors.black, fontFamily: 'Tw Cen MT', fontSize: 15),
                  ),
                ),
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
    // Add any additional password validation logic here
    return null;
  }

  String? _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
