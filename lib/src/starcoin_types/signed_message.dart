part of starcoin_types_types;

@immutable
class SignedMessage {
  const SignedMessage({
    required this.account,
    required this.message,
    required this.authenticator,
    required this.chainId,
  });

  SignedMessage.deserialize(BinaryDeserializer deserializer) :
    account = AccountAddress.deserialize(deserializer),
    message = SigningMessage.deserialize(deserializer),
    authenticator = TransactionAuthenticator.deserialize(deserializer),
    chainId = ChainId.deserialize(deserializer);

  static SignedMessage bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = SignedMessage.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final AccountAddress account;
  final SigningMessage message;
  final TransactionAuthenticator authenticator;
  final ChainId chainId;


  void serialize(BinarySerializer serializer) {
    account.serialize(serializer);
    message.serialize(serializer);
    authenticator.serialize(serializer);
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

    return other is SignedMessage
    &&  account == other.account
    &&  message == other.message
    &&  authenticator == other.authenticator
    &&  chainId == other.chainId
    ;}

  @override
  int get hashCode => Object.hash(
        account,
        message,
        authenticator,
        chainId,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'account: $account, '
        'message: $message, '
        'authenticator: $authenticator, '
        'chainId: $chainId'
        ')';
      return true;
    }());

    return fullString ?? 'SignedMessage';
  }
}
