import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'index.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF023436),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: [
                      Text(
                        'Deshatan.',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'The travel gazette',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                          ),
                          ),

                      SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle login button press
                            Navigator.pushNamed(context, '/dashboard');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF023436),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                  
                      Text(
                        'Dont Have an Account?',
                      style: TextStyle(
                      fontSize: 16,
                          ),
                          ),
                          GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                      child: Text(
                        'Register',
                      style: TextStyle(
                      color: Colors.blue,
                       decoration: TextDecoration.underline,
                        ),
                          ),
                          ),
        
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ),
      );
  }
}
