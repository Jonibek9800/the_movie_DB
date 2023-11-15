import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/widgets/auth/auth_cubit.dart';

import '../../Theme/app_button_style.dart';
import '../../ui/navigator/main_navigator.dart';

class AuthDataStorage {
  String login = "";
  String password = "";
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewCubit, AuthViewCubitState>(
      listener: (BuildContext context, AuthViewCubitState state) =>
          _onAuthViewCubitStateChange(state, context),
      child: Provider(
        create: (_) => AuthDataStorage(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Login to your account",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
            centerTitle: true,
          ),
          body: ListView(
            children: const [_HeaderWidget()],
          ),
        ),
      ),
    );
  }

  void _onAuthViewCubitStateChange(
      AuthViewCubitState state, BuildContext context) {
    if (state is AuthViewCubitSuccessState) {
      MainNavigation.resetNavigation(context);
    }
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16, color: Colors.black);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FormWidget(),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Чтобы пользоваться правкой и возможностями рейтинга TMDB, а также '
            'получить персональные рекомендации, необходимо войти в свою учётную запись. '
            'Если у вас нет учётной записи, её регистрация является бесплатной и простой. ',
            style: textStyle,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/sign_up");
              },
              style: AppButtonStyle.linkButton,
              child: const Text("Регистрация")),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Если Вы зарегистрировались, но не получили письмо для подтверждения. '
            'Нажмите на кнопку ниже.',
            style: textStyle,
          ),
          TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: const Text("Верификация")),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthDataStorage>();

    const color = Color(0xFF01B4E4);
    const textFieldDecoration = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      isCollapsed: true,
    );
    const textStyle = TextStyle(fontSize: 16, color: Color(0xFF212529));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMassageWidget(),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Имя пользователя",
          style: textStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          decoration: textFieldDecoration,
          onChanged: (text) => model.login = text,
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Пароль",
          style: textStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          decoration: textFieldDecoration,
          onChanged: (text) => model.password = text,
          obscureText: true,
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            _AuthButtonWidget(color: color),
            const SizedBox(
              width: 10,
            ),
            TextButton(
                onPressed: () {
                  print("Reset");
                },
                style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all(color),
                  foregroundColor: MaterialStateProperty.all(color),
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                ),
                child: const Text(
                  "Сбросить пароль",
                ))
          ],
        )
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthViewCubit>();
    final storage = context.read<AuthDataStorage>();
    final canStartAuth = cubit.state is AuthViewCubitFormFillInProgressState ||
        cubit.state is AuthViewCubitErrorState;
    final onPressed = canStartAuth
        ? () => cubit.auth(
              login: storage.login,
              password: storage.password,
            )
        : null;
    final child = cubit.state is AuthViewCubitProgressState
        ? const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ))
        : const Text("Войти");
    return Container(
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10))),
        child: child,
      ),
    );
  }
}

class _ErrorMassageWidget extends StatelessWidget {
  const _ErrorMassageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMassege = context.select((AuthViewCubit m) {
      final state = m.state;
      return state is AuthViewCubitErrorState ? state.errorMassage : null;
    });
    if (errorMassege == null) return const SizedBox.shrink();

    //
    //
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Text(
        errorMassege,
        style: const TextStyle(color: Colors.red, fontSize: 17),
      ),
    );
  }
}
