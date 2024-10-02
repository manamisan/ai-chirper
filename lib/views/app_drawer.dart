import 'package:ai_chirper/notifiers/is_loading_notifier.dart';
import 'package:ai_chirper/views/app_button.dart';
import 'package:ai_chirper/views/app_logo.dart';
import 'package:ai_chirper/views/chat.dart';
import 'package:ai_chirper/views/login.dart';
import 'package:ai_chirper/views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppDrawer extends ConsumerWidget {
  AppDrawer({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingNotifierProvider);

    return Drawer(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      ListTile(
        title: TextButton(
          onPressed: () async {
            final loggedOut = await _logout(context);
            if (loggedOut && context.mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            }
          },
          child: const Text(
            'Log out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.red,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      )
    ]));
  }

  Future<bool> _logout(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }
}
