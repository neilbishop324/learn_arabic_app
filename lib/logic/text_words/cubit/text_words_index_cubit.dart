import 'package:bloc/bloc.dart';

part 'text_words_index_state.dart';

class TextWordsIndexCubit extends Cubit<TextWordsIndexState> {
  TextWordsIndexCubit() : super(TextWordsIndexState(firstIndex: 0));

  void setFirstIndex(int index) => emit(TextWordsIndexState(firstIndex: index));
}
