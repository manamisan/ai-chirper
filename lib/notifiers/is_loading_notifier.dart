import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_loading_notifier.g.dart';

@riverpod
class IsLoadingNotifier extends _$IsLoadingNotifier {
  @override
  bool build() {
    debugPrint("isLoading switching");
    return false;
  }

  void setIsLoading(bool isLoading) {
    state = isLoading;
  }
}
