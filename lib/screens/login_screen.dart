// ignore_for_file: file_names, must_be_immutable
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:note_app/screens/Home_screen.dart';
import 'package:note_app/screens/signup_screen.dart';
import 'package:note_app/shared/sp.dart';
import 'package:note_app/utilities/colors_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logics/login_logic/cubit.dart';
import 'package:note_app/logics/login_logic/state.dart';
import 'package:note_app/utilities/fonts_dart.dart';
import 'package:note_app/utilities/decoration.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: AppColors.primaryLM,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Login is successful".tr())),
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            } else if (state is LoginErrorState) {
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
                         Text("Welcome Back!".tr(),
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
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              final email = emailController.text;
                              final password = passwordController.text;
                              final cachedEmail =
                                  await CacheHelper.getData('email');
                              final cachedPassword =
                                  await CacheHelper.getData('password');

                              if (email == cachedEmail &&
                                  password == cachedPassword) {
                                context
                                    .read<LoginCubit>()
                                    .login(email, password);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                      content:
                                          Text("Invalid email or password".tr())),
                                );
                              }
                            }
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: customContainerDecoration(),
                            child: Center(
                              child: Text("Login".tr(), style: AppFonts.textW24bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          child: Text(
                            'Don\'t have an account? Sign Up'.tr(),
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
