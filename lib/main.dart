import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/common/core/dependency_override.dart';
import 'package:student_helper/common/domain/state/navigation/navigation_controller.dart';
import 'package:student_helper/common/domain/state/theme/theme_controller.dart';
import 'package:student_helper/common/navigation/router.dart';
import 'package:student_helper/common/utils/schedule_dates_creator.dart';
import 'package:student_helper/common/utils/validators.dart';

import 'generated/locale_keys.g.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      child: ProviderScope(
          overrides: await getOverridesDependency(),
          child: StudentHelperApp()
      )
  ));
}

class StudentHelperApp extends HookConsumerWidget {
  const StudentHelperApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch(appRouterProvider);
    final navigationState = ref.watch(navigationControllerProvider);

    final validationMessages = {
      ValidationMessage.required: (error) =>
          LocaleKeys.validation_messages_required.tr(),
      ValidationMessage.mustMatch: (error) =>
          LocaleKeys.validation_messages_must_match.tr(),
      ValidationMessage.minLength: (error) =>
          LocaleKeys.validation_messages_min_length
              .tr(args: [error['requiredLength'].toString()]),
      ValidationMessage.pattern: (error) {
        if (error['requiredPattern'] == emailPattern) {
          return LocaleKeys.validation_messages_email_pattern.tr();
        } else {
          return error.toString();
        }
      },
      ValidationMessage.any: (error) => error.toString(),
    };



    const designSize = Size(360, 800);

    return MediaQuery(
      data: MediaQuery.of(context),
      child: ReactiveFormConfig(
        validationMessages: validationMessages,
        child: ScreenUtilInit(
          designSize: designSize,
          splitScreenMode: true,
          minTextAdapt: true,
          fontSizeResolver: (fontSize, instance) {
            final display = View.of(context).display;
            final screenSize = display.size / display.devicePixelRatio;
            final scaleWidth = screenSize.width / designSize.width;
        
            return fontSize * scaleWidth;
          },
          builder: (context, _) {
        
            final customTheme = ref.watch(themeControllerProvider);
        
            final ThemeData theme = Theme.of(context).copyWith(
              canvasColor: customTheme.colors.primary,
            );

            return navigationState.when(
                data: (navigation) {
                  return MaterialApp.router(
                    title: LocaleKeys.app_name.tr(),
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    debugShowCheckedModeBanner: false,
                    locale: context.locale,
                    routerDelegate: RoutemasterDelegate(
                        routesBuilder: (context) {
                          return switch (navigation) {
                            Authorized() => appRouter.router,
                            Unauthorized() => appRouter.auth,
                          };
                        }
                    ),
                    routeInformationParser: const RoutemasterParser(),
                    theme: ThemeData(
                        useMaterial3: true,
                        extensions: customTheme.extensions,
                        scaffoldBackgroundColor: customTheme.colors.primary,
                        primaryColor: customTheme.colors.txPrimary,
                        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                          backgroundColor: customTheme.colors.tertiary,
                        ),
                        textTheme: theme.textTheme.apply(
                            bodyColor: customTheme.colors.txPrimary,
                            displayColor: customTheme.colors.txPrimary,
                            fontFamily: GoogleFonts.roboto().fontFamily
                        ),
                        appBarTheme: AppBarTheme(
                            backgroundColor: customTheme.colors.primary,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12)
                                )
                            ),
                            centerTitle: true,
                            titleTextStyle: customTheme.textTheme.header1
                        ),
                        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
                            filled: true,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.only(
                                bottom: 15.h,
                                top: 15.h,
                                left: 12.w,
                                right: 12.w
                            ),
                            hintStyle: customTheme.textTheme.mainLight.copyWith(
                                color: customTheme.colors.accent50
                            ),
                            fillColor: customTheme.colors.secondary,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: customTheme.colors.accent
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: customTheme.colors.shared.red
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: customTheme.colors.shared.red
                              ),
                            )
                        )
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return const SizedBox.shrink();
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            );




          },
        ),
      ),
    );



  }
}
