/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_idp/auth/jwt.dart';

import '../../rsp.dart';

class RspToken extends Rsp {
  final String accessToken;
  final String tokenType;
  final int expires;
  final String? refreshToken;
  final List<String>? scope;

  RspToken(this.accessToken, this.tokenType, this.expires,
      {String? requestId, this.refreshToken, this.scope})
      : super(requestId);

  RspToken.from(JWT jwt, {String? requestId})
      : accessToken = jwt.accessToken,
        tokenType = jwt.tokenType,
        expires = jwt.expires.millisecondsSinceEpoch,
        refreshToken = jwt.refreshToken,
        scope = jwt.scope,
        super(requestId);

  @override
  Map<String, dynamic> toMap() => {
        "accessToken": accessToken,
        "tokenType": tokenType,
        "expires": expires,
        "refreshToken": refreshToken,
        "scope": scope,
        "request_id": requestId
      };
}
