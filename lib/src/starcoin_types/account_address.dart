part of starcoin_types_types;

@immutable
class AccountAddress {
  const AccountAddress({
    required this.value,
  });

  AccountAddress.deserialize(BinaryDeserializer deserializer) :
    value = TraitHelpers.deserializeArray16U8Array(deserializer);

  static AccountAddress bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = AccountAddress.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final List<int> value;


  void serialize(BinarySerializer serializer) {
    TraitHelpers.serializeArray16U8Array(value, serializer);
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

    return other is AccountAddress
    &&  listEquals(value, other.value)
    ;}

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'value: $value'
        ')';
      return true;
    }());

    return fullString ?? 'AccountAddress';
  }
}
