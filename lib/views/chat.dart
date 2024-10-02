import 'package:ai_chirper/notifiers/is_loading_notifier.dart';
import 'package:ai_chirper/views/app_button.dart';
import 'package:ai_chirper/views/app_drawer.dart';
import 'package:ai_chirper/views/app_logo.dart';
import 'package:ai_chirper/views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Chat extends ConsumerWidget {
  Chat({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingNotifierProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Page'),
        ),
        drawer: AppDrawer(),
        body: Center(child: SingleChildScrollView(child: Text('Chat Page'))));
  }
}
