import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/drive_bloc.dart';
import '../bloc/drive_events.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_bloc_states.dart';
import '../bloc/login_events.dart';
import '../bloc/resume_bloc.dart';

import '../bloc/resume_events.dart';
import 'drives_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            (previous is LoggingInState && current is LoggedInState) ||
            (previous is LoggingInState && current is LoginFailedState),
        listener: (context, state) => {
              if (state is LoginFailedState)
                {
                  ScaffoldMessenger.of(context).clearSnackBars(),
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.authError.toString().split(": ")[1])))
                }
              else if (state is LoggedInState)
                {
                  BlocProvider.of<DriveBloc>(context).add(FetchDrivesEvent(
                      driveID: null,
                      token: (BlocProvider.of<LoginBloc>(context).state
                              as LoggedInState)
                          .student
                          .token,
                      studentID: (BlocProvider.of<LoginBloc>(context).state
                              as LoggedInState)
                          .student
                          .id)),
                  BlocProvider.of<ResumeBloc>(context).add(FetchResumesEvent(
                      studentID: (BlocProvider.of<LoginBloc>(context).state
                              as LoggedInState)
                          .student
                          .id)),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DrivesScreen(),
                  ))
                }
            },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                              color: Theme.of(context).primaryColor,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage('assets/images/logo.png'),
                                    width: 200,
                                    height: 200,
                                  )
                                ],
                              )),
                        ),
                      ],
                    )),
                Flexible(
                    flex: 3,
                    child: SizedBox(
                      width: min(MediaQuery.of(context).size.width, 1000),
                      height: min(MediaQuery.of(context).size.height, 350),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  right: 15,
                                  left: 15,
                                  top: -70,
                                  bottom: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withAlpha(Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? 60
                                                    : 170),
                                            blurRadius: 100,
                                            spreadRadius: .25,
                                          )
                                        ],
                                      ),
                                      child: Form(
                                        key: formKey,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 28),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "Welcome",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium,
                                                    ),
                                                  ),
                                                  const Flexible(
                                                    child: SizedBox(
                                                      height: 12,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "Login to Placement Portal",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                  ),
                                                  const Flexible(
                                                    child: SizedBox(
                                                      height: 16,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 16),
                                                      child: TextFormField(
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        validator: (spy) {
                                                          RegExp regex = RegExp(
                                                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                                          if (spy == null ||
                                                              regex.hasMatch(
                                                                      spy) ==
                                                                  false) {
                                                            return "Please enter correct email";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        controller:
                                                            emailController,
                                                        decoration:
                                                            InputDecoration(
                                                          prefixIcon: Icon(
                                                            Icons
                                                                .alternate_email_rounded,
                                                            size: 22,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                          errorMaxLines: 4,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          label: const Text(
                                                              "Email"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 16),
                                                      child: TextFormField(
                                                        onFieldSubmitted: (value) => formKey
                                                                .currentState!
                                                                .validate()
                                                            ? BlocProvider.of<
                                                                        LoginBloc>(
                                                                    context)
                                                                .add(InitiateLoginEvent(
                                                                    universityEmail:
                                                                        emailController
                                                                            .text
                                                                            .trim()
                                                                            .toLowerCase(),
                                                                    password:
                                                                        passwordController
                                                                            .text
                                                                            .trim()))
                                                            : null,
                                                        validator: (spy) {
                                                          if (spy == null ||
                                                              spy.isEmpty) {
                                                            return "Please enter your password";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        obscureText:
                                                            !_passwordVisible,
                                                        controller:
                                                            passwordController,
                                                        decoration:
                                                            InputDecoration(
                                                          prefixIcon: Icon(
                                                            Icons
                                                                .lock_outline_rounded,
                                                            size: 22,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                          suffixIcon:
                                                              IconButton(
                                                            icon: Icon(
                                                              size: 22,
                                                              _passwordVisible
                                                                  ? Icons
                                                                      .visibility
                                                                  : Icons
                                                                      .visibility_off,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                _passwordVisible =
                                                                    !_passwordVisible;
                                                              });
                                                            },
                                                          ),
                                                          errorMaxLines: 4,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          label: const Text(
                                                              "Password"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Flexible(
                                                    child: SizedBox(
                                                      height: 12,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12.0,
                                                              bottom: 15),
                                                      child: state
                                                                  is LoggingInState ||
                                                              state
                                                                  is LoggedInState
                                                          ? const SizedBox(
                                                              width: 30,
                                                              height: 30,
                                                              child:
                                                                  CircularProgressIndicator())
                                                          : ElevatedButton(
                                                              onPressed: () => formKey
                                                                      .currentState!
                                                                      .validate()
                                                                  ? BlocProvider.of<LoginBloc>(context).add(InitiateLoginEvent(
                                                                      universityEmail: emailController
                                                                          .text
                                                                          .trim()
                                                                          .toLowerCase(),
                                                                      password: passwordController
                                                                          .text
                                                                          .trim()))
                                                                  : null,
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Text(
                                                                  "Login",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          );
        });
  }
  // );
  // }
}
