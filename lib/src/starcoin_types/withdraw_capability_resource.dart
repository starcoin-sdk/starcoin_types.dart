part of starcoin_types_types;

@immutable
class WithdrawCapabilityResource {
  const WithdrawCapabilityResource({
    required this.accountAddress,
  });

  WithdrawCapabilityResource.deserialize(BinaryDeserializer deserializer) :
    accountAddress = AccountAddress.deserialize(deserializer);

  static WithdrawCapabilityResource bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = WithdrawCapabilityResource.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final AccountAddress accountAddress;


  void serialize(BinarySerializer serializer) {
    accountAddress.serialize(serializer);
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

    return other is WithdrawCapabilityResource
    &&  accountAddress == other.accountAddress
    ;}

  @override
  int get hashCode => accountAddress.hashCode;

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'accountAddress: $accountAddress'
        ')';
      return true;
    }());

    return fullString ?? 'WithdrawCapabilityResource';
  }
}
