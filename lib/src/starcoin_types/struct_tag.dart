part of starcoin_types_types;

@immutable
class StructTag {
  const StructTag({
    required this.address,
    required this.module,
    required this.name,
    required this.typeArgs,
  });

  StructTag.deserialize(BinaryDeserializer deserializer) :
    address = AccountAddress.deserialize(deserializer),
    module = Identifier.deserialize(deserializer),
    name = Identifier.deserialize(deserializer),
    typeArgs = TraitHelpers.deserializeVectorTypeTag(deserializer);

  static StructTag bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = StructTag.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final AccountAddress address;
  final Identifier module;
  final Identifier name;
  final List<TypeTag> typeArgs;


  void serialize(BinarySerializer serializer) {
    address.serialize(serializer);
    module.serialize(serializer);
    name.serialize(serializer);
    TraitHelpers.serializeVectorTypeTag(typeArgs, serializer);
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

    return other is StructTag
    &&  address == other.address
    &&  module == other.module
    &&  name == other.name
    &&  listEquals(typeArgs, other.typeArgs)
    ;}

  @override
  int get hashCode => Object.hash(
        address,
        module,
        name,
        typeArgs,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'address: $address, '
        'module: $module, '
        'name: $name, '
        'typeArgs: $typeArgs'
        ')';
      return true;
    }());

    return fullString ?? 'StructTag';
  }
}
