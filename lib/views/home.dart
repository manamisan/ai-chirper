import 'package:ai_chirper/views/app_button.dart';
import 'package:ai_chirper/views/login.dart';
import 'package:ai_chirper/views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_chirper/views/app_logo.dart';

class Home extends ConsumerWidget {
  Home({super.key});

  final wordbookProvider = StateProvider((ref) => 'wordbook');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordbook = ref.watch(wordbookProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('listlist'),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(),
                const SizedBox(height: 24),
                const Text('Welcome to SupaGPT'),
                const SizedBox(height: 16),
                const Text('Log in with your account to continue'),
                const SizedBox(height: 24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButton(
                      width: 80,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      text: 'Log in',
                    ),
                    const SizedBox(width: 16),
                    AppButton(
                      width: 80,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        );
                      },
                      text: 'Sign up',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
