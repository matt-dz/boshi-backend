import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:frontend/src/model/oauth/oauth_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
          child: ShadCard(
              width: 350,
              title: const Text('Sign In'),
              description:
                  const Text('Use your identity to sign in with OAuth'),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ShadForm(
                      key: formKey,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ShadInputFormField(
                                id: 'login_input_form',
                                label: const Text("Identity"),
                                placeholder: const Text('Enter your identity'),
                                description: const Text(
                                    "Login with any identifier on the atprotocol"),
                                validator: (v) {
                                  if (v.isEmpty) {
                                    return 'Identifier must not be empty';
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 16),
                            Consumer<OAuthRepository>(
                              builder: (context, oauth, child) {
                                return ShadButton(
                                  child: const Text("Sign in"),
                                  onPressed: () async {
                                    if (formKey.currentState!
                                        .saveAndValidate()) {
                                      Uri authUri = await oauth
                                          .getAuthorizationURI(formKey
                                              .currentState!
                                              .value["login_input_form"]);
                                      if (!await launchUrl(authUri)) {
                                        throw Exception(
                                            'Could not launch $authUri');
                                      }
                                    }
                                  },
                                );
                              },
                            )
                          ]))))),
    );
  }
}
