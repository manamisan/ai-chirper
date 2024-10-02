import 'package:ai_chirper/notifiers/is_loading_notifier.dart';
import 'package:ai_chirper/views/app_button.dart';
import 'package:ai_chirper/views/app_logo.dart';
import 'package:ai_chirper/views/chat.dart';
import 'package:ai_chirper/views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends ConsumerWidget {
  Login({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingNotifierProvider);

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const AppLogo(),
        const Text(
          'Welcome back',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email address',
                ),
                obscureText: false,
                cursorColor: Colors.pink,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email address is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true,
                cursorColor: Colors.pink,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        AppButton(
          isLoading: isLoading,
          height: 48,
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;

            final isLoadingNotifier =
                ref.read(isLoadingNotifierProvider.notifier);
            isLoadingNotifier.setIsLoading(true);

            final result = await _login(
              context,
              email: _emailController.text,
              password: _passwordController.text,
            );

            isLoadingNotifier.setIsLoading(true);

            if (result == null || !context.mounted) return;

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Chat()));
          },
          text: 'Continue',
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUp(),
                  ),
                );
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ]),
    )));
  }

  Future<dynamic> _login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      return await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
}
