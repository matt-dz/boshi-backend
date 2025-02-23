import 'dart:collection';

import 'package:atproto/atproto_oauth.dart';
import 'package:atproto/atproto.dart' as atp;
import 'package:flutter/material.dart';

import 'package:frontend/src/model/oauth/oauth_service.dart';

class OAuthRepository extends ChangeNotifier {
  OAuthRepository({required Uri clientId}) : _clientId = clientId;

  final Uri _clientId;
  late OAuthClientMetadata _oAuthClientMetadata;
  late OAuthClient _oAuthClient;
  late OAuthContext _oAuthContext;
  OAuthSession? _oAuthSession;
  atp.ATProto? _atProto;

  OAuthContext? get oAuthContext => _oAuthContext;
  OAuthSession? get oAuthSession => _oAuthSession;
  atp.ATProto? get atProtoSession => _atProto;

  final OAuthService _oAuthService = OAuthService();

  Future<void> getOAuthClient() async {
    if (_clientId.isScheme('http')) {
      _oAuthClientMetadata = OAuthClientMetadata.fromJson({
        "client_id": "${_clientId.scheme}://${_clientId.host}",
        "client_name": "Boshi",
        "client_uri": _clientId.toString(),
        "redirect_uris": ["http://127.0.0.1:${_clientId.port}/"],
        "grant_types": ["authorization_code", "refresh_token"],
        "scope": "atproto",
        "response_types": ["code"],
        "token_endpoint_auth_method": "none",
        "application_type": "web",
        "dpop_bound_access_tokens": true
      });
    } else {
      _oAuthClientMetadata =
          await _oAuthService.getClientMetadata(_clientId.toString());
    }

    _oAuthClient = OAuthClient(_oAuthClientMetadata);
  }

  Future<Uri> getAuthorizationURI(String identity) async {
    try {
      await getOAuthClient();

      final (uri, context) = await _oAuthService.getOAuthAuthorizationURI(
        _oAuthClient,
        identity,
      );

      _oAuthContext = context;

      notifyListeners();

      return uri;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getSession(String callback) async {
    try {
      await getOAuthClient();

      final (oAuthSession, atProto) = await OAuthService().getOAuthSession(
        _oAuthClient,
        Uri.base.toString(),
      );

      _oAuthSession = oAuthSession;
      _atProto = atProto;

      notifyListeners();
    } on OAuthException {
      rethrow;
    } on ArgumentError {
      rethrow;
    }
  }

  Future<void> refreshSession() async {
    try {
      await getOAuthClient();

      final session = await OAuthService().refreshWithoutSession();
      print(session);
    } on ArgumentError {
      rethrow;
    }
  }
}
