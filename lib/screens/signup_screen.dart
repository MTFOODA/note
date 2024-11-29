// ignore_for_file: file_names, must_be_immutable
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logics/signup_logic/cubit.dart';
import 'package:note_app/logics/signup_logic/state.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:note_app/shared/sp.dart';
import 'package:note_app/utilities/colors_dart.dart';
import 'package:note_app/utilities/decoration.dart';
import 'package:note_app/utilities/fonts_dart.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(FirebaseAuth.instance),
      child: Scaffold(
        backgroundColor: AppColors.primaryLM,
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignupSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Sign Up is Successful".tr())),
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            } else if (state is SignupErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 150),
                        Text('Create New Account'.tr(),
                            style: AppFonts.textW24bold),
                        const SizedBox(height: 50),
                        TextFormField(
                          style: AppFonts.textW24bold,
                          controller: emailController,
                          //keyboardType: TextInputType.emailAddress,
                          decoration:
                              customInputDecoration('Email'.tr()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email'.tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          style: AppFonts.textW24bold,
                          controller: passwordController,
                          obscureText: true,
                          decoration:
                              customInputDecoration('Password'.tr()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password'.tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              final email = emailController.text;
                              final password = passwordController.text;
                              await CacheHelper.saveData(
                                  'email', emailController.text);
                              await CacheHelper.saveData(
                                  'password', passwordController.text);
                              context
                                  .read<SignUpCubit>()
                                  .signUp(email, password);
                            }
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: customContainerDecoration(),
                            child: Center(
                              child:
                                  Text("SignUp".tr(), style: AppFonts.textW24bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text(
                            'Already have an account? Login!'.tr(),
                            style: AppFonts.textW16bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
