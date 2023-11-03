import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';

import '../../Theme/app_button_style.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () {
                  print('back');
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 50,
            ),
            const Text(
              "Login to your account",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
      ),
      body: ListView(
        children: const [_HeaderWidget()],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF01B4E4);
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
    AuthViewModel _model = Provider.of<AuthViewModel>(context);

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
    // String errorMessage () {
    //   if(isValid) {
    //     return "Invalid Password or login";
    //   }
    // }
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
          controller: _model.model.loginTextControl,
          decoration: textFieldDecoration,
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
          controller: _model.model.passwordTextControl,
          decoration: textFieldDecoration,
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
                  // style: TextStyle(color: Colors.blue),
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
    AuthViewModel _model = Provider.of<AuthViewModel>(context);
    final onPressed =
    _model.model.canStartAuth == true ? () => _model.auth(context) : null;
    final child = _model.model.isAuthProgress == true
        ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(strokeWidth: 2,))
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
    final _model = Provider.of<AuthViewModel>(context);
    if (_model.model.errorMassege == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Text(
        "${_model.model.errorMassege}",
        style: const TextStyle(color: Colors.red, fontSize: 17),
      ),
    );
  }
}
