part of 'collections_bloc.dart';

@immutable
sealed class CollectionsEvent {}

class LoadCollections extends CollectionsEvent {
  final int firstIndex;
  final int lastIndex;

  LoadCollections(this.firstIndex, this.lastIndex);
}
