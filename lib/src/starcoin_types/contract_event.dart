part of starcoin_types_types;

abstract class ContractEvent {
  const ContractEvent();

  void serialize(BinarySerializer serializer);

  static ContractEvent deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserializeVariantIndex();
    switch (index) {
      case 0: return ContractEventV0Item.load(deserializer);
      default: throw Exception("Unknown variant index for ContractEvent: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  static ContractEvent bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = ContractEvent.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }
}


@immutable
class ContractEventV0Item extends ContractEvent {
  const ContractEventV0Item({
    required this.value,
  }) : super();

  ContractEventV0Item.load(BinaryDeserializer deserializer) :
    value = ContractEventV0.deserialize(deserializer);

  final ContractEventV0 value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(0);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is ContractEventV0Item
    &&  value == other.value
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

    return fullString ?? 'ContractEventV0Item';
  }
}
