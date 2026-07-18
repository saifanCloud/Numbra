extension NumberExtension on num {
  bool get isInteger => this % 1 == 0;
  
  String toFormattedString() {
    if (isInteger) {
      return toStringAsFixed(0);
    }
    return toString();
  }
}