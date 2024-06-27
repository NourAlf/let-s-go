
import 'package:flutter/material.dart';
import 'package:letsgohome/screens/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            //margin: EdgeInsets.all(20),
            height: 430,
            // width:  360,
            decoration: const BoxDecoration(
              color:  Color(0xFF5C955D),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child:   Center(
              child: Container(
                // alignment: Alignment.,
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Image.asset('assets/logo.png',fit: BoxFit.fill ,),
              ),
            ),

          ),


          Center(

            child: Container(
              margin: const EdgeInsets.only(top: 310,left: 27,right: 27),

              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Welcome to App ...",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("You must log in to join our service"),
                  const SizedBox(height: 30),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5C955D),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  LoginPage()));

                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor:  const Color(0xFF5C955D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Login",style: TextStyle(
                          fontSize: 20
                          , fontWeight:FontWeight.bold, color: Colors.white),),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5C955D),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('SignUp');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor:  const Color(0xFF5C955D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Register",style: TextStyle(
                          fontSize: 20
                          , fontWeight:FontWeight.bold, color: Colors.white),),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}