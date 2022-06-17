part of starcoin_types_types;

@immutable
class AccountResource {
  const AccountResource({
    required this.authenticationKey,
    this.withdrawalCapability,
    this.keyRotationCapability,
    required this.withdrawEvents,
    required this.depositEvents,
    required this.acceptTokenEvents,
    required this.sequenceNumber,
  });

  AccountResource.deserialize(BinaryDeserializer deserializer) :
    authenticationKey = TraitHelpers.deserializeVectorU8(deserializer),
    withdrawalCapability = TraitHelpers.deserializeOptionWithdrawCapabilityResource(deserializer),
    keyRotationCapability = TraitHelpers.deserializeOptionKeyRotationCapabilityResource(deserializer),
    withdrawEvents = EventHandle.deserialize(deserializer),
    depositEvents = EventHandle.deserialize(deserializer),
    acceptTokenEvents = EventHandle.deserialize(deserializer),
    sequenceNumber = deserializer.deserializeUint64();

  static AccountResource bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = AccountResource.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final List<int> authenticationKey;
  final WithdrawCapabilityResource? withdrawalCapability;
  final KeyRotationCapabilityResource? keyRotationCapability;
  final EventHandle withdrawEvents;
  final EventHandle depositEvents;
  final EventHandle acceptTokenEvents;
  final Uint64 sequenceNumber;


  void serialize(BinarySerializer serializer) {
    TraitHelpers.serializeVectorU8(authenticationKey, serializer);
    TraitHelpers.serializeOptionWithdrawCapabilityResource(withdrawalCapability, serializer);
    TraitHelpers.serializeOptionKeyRotationCapabilityResource(keyRotationCapability, serializer);
    withdrawEvents.serialize(serializer);
    depositEvents.serialize(serializer);
    acceptTokenEvents.serialize(serializer);
    serializer.serializeUint64(sequenceNumber);
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

    return other is AccountResource
    &&  listEquals(authenticationKey, other.authenticationKey)
    &&  withdrawalCapability == other.withdrawalCapability
    &&  keyRotationCapability == other.keyRotationCapability
    &&  withdrawEvents == other.withdrawEvents
    &&  depositEvents == other.depositEvents
    &&  acceptTokenEvents == other.acceptTokenEvents
    &&  sequenceNumber == other.sequenceNumber
    ;}

  @override
  int get hashCode => Object.hash(
        authenticationKey,
        withdrawalCapability,
        keyRotationCapability,
        withdrawEvents,
        depositEvents,
        acceptTokenEvents,
        sequenceNumber,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'authenticationKey: $authenticationKey, '
        'withdrawalCapability: $withdrawalCapability, '
        'keyRotationCapability: $keyRotationCapability, '
        'withdrawEvents: $withdrawEvents, '
        'depositEvents: $depositEvents, '
        'acceptTokenEvents: $acceptTokenEvents, '
        'sequenceNumber: $sequenceNumber'
        ')';
      return true;
    }());

    return fullString ?? 'AccountResource';
  }
}
