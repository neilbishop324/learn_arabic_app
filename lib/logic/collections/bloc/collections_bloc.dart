import 'package:bloc/bloc.dart';
import 'package:learn_arabic_app/data/model/collection.dart';
import 'package:learn_arabic_app/data/repository/collection_repo.dart';
import 'package:meta/meta.dart';

part 'collections_event.dart';
part 'collections_state.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final CollectionRepo collectionRepo;

  CollectionsBloc(this.collectionRepo) : super(CollectionsInitial()) {
    on<LoadCollections>((event, emit) async {
      List<Collection>? list;
      emit(CollectionsLoading());

      list = await collectionRepo.fetchCollections(
          firstIndex: event.firstIndex, lastIndex: event.lastIndex);

      if (list == null) {
        emit(CollectionsError("Collections were not found!"));
      } else {
        emit(CollectionsLoaded(list));
      }
    });
  }
}
