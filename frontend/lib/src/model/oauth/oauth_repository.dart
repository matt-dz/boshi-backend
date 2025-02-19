import 'package:atproto/atproto_oauth.dart';
import 'package:atproto/atproto.dart' as atp;

import 'package:frontend/src/model/oauth/oauth_service.dart';

class OAuthRepository {
  OAuthRepository({required String clientId}) : _clientId = clientId;

  final String _clientId;
  late OAuthClientMetadata _oAuthClientMetadata;
  late OAuthClient _oAuthClient;
  late OAuthContext _oAuthContext;
  late OAuthSession _oAuthSession;

  final OAuthService _oAuthService = OAuthService();

  Future<OAuthClient> getOAuthClient() async {
    _oAuthClientMetadata = await _oAuthService.getClientMetadata(_clientId);

    _oAuthClient = OAuthClient(_oAuthClientMetadata);

    return _oAuthClient;
  }

  Future<Uri> getAuthorizationURI(String identity) async {
    try {
      await getOAuthClient();

      final (uri, context) = await _oAuthService.getOAuthAuthorizationURI(
        _oAuthClient,
        _clientId,
        identity,
      );

      _oAuthContext = context;

      return uri;
    } catch (e) {
      rethrow;
    }
  }

  Future<atp.ATProto> getSession(String callback) async {
    try {
      await getOAuthClient();

      final (oAuthSession, atProto) = await OAuthService().getOAuthSession(
        _oAuthClient,
        Uri.base.toString(),
      );

      _oAuthSession = oAuthSession;

      return atProto;
    } on OAuthException {
      rethrow;
    } on ArgumentError {
      rethrow;
    }
  }
}
