/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
library tiki_sdk;

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/common.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart' as core;

import 'main.dart';
import 'src/platform_channel/flutter_key_storage.dart';

/// The TIKI SDK main class. Use this to add tokenized data ownership, consent, and rewards.
///
/// TikiSdk is a singleton that keeps the latest initialized instance. All the
/// parameters are kept when a new instance is created, except for the address
class TikiSdk {
  static TikiSdk? _instance;
  core.TikiSdk? _core;

  /// The singleton instance of the TikiSdk.
  ///
  /// Accessing this property always returns the same instance of the `TikiSdk`.
  /// This property provides a global point of access to the TikiSdk instance,
  /// allowing it to be easily used throughout your app.
  static TikiSdk get instance {
    _instance ??= TikiSdk._();
    return _instance!;
  }

  /// The wallet address that is in use.
  String? get address => _core?.address;

  /// The current id.
  String? get id => _core?.id;

  /// Private constructor to avoid direct initialization
  TikiSdk._();

  ///Initializes the TIKI SDK.
  ///
  /// Use this method to initialize the TIKI SDK with the specified *publishingId*, *id*, and *origin*.
  /// You can also provide an optional `onComplete` closure that will be executed once the initialization process is complete.
  /// - Parameters:
  ///    - publishingId: The *publishingId* for connecting to the TIKI cloud.
  ///   - id: The ID that uniquely identifies your user.
  ///   - onComplete: An optional closure to be executed once the initialization process is complete.
  ///   - origin: The default *origin* for all transactions. Defaults to `Bundle.main.bundleIdentifier` if *null*.
  /// - Throws: `TikiSdkError` if the initialization process encounters an error.
  Future<void> initialize(String publishingId, String id, String origin,
      {String? dbDir}) async {
    FlutterKeyStorage keyStorage = FlutterKeyStorage();
    String address = await core.TikiSdk.withId(id, keyStorage);
    String dbFile = "${(dbDir ?? await _dbDir())}/$address.db";
    CommonDatabase database = sqlite3.open(dbFile);
    _core =
        await core.TikiSdk.init(publishingId, origin, keyStorage, id, database);
  }

  /// Returns a Boolean value indicating whether the TikiSdk has been initialized.
  ///
  /// If `true`, it means that the TikiSdk has been successfully initialized.
  /// If `false`, it means that the TikiSdk has not yet been initialized or has failed to initialize.
  bool get isInitialized => _core?.address != null;

  /// Guard against an invalid LicenseRecord for a list of usecases and destinations.
  ///
  /// Use this method to verify that a non-expired LicenseRecord for the specified pointer record exists and permits the listed usecases and destinations.
  ///
  /// This method can be used in two ways:
  /// 1. As an async traditional guard, returning a pass/fail boolean:
  /// ```
  /// let pass = await `guard`(ptr: "example-ptr", usecases: [.attribution], destinations: ["https://example.com"])
  /// if pass {
  ///     // Perform the action allowed by the LicenseRecord.
  /// }
  /// ```
  /// 2. As a wrapper around a function:
  /// ```
  /// `guard`(ptr: "example-ptr", usecases: [.attribution], destinations: ["https://example.com"], onPass: {
  ///     // Perform the action allowed by the LicenseRecord.
  /// }, onFail: { error in
  ///     // Handle the error.
  /// })
  /// ```
  ///
  /// - Parameters:
  ///   - ptr: The pointer record for the asset. Used to locate the latest relevant LicenseRecord.
  ///   - usecases: A list of usecases defining how the asset will be used.
  ///   - destinations: A list of destinations defining where the asset will be used, often URLs.
  ///   - onPass: A closure to execute automatically upon successfully resolving the LicenseRecord against the usecases and destinations.
  ///   - onFail: A closure to execute automatically upon failure to resolve the LicenseRecord. Accepts an optional error message describing the reason for failure.
  ///   - origin: An optional override of the default origin specified in the initializer.
  ///
  /// - Returns: `true` if the user has access, `false` otherwise.
  static Future<bool> guard(String ptr, List<LicenseUsecase> usecases,
      {List<String>? destinations = const [],
      String? origin,
      Function()? onPass,
      Function(String)? onFail}) async {
    return instance._core!.guard(ptr, usecases,
        destinations: destinations,
        origin: origin,
        onFail: onFail,
        onPass: onPass);
  }

  /// Starts the configuration process for the Tiki SDK instance.
  ///
  /// This method returns the shared instance of the Tiki SDK, which can be used to configure the SDK before initializing it.
  /// You can access instance variables such as `theme` or `offer`, and call methods such as `disableAcceptEnding(_:)`
  /// and `onAccept(_:)` on the returned instance to customize the SDK behavior to your needs.
  ///
  /// After the configuration is complete, you can initialize the SDK by calling `initialize(publishingId:id:onComplete:)`.
  /// Once the SDK is initialized, it is recommended to use the static methods instead of accessing the shared instance directly to
  /// avoid unnecessary dependency injection.
  ///
  /// To configure the Tiki SDK, you can use the builder pattern and chain the methods to customize the SDK behavior as needed.
  /// Here's an example:
  ///
  /// ```
  /// TikiSdk.config()
  ///    .theme
  ///        .primaryTextColor(.black)
  ///        .primaryBackgroundColor(.white)
  ///        .accentColor(.green)
  ///        .and()
  ///    .dark
  ///        .primaryTextColor(.white)
  ///        .primaryBackgroundColor(.black)
  ///        .accentColor(.green)
  ///        .and()
  ///    .offer
  ///        .bullet(text: "Use for ads", isUsed: true)
  ///        .bullet(text: "Share with 3rd party", isUsed: false)
  ///        .bullet(text: "Sell to other companies", isUsed: true)
  ///        .ptr("offer1")
  ///        .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
  ///        .tag(TitleTag(TitleTagEnum.advertisingData))
  ///        .duration(365 * 24 * 60 * 60)
  ///        .permission(Permission.camera)
  ///        .terms("terms.md")
  ///        .add()
  ///    .onAccept { offer, license in ... }
  ///    .onDecline { offer, license in ... }
  ///    .disableAcceptEnding(false)
  ///    .disableDeclineEnding(true)
  ///    .initialize(publishingId: publishingId, id:id, onComplete: {...})
  /// ```
  ///
  /// - Returns: The shared instance of the Tiki SDK.
  static TikiSdk config() => instance;

  /// Creates a new `LicenseRecord` object.
  ///
  /// The method searches for a `TitleRecord` object that matches the provided `ptr` parameter. If such a record exists, the
  /// `tags` and `titleDescription` parameters are ignored. Otherwise, a new `TitleRecord` is created using the provided
  /// `tags` and `titleDescription` parameters.
  ///
  /// If the `origin` parameter is not provided, the default origin specified in initialization is used.
  /// The `expiry` parameter sets the expiration date of the `LicenseRecord`. If the license never expires, leave this parameter
  /// as `null`.
  ///
  /// - Parameters:
  ///   - ptr: The pointer record identifies data stored in your system, similar to a foreign key. Learn more about selecting good pointer
  ///   records at https://docs.mytiki.com/docs/selecting-a-pointer-record.
  ///   - uses: A list defining how and where an asset may be used, in the format of `LicenseUse` objects. Learn more about specifying
  ///   uses at https://docs.mytiki.com/docs/specifying-terms-and-usage.
  ///   - terms: The legal terms of the contract. This is a long text document that explains the terms of the license.
  ///   - tags: A list of metadata tags included in the `TitleRecord` describing the asset, for your use in record search and filtering.
  ///   This parameter is used only if a `TitleRecord` does not already exist for the provided `ptr`.
  ///   - titleDescription: A short, human-readable description of the `TitleRecord` as a future reminder. This parameter is used
  ///   only if a `TitleRecord` does not already exist for the provided `ptr`.
  ///   - licenseDescription: A short, human-readable description of the `LicenseRecord` as a future reminder.
  ///   - expiry: The expiration date of the `LicenseRecord`. If the license never expires, leave this parameter as `null`.
  ///   - origin: An optional override of the default origin specified in `init()`. Use a reverse-DNS syntax, e.g. `com.myco.myapp`.
  ///
  /// - Returns: The created `LicenseRecord` object.
  ///
  /// - Throws: `TikiSdkError` if the SDK is not initialized or if there is an error creating or saving the record.
  static Future<LicenseRecord> license(
      String ptr, List<LicenseUse> uses, String terms,
      {List<TitleTag>? tags = const [],
      String? titleDescription,
      String? licenseDescription,
      DateTime? expiry,
      String? origin}) {
    return instance._core!.license(
      ptr,
      uses,
      terms,
      titleDescription: titleDescription,
      licenseDescription: licenseDescription,
      expiry: expiry,
      origin: origin,
    );
  }

  /// Creates a new TitleRecord, or retrieves an existing one.
  ///
  /// Use this function to create a new TitleRecord for a given Pointer Record (ptr), or retrieve an existing one if it already exists.
  /// - Parameters:
  ///     - ptr: The Pointer Record that identifies the data stored in your system, similar to a foreign key. Learn more about selecting good pointer records at https://docs.mytiki.com/docs/selecting-a-pointer-record.
  ///     - origin: An optional override of the default origin specified in `initTikiSdkAsync`. Follow a reverse-DNS syntax,
  ///     i.e. com.myco.myapp.
  ///     - tags: A list of metadata tags included in the TitleRecord describing the asset, for your use in record search and filtering. Learn
  ///     more about adding tags at https://docs.mytiki.com/docs/adding-tags.
  ///     - description: A short, human-readable, description of the TitleRecord as a future reminder.
  /// - Returns: The created or retrieved TitleRecord.
  static Future<TitleRecord> title(String ptr,
      {List<TitleTag> tags = const [],
      String? description,
      String? origin}) async {
    return instance._core!
        .title(ptr, tags: tags, description: description, origin: origin);
  }

  /// Retrieves the TitleRecord with the specified ID, or `null` if the record is not found.
  ///
  /// Use this method to retrieve the metadata associated with an asset identified by its TitleRecord ID.
  /// - Parameters
  ///  - id: The ID of the TitleRecord to retrieve.
  static TitleRecord? getTitle(String id) {
    return instance._core!.getTitle(id);
  }

  /// Returns the LicenseRecord for a given ID or null if the license or corresponding title record is not found.
  ///
  /// This method retrieves the LicenseRecord object that matches the specified ID. If no record is found, it returns null. The `origin` parameter can be used to override the default origin specified in initialization.
  ///
  /// - Parameters
  ///     - id: The ID of the LicenseRecord to retrieve.
  ///     - origin: An optional override of the default origin specified in `initTikiSdkAsync`.
  /// - Returns: The LicenseRecord that matches the specified ID or null if the license or corresponding title record is not found.
  static LicenseRecord? getLicense(String id) {
    return instance._core!.getLicense(id);
  }

  /// Returns all LicenseRecords associated with a given Pointer Record.
  ///
  /// Use this method to retrieve all LicenseRecords that have been previously stored for a given Pointer Record in your system.
  ///
  /// - Parameters:
  ///    - ptr: The Pointer Record that identifies the data stored in your system, similar to a foreign key.
  ///    - origin: An optional origin. If null, the origin defaults to the package name.
  /// - Returns: An array of all LicenseRecords associated with the given Pointer Record. If no LicenseRecords are found,
  /// an empty array is returned.
  static List<LicenseRecord> all(String ptr, {String? origin}) {
    return instance._core!.all(ptr, origin: origin);
  }

  /// Returns the latest LicenseRecord for a ptr or null if the corresponding title or license records are not found.
  /// - Parameters:
  ///    - ptr: The Pointer Records identifies data stored in your system, similar to a foreign key.
  ///    - origin: An optional origin. If null, the origin defaults to the package name.
  ///
  /// - Returns: The latest LicenseRecord for the given ptr, or null if the corresponding title or license records are not found.
  static LicenseRecord? latest(String ptr, {String? origin}) {
    return instance._core!.latest(ptr, origin: origin);
  }

  Future<String> _dbDir() async {
    final dir = await getApplicationDocumentsDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }
}
