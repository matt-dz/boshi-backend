import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:frontend/src/model/oauth/oauth_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(child: Text('Login')),
      floatingActionButton: FilledButton(
        onPressed: () async {
          OAuthRepository oAuthAgent = OAuthRepository(
            clientId: "http://localhost:8010/proxy/oauth/client-metadata.json",
          );
          Uri authUri = await oAuthAgent.GetAuthorizationURI("");
          if (!await launchUrl(authUri)) {
            throw Exception('Could not launch $authUri');
          }
        },
        child: const Text("Login"),
      ),
    );
  }
}
