/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'dart:typed_data';

import 'package:tiki_idp/tiki_idp.dart';

import '../rsp_default.dart';
import 'key_flutter.dart';
import 'req/req_export.dart';
import 'req/req_import.dart';
import 'req/req_key.dart';
import 'req/req_sign.dart';
import 'req/req_verify.dart';
import 'rsp/rsp_export.dart';
import 'rsp/rsp_is_initialized.dart';
import 'rsp/rsp_sign.dart';
import 'rsp/rsp_token.dart';
import 'rsp/rsp_verify.dart';

class IdpWrapper {
  late final TikiIdp? _idp;

  IdpWrapper({TikiIdp? idp}) {
    if (idp != null) _idp = idp;
  }

  TikiIdp initialize(String clientId, {List<String>? scope}) {
    KeyFlutter platform = KeyFlutter();
    scope ??= List.of(["storage", "registry"]);
    _idp = TikiIdp(scope, clientId, platform);
    return _idp!;
  }

  RspIsInitialized get isInitialized =>
      RspIsInitialized(isInitialized: _idp != null);

  Future<RspDefault> key(ReqKey req) async {
    await _idp!.key(req.keyId!, overwrite: req.overwrite ?? false);
    return RspDefault();
  }

  Future<RspExport> export(ReqExport req) async {
    String key = await _idp!.export(req.keyId!, public: req.public ?? false);
    return RspExport(key);
  }

  Future<RspDefault> import(ReqImport req) async {
    await _idp!.import(req.keyId!, req.key!, public: req.public ?? false);
    return RspDefault();
  }

  Future<RspSign> sign(ReqSign req) async {
    Uint8List signature = await _idp!.sign(req.keyId!, req.message!);
    return RspSign(signature);
  }

  Future<RspVerify> verify(ReqVerify req) async {
    bool isVerified =
        await _idp!.verify(req.keyId!, req.message!, req.signature!);
    return RspVerify(isVerified: isVerified);
  }

  Future<RspToken> token() async {
    JWT jwt = await _idp!.token;
    return RspToken.from(jwt);
  }
}
