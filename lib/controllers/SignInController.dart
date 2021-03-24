

import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:movie_api/movie_api.dart';

class SigninController extends ResourceController{

  @Operation.post()
  Future<Response> signin() async {
    // Validar contraBD la existencia del usuario y contraseña
    final String token = _signToken();
    return Response.ok(token); 
  }

  String _signToken() {

    final claimSet = JwtClaim(
      issuer: 'PATH',
      subject: '202',
      issuedAt: DateTime.now(),
      maxAge: const Duration(hours: 2)
    );

    const String secret = Properties.jwtsecret;
    return issueJwtHS256(claimSet, secret);
  }
}