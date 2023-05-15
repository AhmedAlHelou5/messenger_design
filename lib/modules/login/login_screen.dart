import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

// reusable components

// 1. timing
// 2. refactor
// 3. quality

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword =true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value){
                          if(value!.isEmpty || !value.toString().contains('@gmail.com')){
                            return 'email address must not be empty';
                          }
                          return null;

                      },
                      onChange: (value){
                        print(value);
                      },
                      label: 'Email',
                      prefix: Icons.email),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value){
                        if(value!.isEmpty ){
                          return 'password  must not be empty';
                        }
                        return null;
                      },
                      onChange: (value){
                        print(value);
                      },
                      label: 'Password',
                      prefix: Icons.lock,
                      isPassword: isPassword,
                      suffix: isPassword ? Icons.visibility:Icons.visibility_off,
                    suffixPresed: (){
                        setState(() {
                          isPassword=! isPassword;

                        });
                    }
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print('${emailController.text}');
                          print('${passwordController.text}');
                        }
                      },
                      text: 'Login',
                      radius: 50),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Register Now',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
