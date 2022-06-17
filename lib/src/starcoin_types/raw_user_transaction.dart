part of starcoin_types_types;

@immutable
class RawUserTransaction {
  const RawUserTransaction({
    required this.sender,
    required this.sequenceNumber,
    required this.payload,
    required this.maxGasAmount,
    required this.gasUnitPrice,
    required this.gasTokenCode,
    required this.expirationTimestampSecs,
    required this.chainId,
  });

  RawUserTransaction.deserialize(BinaryDeserializer deserializer) :
    sender = AccountAddress.deserialize(deserializer),
    sequenceNumber = deserializer.deserializeUint64(),
    payload = TransactionPayload.deserialize(deserializer),
    maxGasAmount = deserializer.deserializeUint64(),
    gasUnitPrice = deserializer.deserializeUint64(),
    gasTokenCode = deserializer.deserializeString(),
    expirationTimestampSecs = deserializer.deserializeUint64(),
    chainId = ChainId.deserialize(deserializer);

  static RawUserTransaction bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = RawUserTransaction.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final AccountAddress sender;
  final Uint64 sequenceNumber;
  final TransactionPayload payload;
  final Uint64 maxGasAmount;
  final Uint64 gasUnitPrice;
  final String gasTokenCode;
  final Uint64 expirationTimestampSecs;
  final ChainId chainId;


  void serialize(BinarySerializer serializer) {
    sender.serialize(serializer);
    serializer.serializeUint64(sequenceNumber);
    payload.serialize(serializer);
    serializer.serializeUint64(maxGasAmount);
    serializer.serializeUint64(gasUnitPrice);
    serializer.serializeString(gasTokenCode);
    serializer.serializeUint64(expirationTimestampSecs);
    chainId.serialize(serializer);
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

    return other is RawUserTransaction
    &&  sender == other.sender
    &&  sequenceNumber == other.sequenceNumber
    &&  payload == other.payload
    &&  maxGasAmount == other.maxGasAmount
    &&  gasUnitPrice == other.gasUnitPrice
    &&  gasTokenCode == other.gasTokenCode
    &&  expirationTimestampSecs == other.expirationTimestampSecs
    &&  chainId == other.chainId
    ;}

  @override
  int get hashCode => Object.hash(
        sender,
        sequenceNumber,
        payload,
        maxGasAmount,
        gasUnitPrice,
        gasTokenCode,
        expirationTimestampSecs,
        chainId,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'sender: $sender, '
        'sequenceNumber: $sequenceNumber, '
        'payload: $payload, '
        'maxGasAmount: $maxGasAmount, '
        'gasUnitPrice: $gasUnitPrice, '
        'gasTokenCode: $gasTokenCode, '
        'expirationTimestampSecs: $expirationTimestampSecs, '
        'chainId: $chainId'
        ')';
      return true;
    }());

    return fullString ?? 'RawUserTransaction';
  }
}
