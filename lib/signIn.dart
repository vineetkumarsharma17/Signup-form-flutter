import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sign_up_email/main.dart';

import 'alertdilog.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth=FirebaseAuth.instance;
  String ?email,password;
  bool isvisible=false;
  // void progress(){
  //   new Timer.periodic(
  //       Duration(seconds: 1),
  //           (Timer timer){
  //         setState(() {
  //           if(a == 1) {
  //             timer.cancel();
  //            // a=null!;
  //           }
  //           else {
  //             a = a + 0.1;
  //           }
  //         });
  //       }
  //   );
  //   // CircularProgressIndicator(
  //   //   color: Colors.green,
  //   //   value: .3,
  //   //   valueColor: AlwaysStoppedAnimation(Colors.red),
  //   // );
  // }
  void signin() async{
   // progress();
      _auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((user) {
        print("error");
        print(user);
        setState(() {
          isvisible = false;
        });
        showMyDialog("Success", "Congratulations! Verified", context);
      }).catchError((e){
        setState(() {
          isvisible = false;
        });
        showMyDialog("Error", e.toString(), context);
      });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Welcome",style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment:Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20,right: 20),
            width: double.infinity,
            //height: 600,
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Sign In",style: TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.orange,
                      //border: Border.all(color: Colors.black,width: 1),
                      boxShadow:[
                        new BoxShadow(
                            color: Colors.red,
                            blurRadius: 8,
                            offset: Offset.zero
                        )
                      ]
                  ),
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        email=value;
                      });
                    },
                   // controller: email,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.email),
                        hintText: "Email"
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.orange,
                      //border: Border.all(color: Colors.black,width: 1),
                      boxShadow:[
                        new BoxShadow(
                            color: Colors.red,
                            blurRadius: 8,
                            offset: Offset.zero
                        )
                      ]
                  ),
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        password=value;
                      });
                    },
                    obscureText: true,
                    //controller: pass,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.lock),
                        hintText: "Password"
                    ),
                  ),
                ),
                SizedBox(height: 60,),
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  //padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.orange,
                      //border: Border.all(color: Colors.black,width: 1),
                      boxShadow:[
                        new BoxShadow(
                            color: Colors.red,
                            blurRadius: 8,
                            offset: Offset.zero
                        )
                      ]
                  ),
                  child: OutlinedButton(
                      onPressed: (){
                        setState(() {
                          isvisible=true;
                        });
                      //  progress();
                        signin();
                      },
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size.fromWidth(325)),
                          backgroundColor: MaterialStateProperty.all(Colors.orange),
                          side: MaterialStateProperty.all(BorderSide.none)
                      ),
                      child: Text("Sign In",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black
                      ),)),
                ),
                SizedBox(height: 30,
                child: Visibility(
                  visible: isvisible,
                  child: CircularProgressIndicator(
                    color: Colors.green,
                    backgroundColor: Colors.white30,
                    strokeWidth: 7,
                    //value: a,
                    semanticsLabel: "please wait",
                    semanticsValue: "done",
                    //valueColor: AlwaysStoppedAnimation(Colors.white30),
                  ),
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account"),
                    GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute
                        (builder: (context)=>HomePage())),
                      child: Text(" Sign Up",style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
              ],
            )
        ),
      ),
    );

  }
}

