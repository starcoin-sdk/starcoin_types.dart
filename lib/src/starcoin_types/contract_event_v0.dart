part of starcoin_types_types;

@immutable
class ContractEventV0 {
  const ContractEventV0({
    required this.key,
    required this.sequenceNumber,
    required this.typeTag,
    required this.eventData,
  });

  ContractEventV0.deserialize(BinaryDeserializer deserializer) :
    key = EventKey.deserialize(deserializer),
    sequenceNumber = deserializer.deserializeUint64(),
    typeTag = TypeTag.deserialize(deserializer),
    eventData = deserializer.deserializeBytes();

  static ContractEventV0 bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = ContractEventV0.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final EventKey key;
  final Uint64 sequenceNumber;
  final TypeTag typeTag;
  final Bytes eventData;


  void serialize(BinarySerializer serializer) {
    key.serialize(serializer);
    serializer.serializeUint64(sequenceNumber);
    typeTag.serialize(serializer);
    serializer.serializeBytes(eventData);
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

    return other is ContractEventV0
    &&  key == other.key
    &&  sequenceNumber == other.sequenceNumber
    &&  typeTag == other.typeTag
    &&  eventData == other.eventData
    ;}

  @override
  int get hashCode => Object.hash(
        key,
        sequenceNumber,
        typeTag,
        eventData,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'key: $key, '
        'sequenceNumber: $sequenceNumber, '
        'typeTag: $typeTag, '
        'eventData: $eventData'
        ')';
      return true;
    }());

    return fullString ?? 'ContractEventV0';
  }
}
