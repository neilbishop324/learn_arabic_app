class Question {
  String word;
  List<Option> options;
  Question({
    required this.word,
    required this.options,
  });
}

class Option {
  String firstLan;
  String secondLan;
  bool isTrue;
  Option({
    required this.firstLan,
    required this.secondLan,
    required this.isTrue,
  });
}
