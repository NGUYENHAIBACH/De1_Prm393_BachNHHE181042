import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/settings_repository.dart';

part 'theme_viewmodel.g.dart';


const List<Color> kAppBarColors = [
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.indigo,
  Colors.teal,
  Colors.deepPurple,
  Colors.lightGreen,
  Colors.blueGrey,
];

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) => SettingsRepository();

@Riverpod(keepAlive: true)
class AppBarColor extends _$AppBarColor {
  @override
  Future<Color> build() async {
    final saved = await ref.read(settingsRepositoryProvider).getAppBarColor();
    return saved != null ? Color(saved) : Colors.blue;
  }

  Future<void> changeColor(Color color) async {
    state = AsyncData(color);
    await ref.read(settingsRepositoryProvider).saveAppBarColor(color.value);
  }
}
