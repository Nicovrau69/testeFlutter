import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testeflutter/screens/main/controller/login_cubit.dart';
import 'package:testeflutter/screens/main/controller/login_state.dart';
import 'package:testeflutter/widgets/divider_with_text.dart';
import 'package:testeflutter/widgets/input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Center(
          child: SizedBox(
            width: 450,
            child: Column(
              children: [
                Container(
                  height: 300,
                ),
                Input(
                  onChanged: (a) {},
                  label: "Login",
                  value: state.user,
                ),
                Input(
                  onChanged: (a) {},
                  label: "Senha",
                  value: state.senha,
                ),
                GestureDetector(
                  child: const Text(
                    "Esqueci minha senha",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {},
                ),
                const DividerWithText(message: "ou")
              ],
            ),
          ),
        );
      },
    );
  }
}
