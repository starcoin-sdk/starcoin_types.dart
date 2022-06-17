part of starcoin_types_types;

@immutable
class BlockMetadata {
  const BlockMetadata({
    required this.parentHash,
    required this.timestamp,
    required this.author,
    this.authorAuthKey,
    required this.uncles,
    required this.number,
    required this.chainId,
    required this.parentGasUsed,
  });

  BlockMetadata.deserialize(BinaryDeserializer deserializer) :
    parentHash = HashValue.deserialize(deserializer),
    timestamp = deserializer.deserializeUint64(),
    author = AccountAddress.deserialize(deserializer),
    authorAuthKey = TraitHelpers.deserializeOptionAuthenticationKey(deserializer),
    uncles = deserializer.deserializeUint64(),
    number = deserializer.deserializeUint64(),
    chainId = ChainId.deserialize(deserializer),
    parentGasUsed = deserializer.deserializeUint64();

  static BlockMetadata bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = BlockMetadata.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final HashValue parentHash;
  final Uint64 timestamp;
  final AccountAddress author;
  final AuthenticationKey? authorAuthKey;
  final Uint64 uncles;
  final Uint64 number;
  final ChainId chainId;
  final Uint64 parentGasUsed;


  void serialize(BinarySerializer serializer) {
    parentHash.serialize(serializer);
    serializer.serializeUint64(timestamp);
    author.serialize(serializer);
    TraitHelpers.serializeOptionAuthenticationKey(authorAuthKey, serializer);
    serializer.serializeUint64(uncles);
    serializer.serializeUint64(number);
    chainId.serialize(serializer);
    serializer.serializeUint64(parentGasUsed);
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

    return other is BlockMetadata
    &&  parentHash == other.parentHash
    &&  timestamp == other.timestamp
    &&  author == other.author
    &&  authorAuthKey == other.authorAuthKey
    &&  uncles == other.uncles
    &&  number == other.number
    &&  chainId == other.chainId
    &&  parentGasUsed == other.parentGasUsed
    ;}

  @override
  int get hashCode => Object.hash(
        parentHash,
        timestamp,
        author,
        authorAuthKey,
        uncles,
        number,
        chainId,
        parentGasUsed,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'parentHash: $parentHash, '
        'timestamp: $timestamp, '
        'author: $author, '
        'authorAuthKey: $authorAuthKey, '
        'uncles: $uncles, '
        'number: $number, '
        'chainId: $chainId, '
        'parentGasUsed: $parentGasUsed'
        ')';
      return true;
    }());

    return fullString ?? 'BlockMetadata';
  }
}
