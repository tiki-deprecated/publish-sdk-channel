/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

library flutter_key_storage;

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:tiki_idp/rsa/rsa_private_key.dart';
import 'package:tiki_idp/tiki_idp.dart';

class KeyFlutter implements KeyPlatform {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> read(String key) async => await secureStorage.read(key: key);

  @override
  Future<void> write(String key, String value) async =>
      await secureStorage.write(key: key, value: value);

  @override
  Future<String> generate() => compute((_) => _generate(), "").then((pk) => pk);

  static Future<String> _generate() async {
    FortunaRandom secureRandom = FortunaRandom();
    Random random = Random.secure();
    final seeds = <int>[];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    final keyGen = RSAKeyGenerator()
      ..init(ParametersWithRandom(
          RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 64),
          secureRandom));
    AsymmetricKeyPair<PublicKey, PrivateKey> keyPair = keyGen.generateKeyPair();
    RSAPrivateKey privateKey = keyPair.privateKey as RSAPrivateKey;
    return RsaPrivateKey(privateKey.modulus!, privateKey.privateExponent!,
            privateKey.p, privateKey.q)
        .encode();
  }
}
