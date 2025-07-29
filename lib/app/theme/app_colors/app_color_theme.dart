import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/theme/theme.dart';

class AppColorTheme {
  final Color text;
  final Color fill;
  final Color hintText;
  final Color background;
  final Color foreground;
  final Color activeStatus;
  final Color disableStatus;
  final Color activeButton;
  final Color disableButton;

  static final light = AppColorTheme._(
    text: AppColors.black,
    fill: AppColors.veryLightGrey,
    hintText: AppColors.lightGrey,
    foreground: AppColors.white,
    disableStatus: AppColors.red,
    activeStatus: AppColors.green,
    activeButton: AppColors.softCyan,
    background: AppColors.almostWhite,
    disableButton: AppColors.lightGrey,
  );

  static final dark = AppColorTheme._(
    text: AppColors.white,
    fill: AppColors.charcoalBlue,
    hintText: AppColors.steelGray,
    activeButton: AppColors.green,
    disableStatus: AppColors.red,
    activeStatus: AppColors.green,
    background: AppColors.darkBlue,
    disableButton: AppColors.slateGray,
    foreground: AppColors.charcoalBlue,
  );

  const AppColorTheme._({
    required this.text,
    required this.fill,
    required this.hintText,
    required this.foreground,
    required this.background,
    required this.activeStatus,
    required this.activeButton,
    required this.disableButton,
    required this.disableStatus,
  });

  static AppColorTheme of(BuildContext context) => context.color;
}

extension AppColorThemeExtension on BuildContext {
  AppColorTheme get color => theme.color;
}
