import 'package:flutter/material.dart';
import 'package:gasoline/screens/sign_in.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../preference/user_preference.dart';
import '../provider/user_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<User> getUser() => UserPreference().getUser();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    getUser().then((value)  {
       User user = User(user: value.user, token: value.token);
       userProvider.setUser(user);
      
      });
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Text("Welcome ${userProvider.changeName}"),

              Container(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                      UserPreference().removeUser();
                      Navigator.pushReplacement(context,
                       MaterialPageRoute(builder:
                        ((context) => const SignInScreen())));
                  },
                  child: const Text("Log out")),
              )
            ],
          ),
        ),
      ),
    );
  }
}