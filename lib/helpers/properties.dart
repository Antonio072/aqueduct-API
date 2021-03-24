import 'package:jaguar_jwt/jaguar_jwt.dart';

class Properties {
  static const String jwtSecret = "jdsa8d1sadsahjjkld21kjjdsa";

  static bool isAuthorized(String authHeader){
    final parts = authHeader.split(' ');

    if ( parts == null || parts.length != 2 || parts[0] != 'Bearer')
    {
      return false;
    }

    return _isValidToken(parts[1]);
  }

  static bool _isValidToken(String token){

    try{
      verifyJwtHS256Signature(token, jwtSecret);
    } on JwtException{
      print('Invalid token');
      return false;
    }
    return true;
  }
}