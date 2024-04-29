import 'package:reactive_forms/reactive_forms.dart';

const emailPattern = r'\w{1,}\.{1}\w{1}\.{1}\w{1}\d*@edu\.mirea\.ru';

final emailValidator = Validators.pattern(emailPattern);