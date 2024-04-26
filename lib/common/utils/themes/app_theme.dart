import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


abstract class CustomTheme {
  final CustomColors colors;
  final CustomTextTheme textTheme;



  List<ThemeExtension> get extensions => [colors, textTheme];

  CustomTheme({
    required this.colors,
    required this.textTheme
  });
}

final class SharedColors {
  final white = const Color(0xFFF4F5E9);
  final brown = const Color(0xFF926A53);
  final green = const Color(0xFF78B76D);
  final sea = const Color(0xFF51A394);
  final blue = const Color(0xFF5190EF);
  final black = const Color(0xFF2F2F2F);
  final yellow = const Color(0xFFF1AE5F);
  final red = const Color(0xFFE35050);
  final pink = const Color(0xFFEE9DC3);
  final purple = const Color(0xFF886598);

}

class CustomColors extends ThemeExtension<CustomColors> {
  final Color primary;
  final Color secondary;
  final Color tertiary;

  final Color accent;
  final Color accent50;

  final Color coldGrey;

  final Color txPrimary;

  final SharedColors shared = SharedColors();

  CustomColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.accent,
    required this.accent50,
    required this.coldGrey,
    required this.txPrimary,
  });

  @override
  ThemeExtension<CustomColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? accent,
    Color? accent50,
    Color? coldGrey,
    Color? txPrimary
}) {
    return CustomColors(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        tertiary: tertiary ?? this.tertiary,
        accent: accent ?? this.accent,
        accent50: accent50 ?? this.accent50,
        coldGrey: coldGrey ?? this.coldGrey,
        txPrimary: txPrimary ?? this.txPrimary
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(covariant CustomColors? other, double t) {
    if (other == null) {
      return this;
    }

    return CustomColors(
        primary: Color.lerp(primary, other.primary, t)!,
        secondary: Color.lerp(secondary, other.secondary, t)!,
        tertiary: Color.lerp(tertiary, other.tertiary, t)!,
        accent: Color.lerp(accent, other.accent, t)!,
        accent50: Color.lerp(accent50, other.accent50, t)!,
        coldGrey: Color.lerp(coldGrey, other.coldGrey, t)!,
        txPrimary: Color.lerp(txPrimary, other.txPrimary, t)!
    );
  }

}

class CustomTextTheme extends ThemeExtension<CustomTextTheme> {

  final TextStyle screen;

  final TextStyle header1;
  final TextStyle header2;

  final TextStyle main;
  final TextStyle mainFeature;
  final TextStyle mainFat;
  final TextStyle mainLight;

  final TextStyle button;
  final TextStyle form;
  final TextStyle hint;
  final TextStyle subject;

  final TextStyle smol;

  CustomTextTheme({
    required this.screen,
    required this.header1,
    required this.header2,
    required this.main,
    required this.mainFeature,
    required this.mainFat,
    required this.mainLight,
    required this.button,
    required this.form,
    required this.hint,
    required this.subject,
    required this.smol

  });


  @override
  ThemeExtension<CustomTextTheme> copyWith({
    TextStyle? screen,
    TextStyle? header1,
    TextStyle? header2,
    TextStyle? main,
    TextStyle? mainFeature,
    TextStyle? mainFat,
    TextStyle? mainLight,
    TextStyle? button,
    TextStyle? form,
    TextStyle? hint,
    TextStyle? subject,
    TextStyle? smol,

}) {
    return CustomTextTheme(
        screen: screen ?? this.screen,
        header1: header1 ?? this.header1,
        header2: header2 ?? this.header2,
        main: main ?? this.main,
        mainFeature: mainFeature ?? this.mainFeature,
        mainFat: mainFat ?? this.mainFat,
        mainLight: mainLight ?? this.mainLight,
        button: button ?? this.button,
        form: form ?? this.form,
        hint: hint ?? this.hint,
        subject: subject ?? this.subject,
        smol: smol ?? this.smol
    );
  }

  @override
  ThemeExtension<CustomTextTheme> lerp(
      covariant CustomTextTheme? other,
      double t
      ) {
    if (other == null) return this;
    return CustomTextTheme(
        screen: TextStyle.lerp(screen, other.screen, t)!,
        header1: TextStyle.lerp(header1, other.header1, t)!,
        header2: TextStyle.lerp(header2, other.header2, t)!,
        main: TextStyle.lerp(main, other.main, t)!,
        mainFeature: TextStyle.lerp(mainFeature, other.mainFeature, t)!,
        mainFat: TextStyle.lerp(mainFat, other.mainFat, t)!,
        mainLight: TextStyle.lerp(mainLight, other.mainLight, t)!,
        button: TextStyle.lerp(button, other.button, t)!,
        form: TextStyle.lerp(form, other.form, t)!,
        hint: TextStyle.lerp(hint, other.hint, t)!,
        subject: TextStyle.lerp(subject, other.subject, t)!,
        smol: TextStyle.lerp(smol, other.smol, t)!

    );
  }

}

class SharedTextTheme extends CustomTextTheme {
  SharedTextTheme({
    required CustomColors colors,
}) : super (
    screen: GoogleFonts.roboto(
      fontSize: 32.sp,
      fontWeight: FontWeight.w400,
      color: colors.txPrimary
    ),
    header1: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.w300,
        color: colors.txPrimary
    ),
    header2: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w300,
        color: colors.txPrimary
    ),
    main: GoogleFonts.roboto(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: colors.txPrimary
    ),
    mainFeature: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w300,
        color: colors.txPrimary
    ),
    mainFat: GoogleFonts.roboto(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: colors.txPrimary
    ),
    mainLight: GoogleFonts.roboto(
        fontSize: 15.sp,
        fontWeight: FontWeight.w300,
        color: colors.txPrimary
    ),
    button: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w900,
        color: colors.txPrimary
    ),
    form: GoogleFonts.roboto(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: colors.txPrimary
    ),
    hint: GoogleFonts.roboto(
        fontSize: 15.sp,
        fontWeight: FontWeight.w300,
        color: colors.txPrimary
    ),
    subject: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: colors.txPrimary
    ),
    smol: GoogleFonts.roboto(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: colors.txPrimary
    )

  );
}