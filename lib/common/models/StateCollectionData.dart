class StateCollectionData<T> {
  final bool isProcessing;
  final List<T> items;
  StateCollectionData({required this.items, this.isProcessing = false});
}

class FilterableStateCollectionData<T, Q> extends StateCollectionData<T> {
  final Q? query;
  FilterableStateCollectionData({required super.items, this.query, super.isProcessing = false});
}