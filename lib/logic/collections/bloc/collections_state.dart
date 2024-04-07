part of 'collections_bloc.dart';

@immutable
sealed class CollectionsState {}

class CollectionsInitial extends CollectionsState {}

class CollectionsLoading extends CollectionsState {}

class CollectionsLoaded extends CollectionsState {
  final List<Collection> data;

  CollectionsLoaded(this.data);
}

class CollectionsError extends CollectionsState {
  final String error;

  CollectionsError(this.error);
}
