part of starcoin_types_types;
class TraitHelpers {
  static void serializeArray16U8Array(List<int> value, BinarySerializer serializer) {
    assert (value.length == 16);
    for (final item in value) {
        serializer.serializeUint8(item);
    }
  }

  static List<int> deserializeArray16U8Array(BinaryDeserializer deserializer) {
    final obj = List<int>.filled(16, 0);
    for (var i = 0; i < 16; i++) {
        obj[i] = deserializer.deserializeUint8();
    }
    return obj;
  }

  static void serializeOptionAuthenticationKey(AuthenticationKey? value, BinarySerializer serializer) {
    if (value == null) {
        serializer.serializeOptionTag(false);
    } else {
        serializer.serializeOptionTag(true);
        value.serialize(serializer);
    }
  }

  static AuthenticationKey? deserializeOptionAuthenticationKey(BinaryDeserializer deserializer) {
    final tag = deserializer.deserializeOptionTag();
    if (tag) {
        return AuthenticationKey.deserialize(deserializer);
    } else {
        return null;
    }
  }

  static void serializeOptionKeyRotationCapabilityResource(KeyRotationCapabilityResource? value, BinarySerializer serializer) {
    if (value == null) {
        serializer.serializeOptionTag(false);
    } else {
        serializer.serializeOptionTag(true);
        value.serialize(serializer);
    }
  }

  static KeyRotationCapabilityResource? deserializeOptionKeyRotationCapabilityResource(BinaryDeserializer deserializer) {
    final tag = deserializer.deserializeOptionTag();
    if (tag) {
        return KeyRotationCapabilityResource.deserialize(deserializer);
    } else {
        return null;
    }
  }

  static void serializeOptionScriptFunction(ScriptFunction? value, BinarySerializer serializer) {
    if (value == null) {
        serializer.serializeOptionTag(false);
    } else {
        serializer.serializeOptionTag(true);
        value.serialize(serializer);
    }
  }

  static ScriptFunction? deserializeOptionScriptFunction(BinaryDeserializer deserializer) {
    final tag = deserializer.deserializeOptionTag();
    if (tag) {
        return ScriptFunction.deserialize(deserializer);
    } else {
        return null;
    }
  }

  static void serializeOptionWithdrawCapabilityResource(WithdrawCapabilityResource? value, BinarySerializer serializer) {
    if (value == null) {
        serializer.serializeOptionTag(false);
    } else {
        serializer.serializeOptionTag(true);
        value.serialize(serializer);
    }
  }

  static WithdrawCapabilityResource? deserializeOptionWithdrawCapabilityResource(BinaryDeserializer deserializer) {
    final tag = deserializer.deserializeOptionTag();
    if (tag) {
        return WithdrawCapabilityResource.deserialize(deserializer);
    } else {
        return null;
    }
  }

  static void serializeTuple2AccessPathWriteOp(Tuple2<AccessPath, WriteOp> value, BinarySerializer serializer) {
    value.item1.serialize(serializer);
    value.item2.serialize(serializer);
  }

  static Tuple2<AccessPath, WriteOp> deserializeTuple2AccessPathWriteOp(BinaryDeserializer deserializer) {
    return Tuple2<AccessPath, WriteOp>(
        AccessPath.deserialize(deserializer),
        WriteOp.deserialize(deserializer)
    );
  }

  static void serializeVectorArgumentAbi(List<ArgumentABI> value, BinarySerializer serializer) {
    serializer.serializeLength(value.length);
    for (final item in value) {
        item.serialize(serializer);
    }
  }

  static List<ArgumentABI> deserializeVectorArgumentAbi(BinaryDeserializer deserializer) {
    final length = deserializer.deserializeLength();
    return List.generate(length, (_i) => ArgumentABI.deserialize(deserializer));
  }

  static void serializeVectorModule(List<Module> value, BinarySerializer serializer) {
    serializer.serializeLength(value.length);
    for (final item in value) {
        item.serialize(serializer);
    }
  }

  static List<Module> deserializeVectorModule(BinaryDeserializer deserializer) {
    final length = deserializer.deserializeLength();
    return List.generate(length, (_i) => Module.deserialize(deserializer));
  }

  static void serializeVectorTypeArgumentAbi(List<TypeArgumentABI> value, BinarySerializer serializer) {
    serializer.serializeLength(value.length);
    for (final item in value) {
        item.serialize(serializer);
    }
  }

  static List<TypeArgumentABI> deserializeVectorTypeArgumentAbi(BinaryDeserializer deserializer) {
    final length = deserializer.deserializeLength();
    return List.generate(length, (_i) => TypeArgumentABI.deserialize(deserializer));
  }

  static void serializeVectorTypeTag(List<TypeTag> value, BinarySerializer serializer) {
    serializer.serializeLength(value.length);
    for (final item in value) {
        item.serialize(serializer);
    }
  }

  static List<TypeTag> deserializeVectorTypeTag(BinaryDeserializer deserializer) {
    final length = deserializer.deserializeLength();
    return List.generate(length, (_i) => TypeTag.deserialize(deserializer));
  }

  static void serializeVectorBytes(List<Bytes> value, BinarySerializer serializer) {
    serializer.serializeLength(value.length);
    for (final item in value) {
        serializer.serializeBytes(item);
    }
  }

  static List<Bytes> deserializeVectorBytes(BinaryDeserializer deserializer) {
    final length = deserializer.deserializeLength();
    return List.generate(length, (_i) => deserializer.deserializeBytes());
  }

  static void serializeVectorTuple2AccessPathWriteOp(List<Tuple2<AccessPath, WriteOp>> value, BinarySerializer serializer) {
    serializer.serializeLength(value.length);
    for (final item in value) {
        TraitHelpers.serializeTuple2AccessPathWriteOp(item, serializer);
    }
  }

  static List<Tuple2<AccessPath, WriteOp>> deserializeVectorTuple2AccessPathWriteOp(BinaryDeserializer deserializer) {
    final length = deserializer.deserializeLength();
    return List.generate(length, (_i) => TraitHelpers.deserializeTuple2AccessPathWriteOp(deserializer));
  }

  static void serializeVectorU8(List<int> value, BinarySerializer serializer) {
    serializer.serializeLength(value.length);
    for (final item in value) {
        serializer.serializeUint8(item);
    }
  }

  static List<int> deserializeVectorU8(BinaryDeserializer deserializer) {
    final length = deserializer.deserializeLength();
    return List.generate(length, (_i) => deserializer.deserializeUint8());
  }

}

