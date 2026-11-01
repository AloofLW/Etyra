enum VerificationStatus { verified, unverified, disputed }

enum AffixKind { prefix, suffix, other, unknown }

enum ComponentType { root, affix }

enum ComponentRole { root, prefix, suffix, other, unknown }

enum ContentType { root, word }

/// Return null when no safe meaning exists, rather than treating future content
/// types or command values as an existing type. Callers return Unsupported.
T? knownEnum<T extends Enum>(Iterable<T> values, String raw) {
  for (final value in values) {
    if (value.name == raw) return value;
  }
  return null;
}
