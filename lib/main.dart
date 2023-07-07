/*
 *  Copyright (c) TIKI Inc.
 *  MIT license. See LICENSE file in root directory.
 */

/// Not used. Required by Dart Runtime for native implementations
///@nodoc
import 'package:flutter/material.dart';

import 'src/channel.dart';

/// The Dart entry point for Channel integration.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Channel();
}
