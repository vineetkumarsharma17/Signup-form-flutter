import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_up_email/alertdilog.dart';
import 'dart:convert';

import 'package:sign_up_email/signIn.dart';
void main() async{
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    print("success");
  }catch(e){
    print("error found");
    print(e);
  }
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange
        ),
        backgroundColor: Colors.orange
      ),
      home: SignIn(),
    );
  }
}
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth=FirebaseAuth.instance;
  final _firestore=FirebaseFirestore.instance;
  String gogle='assets/images/google.png';
  String msg='Successfully Logged in!';
  String fb='assets/images/fb.png';
  String twiter='assets/images/twiter.png';
  String? email1;
  String? pass1;

  TextEditingController uname=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController pass=new TextEditingController();
  @override
  Future signup() async
  {
    var data = {
      'email': email.text,
      'user_name': uname.text,
      'password': pass.text,
    };

    var response = await http.post(
        Uri.parse("https://indianfarmerbyvkwilson.000webhostapp.com/sign_up.php"),
        body: json.encode(data));

    // Getting Server response into variable.
    var obj = jsonDecode(response.body);

    // If the Response Message is Matched.
    if (obj["result"] == 'S') {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print("Success");
    } else  if (obj["result"] == 'F'){
      print("Failed");
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
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
               child: Text("Sign Up",style: TextStyle(
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
                      email1=value;
                    });
                  },
                  //controller: email,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.email),
                    hintText: "Email"
                  ),
                ),
              ),
              // SizedBox(height: 20,),
              // Container(
              //   height: 60,
              //   alignment: Alignment.center,
              //   padding: EdgeInsets.only(left: 20),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       color: Colors.orange,
              //       //border: Border.all(color: Colors.black,width: 1),
              //       boxShadow:[
              //         new BoxShadow(
              //             color: Colors.red,
              //             blurRadius: 8,
              //             offset: Offset.zero
              //         )
              //       ]
              //   ),
              //   child: TextField(
              //     controller: uname,
              //     decoration: InputDecoration(
              //         border: InputBorder.none,
              //         icon: Icon(Icons.person),
              //         hintText: "Username"
              //     ),
              //   ),
              // ),
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
                  obscureText: true,
                  onChanged: (value){
                    setState(() {
                      pass1=value;
                    });
                  },
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
                  onPressed: signupWithFirebase,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size.fromWidth(325)),
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      side: MaterialStateProperty.all(BorderSide.none)
                    ),
                    child: Text("Sign Up",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black
                    ),)),
              ),
              SizedBox(height: 30,),
              Center(
                child: Text("OR",style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                      //border: Border.all(color: Colors.black,width: 1),
                      shape: BoxShape.circle,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.red,
                          offset: Offset.zero,
                          blurRadius: 8,
                          //spreadRadius: 2
                        )
                      ]
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(gogle),
                      backgroundColor: Colors.orange,
                      radius: 21,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        //border: Border.all(color: Colors.black,width: 1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.red,
                            offset: Offset.zero,
                            blurRadius: 8,
                            //spreadRadius: 2
                          )
                        ]
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(fb),
                      backgroundColor: Colors.orange,
                      radius: 21,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        //border: Border.all(color: Colors.black,width: 1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.red,
                            offset: Offset.zero,
                            blurRadius: 8,
                            //spreadRadius: 2
                          )
                        ]
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(twiter),
                      backgroundColor: Colors.orange,
                      radius: 21,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account"),
                  Text(" Sign In",style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
  check(){
    String e='Please enter a email.';
    String u='Please enter a username.';
    String p='Please enter a password.';
    if(email.text=='')
      msg=e;
    else
    if(uname.text=='')
      msg=u;
    else if(pass.text=='')
      msg=p;

       if(msg=='Successfully Logged in!')
    {
      signup();
      // uname.clear();
      // email.clear();
      // pass.clear();
    }
    print("error");
     //  return("error");
     //  print("error");

  }
  void signupWithFirebase()async{
      final newUser=await _auth.createUserWithEmailAndPassword(email: email1!, password: pass1!
      ).then((SignedUser){
        _firestore.collection("users").add(
          {"email":email1,
            "password":pass1
          }
        ).then((value) {
          if (value != null) {
            showMyDialog("Success", "You are registerd with us.Now you can log in", context);
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => SignIn()));
          }
        }
          ).catchError((e){
            print("error found");
            print(e);
            showMyDialog("Error", e.toString(), context);
        });
      }).catchError((e){
        print("error found");
        print(e);
        showMyDialog("Error", e.toString(), context);
      });
  }
}

