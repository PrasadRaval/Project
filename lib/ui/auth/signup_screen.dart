
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../../widget/round_button.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void signup(){
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
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
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter Email";
                        }if(value.endsWith("@gmail.com")){
                          return null;
                        }
                        return  "Enter Correct Email";
                      },
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
                      title: 'Sign Up',
                      loading: loading,
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          signup();
                        }
                      },
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children:  [
                        const Text("already have an account"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>const LoginScreen()));
                        },
                            child: const Text("Sign In"))
                      ],
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}