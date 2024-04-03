import 'package:flutter/material.dart';

import 'drives_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 60,
                                child: Icon(
                                  Icons.person_outline_rounded,
                                  size: 90,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              )),
          Flexible(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          right: 40,
                          left: 40,
                          top: -50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 20),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.alternate_email_rounded,
                                            size: 22,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          errorMaxLines: 4,
                                          contentPadding:
                                              const EdgeInsets.all(8),
                                          label: const Text("UID"),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 20),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock_outline_rounded,
                                            size: 22,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          errorMaxLines: 4,
                                          contentPadding:
                                              const EdgeInsets.all(8),
                                          label: const Text("Password"),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 14.0, bottom: 5),
                                      child: TextButton(
                                          onPressed: () {},
                                          child:
                                              const Text("Forgot Password?")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, bottom: 15),
                                      child: ElevatedButton(
                                          onPressed: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    const DrivesScreen(),
                                              )),
                                          child: const Text("Login")),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
