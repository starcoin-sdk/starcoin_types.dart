part of starcoin_types_types;

@immutable
class SignedUserTransaction {
  const SignedUserTransaction({
    required this.rawTxn,
    required this.authenticator,
  });

  SignedUserTransaction.deserialize(BinaryDeserializer deserializer) :
    rawTxn = RawUserTransaction.deserialize(deserializer),
    authenticator = TransactionAuthenticator.deserialize(deserializer);

  static SignedUserTransaction bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = SignedUserTransaction.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final RawUserTransaction rawTxn;
  final TransactionAuthenticator authenticator;


  void serialize(BinarySerializer serializer) {
    rawTxn.serialize(serializer);
    authenticator.serialize(serializer);
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

    return other is SignedUserTransaction
    &&  rawTxn == other.rawTxn
    &&  authenticator == other.authenticator
    ;}

  @override
  int get hashCode => Object.hash(
        rawTxn,
        authenticator,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'rawTxn: $rawTxn, '
        'authenticator: $authenticator'
        ')';
      return true;
    }());

    return fullString ?? 'SignedUserTransaction';
  }
}
