import 'package:atproto/core.dart';
import 'package:flutter/material.dart';

import 'package:atproto/atproto.dart' as atp;
import 'package:atproto/atproto_oauth.dart';
import 'package:go_router/go_router.dart';

import 'package:frontend/src/model/oauth/oauth_repository.dart';

class RedirectPage extends StatefulWidget {
  const RedirectPage({super.key});

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        OAuthRepository oAuthAgent = OAuthRepository(
          clientId: "${Uri.base.origin}/oauth/client-metadata.json",
        );
        atp.ATProto atProto = await oAuthAgent.GetSession(Uri.base.toString());

        context.go("/");
      } on OAuthException {
        rethrow;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
