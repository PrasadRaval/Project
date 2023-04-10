
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/ui/auth/signup_screen.dart';

import '../../mainui/post/homescreen.dart';
import '../../utils/utils.dart';
import '../../widget/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value) {
      Utils().ToastMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const HomeScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().ToastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Form(
                  key: _formKey,
                  child:Column(
                    children: [
                      const SizedBox(height: 20,),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                              hintText: "Email",
                              helperText: "abcdefgh@gmail.com",
                              prefixIcon: Icon(Icons.alternate_email)
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            }
                          }
                      ),

                      const SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock_clock_outlined),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 50,),
                      RoundButton(
                        title: 'Login',
                        loading: loading,
                        onTap: (){
                          if(_formKey.currentState!.validate()){
                            login();
                          }
                        },
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children:  [
                          const Text("don't have an account"),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>const SignUpScreen()));
                          },
                              child: const Text("Sign Up"))
                        ],
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
