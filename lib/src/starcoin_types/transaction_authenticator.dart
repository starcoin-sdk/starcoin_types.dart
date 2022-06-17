part of starcoin_types_types;

abstract class TransactionAuthenticator {
  const TransactionAuthenticator();

  void serialize(BinarySerializer serializer);

  static TransactionAuthenticator deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserializeVariantIndex();
    switch (index) {
      case 0: return TransactionAuthenticatorEd25519Item.load(deserializer);
      case 1: return TransactionAuthenticatorMultiEd25519Item.load(deserializer);
      default: throw Exception("Unknown variant index for TransactionAuthenticator: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  static TransactionAuthenticator bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = TransactionAuthenticator.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }
}


@immutable
class TransactionAuthenticatorEd25519Item extends TransactionAuthenticator {
  const TransactionAuthenticatorEd25519Item({
    required this.publicKey,
    required this.signature,
  }) : super();

  TransactionAuthenticatorEd25519Item.load(BinaryDeserializer deserializer) :
    publicKey = Ed25519PublicKey.deserialize(deserializer),
    signature = Ed25519Signature.deserialize(deserializer);

  final Ed25519PublicKey publicKey;
  final Ed25519Signature signature;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(0);
    publicKey.serialize(serializer);
    signature.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionAuthenticatorEd25519Item
    &&  publicKey == other.publicKey
    &&  signature == other.signature
    ;}

  @override
  int get hashCode => Object.hash(
        publicKey,
        signature,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'publicKey: $publicKey, '
        'signature: $signature'
        ')';
      return true;
    }());

    return fullString ?? 'TransactionAuthenticatorEd25519Item';
  }
}

@immutable
class TransactionAuthenticatorMultiEd25519Item extends TransactionAuthenticator {
  const TransactionAuthenticatorMultiEd25519Item({
    required this.publicKey,
    required this.signature,
  }) : super();

  TransactionAuthenticatorMultiEd25519Item.load(BinaryDeserializer deserializer) :
    publicKey = MultiEd25519PublicKey.deserialize(deserializer),
    signature = MultiEd25519Signature.deserialize(deserializer);

  final MultiEd25519PublicKey publicKey;
  final MultiEd25519Signature signature;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(1);
    publicKey.serialize(serializer);
    signature.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionAuthenticatorMultiEd25519Item
    &&  publicKey == other.publicKey
    &&  signature == other.signature
    ;}

  @override
  int get hashCode => Object.hash(
        publicKey,
        signature,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'publicKey: $publicKey, '
        'signature: $signature'
        ')';
      return true;
    }());

    return fullString ?? 'TransactionAuthenticatorMultiEd25519Item';
  }
}
