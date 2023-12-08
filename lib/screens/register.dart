import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/auth.dart';
import 'package:flutter_todo_app/screens/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String errorMessage = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool isLoading = false;

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createAccountWithEmailAndPassword(
        email: _usernameController.text,
        password: _controllerPassword.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pendaftaran Berhasil!'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        // errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mendaftar'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 183, 255),
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
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
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    child: const Text('Daftar'),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      Future.delayed(Duration(seconds: 3), (){
                        
                        setState(() {
                        isLoading = false;
                      });
                      });
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
                      createUserWithEmailAndPassword();
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Sudah punya akun?'),
                  TextButton(
                    child: const Text(
                      'Masuk',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
              Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              )
            ],
          )),
    );
  }
}
