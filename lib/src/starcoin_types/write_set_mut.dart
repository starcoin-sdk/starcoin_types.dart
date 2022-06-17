part of starcoin_types_types;

@immutable
class WriteSetMut {
  const WriteSetMut({
    required this.writeSet,
  });

  WriteSetMut.deserialize(BinaryDeserializer deserializer) :
    writeSet = TraitHelpers.deserializeVectorTuple2AccessPathWriteOp(deserializer);

  static WriteSetMut bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = WriteSetMut.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final List<Tuple2<AccessPath, WriteOp>> writeSet;


  void serialize(BinarySerializer serializer) {
    TraitHelpers.serializeVectorTuple2AccessPathWriteOp(writeSet, serializer);
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

    return other is WriteSetMut
    &&  listEquals(writeSet, other.writeSet)
    ;}

  @override
  int get hashCode => writeSet.hashCode;

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'writeSet: $writeSet'
        ')';
      return true;
    }());

    return fullString ?? 'WriteSetMut';
  }
}
