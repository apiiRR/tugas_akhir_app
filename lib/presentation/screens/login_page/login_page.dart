import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../core/bloc/bloc.dart';
import '../../routes/router.dart';
import '../../utils/app_styles.dart';
import '../../utils/size_config.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/textfield_with_label.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight! * 0.2,
            ),
            Container(
              width: SizeConfig.screenWidth,
              height: 200,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.1,
            ),
            FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldWithLabel(
                      label: "Email Address",
                      name: "email",
                      hintText: "example@gmail.com",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email()
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWithLabel(
                        isPassword: true,
                        label: "Password",
                        name: "password",
                        hintText: "***********",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ])),
                    const SizedBox(
                      height: 40,
                    ),
                    RoundedButton(
                      onPressed: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthEventLogin(
                                    _formKey.currentState!.value["email"]
                                        .toString(),
                                    _formKey.currentState!.value["password"]
                                        .toString()),
                              );
                        }
                      },
                      child: BlocConsumer<AuthBloc, AuthState>(
                          builder: (context, state) {
                        if (state is AuthStateLoading) {
                          return const SizedBox(
                            height: 14,
                            width: 14,
                            child: CircularProgressIndicator(
                              color: primaryWhite,
                            ),
                          );
                        }

                        return textDefaultRoundedButton("Sign In");
                      }, listener: (context, state) {
                        if (state is AuthStateLogin) {
                          context.goNamed(Routes.homePage);
                        }
                        if (state is AuthStateError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      }),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
