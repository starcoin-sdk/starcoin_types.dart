part of starcoin_types_types;

@immutable
class Package {
  const Package({
    required this.packageAddress,
    required this.modules,
    this.initScript,
  });

  Package.deserialize(BinaryDeserializer deserializer) :
    packageAddress = AccountAddress.deserialize(deserializer),
    modules = TraitHelpers.deserializeVectorModule(deserializer),
    initScript = TraitHelpers.deserializeOptionScriptFunction(deserializer);

  static Package bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = Package.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final AccountAddress packageAddress;
  final List<Module> modules;
  final ScriptFunction? initScript;


  void serialize(BinarySerializer serializer) {
    packageAddress.serialize(serializer);
    TraitHelpers.serializeVectorModule(modules, serializer);
    TraitHelpers.serializeOptionScriptFunction(initScript, serializer);
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is Package
    &&  packageAddress == other.packageAddress
    &&  listEquals(modules, other.modules)
    &&  initScript == other.initScript
    ;}

  @override
  int get hashCode => Object.hash(
        packageAddress,
        modules,
        initScript,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'packageAddress: $packageAddress, '
        'modules: $modules, '
        'initScript: $initScript'
        ')';
      return true;
    }());

    return fullString ?? 'Package';
  }
}
