import 'dart:math';

import 'package:ai_chirper/notifiers/is_loading_notifier.dart';
import 'package:ai_chirper/views/app_button.dart';
import 'package:ai_chirper/views/app_logo.dart';
import 'package:ai_chirper/views/chat.dart';
import 'package:ai_chirper/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUp extends ConsumerWidget {
  SignUp({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
              const SizedBox(height: 24),
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
                    return 'Email address is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                cursorColor: Colors.pink,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Password does not match';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        AppButton(
          height: 48,
          isLoading: isLoading,
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;

            final isLoadingNotifier =
                ref.read(isLoadingNotifierProvider.notifier);
            isLoadingNotifier.setIsLoading(true);

            final result = await _signUp(context,
                email: _emailController.text,
                password: _passwordController.text);

            isLoadingNotifier.setIsLoading(false);
            if (result == null || !context.mounted) return;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Chat(),
              ),
            );
          },
          text: 'Continue',
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Already have an account?"),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: const Text('Log in'),
            ),
          ],
        ),
      ]),
    )));
  }

  Future<dynamic> _signUp(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      return await Supabase.instance.client.auth
          .signUp(email: email, password: password);
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
}
