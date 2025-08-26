class StateCollectionData<T> {
  final bool isProcessing;
  final List<T> items;
  StateCollectionData({required this.items, this.isProcessing = false});
}