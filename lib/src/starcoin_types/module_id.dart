part of starcoin_types_types;

@immutable
class ModuleId {
  const ModuleId({
    required this.address,
    required this.name,
  });

  ModuleId.deserialize(BinaryDeserializer deserializer) :
    address = AccountAddress.deserialize(deserializer),
    name = Identifier.deserialize(deserializer);

  static ModuleId bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = ModuleId.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final AccountAddress address;
  final Identifier name;


  void serialize(BinarySerializer serializer) {
    address.serialize(serializer);
    name.serialize(serializer);
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

    return other is ModuleId
    &&  address == other.address
    &&  name == other.name
    ;}

  @override
  int get hashCode => Object.hash(
        address,
        name,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'address: $address, '
        'name: $name'
        ')';
      return true;
    }());

    return fullString ?? 'ModuleId';
  }
}
