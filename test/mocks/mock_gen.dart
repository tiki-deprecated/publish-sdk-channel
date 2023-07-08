/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/services.dart';
import 'package:mockito/annotations.dart';
import 'package:tiki_idp/tiki_idp.dart';
import 'package:tiki_sdk_native/src/idp/idp_wrapper.dart';
import 'package:tiki_sdk_native/src/trail/trail_wrapper.dart';

@GenerateNiceMocks([
  MockSpec<TikiIdp>(),
  MockSpec<MethodChannel>(),
  MockSpec<TrailWrapper>(),
  MockSpec<IdpWrapper>()
])
void main() {}
