part of starcoin_types_types;

abstract class TypeTag {
  const TypeTag();

  void serialize(BinarySerializer serializer);

  static TypeTag deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserializeVariantIndex();
    switch (index) {
      case 0: return TypeTagboolItem.load(deserializer);
      case 1: return TypeTagu8Item.load(deserializer);
      case 2: return TypeTagu64Item.load(deserializer);
      case 3: return TypeTagu128Item.load(deserializer);
      case 4: return TypeTagaddressItem.load(deserializer);
      case 5: return TypeTagsignerItem.load(deserializer);
      case 6: return TypeTagvectorItem.load(deserializer);
      case 7: return TypeTagstructItem.load(deserializer);
      default: throw Exception("Unknown variant index for TypeTag: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  static TypeTag bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = TypeTag.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }
}


@immutable
class TypeTagboolItem extends TypeTag {
  const TypeTagboolItem(
  ) : super();

  TypeTagboolItem.load(BinaryDeserializer deserializer);

  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(0);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TypeTagboolItem
    ;}

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        ')';
      return true;
    }());

    return fullString ?? 'TypeTagboolItem';
  }
}

@immutable
class TypeTagu8Item extends TypeTag {
  const TypeTagu8Item(
  ) : super();

  TypeTagu8Item.load(BinaryDeserializer deserializer);

  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(1);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TypeTagu8Item
    ;}

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        ')';
      return true;
    }());

    return fullString ?? 'TypeTagu8Item';
  }
}

@immutable
class TypeTagu64Item extends TypeTag {
  const TypeTagu64Item(
  ) : super();

  TypeTagu64Item.load(BinaryDeserializer deserializer);

  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(2);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TypeTagu64Item
    ;}

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        ')';
      return true;
    }());

    return fullString ?? 'TypeTagu64Item';
  }
}

@immutable
class TypeTagu128Item extends TypeTag {
  const TypeTagu128Item(
  ) : super();

  TypeTagu128Item.load(BinaryDeserializer deserializer);

  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(3);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TypeTagu128Item
    ;}

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        ')';
      return true;
    }());

    return fullString ?? 'TypeTagu128Item';
  }
}

@immutable
class TypeTagaddressItem extends TypeTag {
  const TypeTagaddressItem(
  ) : super();

  TypeTagaddressItem.load(BinaryDeserializer deserializer);

  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(4);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TypeTagaddressItem
    ;}

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        ')';
      return true;
    }());

    return fullString ?? 'TypeTagaddressItem';
  }
}

@immutable
class TypeTagsignerItem extends TypeTag {
  const TypeTagsignerItem(
  ) : super();

  TypeTagsignerItem.load(BinaryDeserializer deserializer);

  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(5);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TypeTagsignerItem
    ;}

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        ')';
      return true;
    }());

    return fullString ?? 'TypeTagsignerItem';
  }
}

@immutable
class TypeTagvectorItem extends TypeTag {
  const TypeTagvectorItem({
    required this.value,
  }) : super();

  TypeTagvectorItem.load(BinaryDeserializer deserializer) :
    value = TypeTag.deserialize(deserializer);

  final TypeTag value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(6);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TypeTagvectorItem
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

    return fullString ?? 'TypeTagvectorItem';
  }
}

@immutable
class TypeTagstructItem extends TypeTag {
  const TypeTagstructItem({
    required this.value,
  }) : super();

  TypeTagstructItem.load(BinaryDeserializer deserializer) :
    value = StructTag.deserialize(deserializer);

  final StructTag value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(7);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TypeTagstructItem
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

    return fullString ?? 'TypeTagstructItem';
  }
}
