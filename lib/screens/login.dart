import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/auth.dart';
import 'package:flutter_todo_app/screens/home.dart';
import 'package:flutter_todo_app/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String _title = 'Tugas Login UI';
  String errorMessage = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  late SharedPreferences sharedPreferences;



  void initialGetSavedData() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _controllerPassword.text,
      );
      // login berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        (SnackBar(
          content: Text('Berhasil Login!'),
        )),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );

      /// Nanti kalau udah install shared preference tinggal
      /// Disimpan status true/false disini
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }

  bool user = false;
  @override
  void initState() {
    super.initState();
    _initCheck();

    /// Check status true/false user sudah login atau belum
    /// if true nanti ke Homescreen
    /// if false nanti ke login
  }
   checkingTheSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    if (username == null) {
      Navigator.pushReplacementNamed(context, '/login.dart');
    } else {
      Navigator.pushReplacementNamed(context, '/todo.dart');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Login Tangguh',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 183, 255),
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: _controllerPassword,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Lupa Password',
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    child: const Text('Masuk'),
                    onPressed: () {
                      debugPrint('LOGIN');
                      if (_usernameController.text.isEmpty &&
                          _controllerPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Email dan Password tidak boleh kosong!'),
                          ),
                        );
                        return;
                      }
                      signInWithEmailAndPassword();
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Belum punya akun?'),
                  TextButton(
                    child: const Text(
                      'Mendaftar',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
