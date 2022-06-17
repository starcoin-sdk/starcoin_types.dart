part of starcoin_types_types;

@immutable
class AccessPath {
  const AccessPath({
    required this.field0,
    required this.field1,
  });

  AccessPath.deserialize(BinaryDeserializer deserializer) :
    field0 = AccountAddress.deserialize(deserializer),
    field1 = DataPath.deserialize(deserializer);

  static AccessPath bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = AccessPath.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final AccountAddress field0;
  final DataPath field1;


  void serialize(BinarySerializer serializer) {
    field0.serialize(serializer);
    field1.serialize(serializer);
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

    return other is AccessPath
    &&  field0 == other.field0
    &&  field1 == other.field1
    ;}

  @override
  int get hashCode => Object.hash(
        field0,
        field1,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'field0: $field0, '
        'field1: $field1'
        ')';
      return true;
    }());

    return fullString ?? 'AccessPath';
  }
}
