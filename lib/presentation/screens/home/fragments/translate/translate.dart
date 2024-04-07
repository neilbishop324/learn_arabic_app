import 'package:flutter/material.dart';
import 'package:learn_arabic_app/utils/ui.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:translator/translator.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final List<String> languages = ["Arabic", "English", "Turkish"];

  int firstLanguage = 0;
  int secondLanguage = 1;
  int thirdLanguage = 2;

  TextEditingController firstController = TextEditingController();

  String secondText = "";
  String thirdText = "";

  void changeFirstLanguage(int newIndex) {
    firstController.text = "";
    setState(() {
      secondText = "";
      thirdText = "";
      if (newIndex == secondLanguage) {
        secondLanguage = firstLanguage;
      } else if (newIndex == thirdLanguage) {
        thirdLanguage = firstLanguage;
      }
      firstLanguage = newIndex;
    });
  }

  void changeSecondLanguage(int newIndex) {
    firstController.text = "";
    setState(() {
      secondText = "";
      thirdText = "";
      if (newIndex == firstLanguage) {
        firstLanguage = secondLanguage;
      } else if (newIndex == thirdLanguage) {
        thirdLanguage = secondLanguage;
      }
      secondLanguage = newIndex;
    });
  }

  void changeThirdLanguage(int newIndex) {
    firstController.text = "";
    setState(() {
      secondText = "";
      thirdText = "";
      if (newIndex == firstLanguage) {
        firstLanguage = thirdLanguage;
      } else if (newIndex == secondLanguage) {
        secondLanguage = thirdLanguage;
      }
      thirdLanguage = newIndex;
    });
  }

  Future<int?> _showPopupMenu(GlobalKey key) async {
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;
    return await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + 50,
        screenSize.width - position.dx,
        screenSize.height - position.dy,
      ),
      items: languages.map((e) {
        return PopupMenuItem(
          value: languages.indexOf(e),
          child: Text(e),
        );
      }).toList(),
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[];
      },
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: ListView(
          children: [
            20.height,
            firstLanguageCard(context),
            10.height,
            secondLanguageCard(context),
            10.height,
            thirdLanguageCard(context),
            10.height,
          ],
        ),
      ),
    );
  }

  GlobalKey thirdLanguageKey = GlobalKey();

  SizedBox thirdLanguageCard(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                onTap: () async {
                  int? newLanguage = await _showPopupMenu(thirdLanguageKey);
                  if (newLanguage != null) {
                    changeThirdLanguage(newLanguage);
                  }
                },
                child: Container(
                  key: thirdLanguageKey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        languages[thirdLanguage],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      4.width,
                      const Icon(
                        Icons.arrow_drop_down_sharp,
                      )
                    ],
                  ).paddingAll(8),
                ),
              ),
              Text(
                (thirdText.isNotEmpty)
                    ? thirdText
                    : "Translation in ${languages[thirdLanguage]}",
                style: TextStyle(
                    fontSize: 20,
                    color: (thirdText.isEmpty) ? Colors.grey : null),
              ).paddingAll(10),
            ],
          ),
        ),
      ),
    );
  }

  GlobalKey secondLanguageKey = GlobalKey();

  SizedBox secondLanguageCard(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                onTap: () async {
                  int? newLanguage = await _showPopupMenu(secondLanguageKey);
                  if (newLanguage != null) {
                    changeSecondLanguage(newLanguage);
                  }
                },
                child: Container(
                  key: secondLanguageKey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        languages[secondLanguage],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      4.width,
                      const Icon(
                        Icons.arrow_drop_down_sharp,
                      )
                    ],
                  ).paddingAll(8),
                ),
              ),
              Text(
                (secondText.isNotEmpty)
                    ? secondText
                    : "Translation in ${languages[secondLanguage]}",
                style: TextStyle(
                    fontSize: 20,
                    color: (secondText.isEmpty) ? Colors.grey : null),
              ).paddingAll(10),
            ],
          ),
        ),
      ),
    );
  }

  GlobalKey firstLanguageKey = GlobalKey();

  Widget firstLanguageCard(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      child: Card(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Container(
          margin: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                onTap: () async {
                  int? newLanguage = await _showPopupMenu(firstLanguageKey);
                  if (newLanguage != null) {
                    changeFirstLanguage(newLanguage);
                  }
                },
                child: Container(
                  key: firstLanguageKey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        languages[firstLanguage],
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                          fontSize: 20,
                        ),
                      ),
                      4.width,
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                      )
                    ],
                  ).paddingAll(8),
                ),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: firstController,
                onChanged: (value) async {
                  await translate(value);
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText:
                      "If you want to write in Arabic, change the keyboard language",
                  hintMaxLines: 3,
                ),
              ).paddingOnly(left: 10, right: 10, bottom: 12),
            ],
          ),
        ),
      ),
    );
  }

  Future translate(String value) async {
    if (value.trim().isEmpty) {
      setState(() {
        secondText = "";
        thirdText = "";
      });
      return;
    }

    String firstLan = (firstLanguage == 0)
        ? "ar"
        : (firstLanguage == 1)
            ? "en"
            : "tr";
    String secondLan = (secondLanguage == 0)
        ? "ar"
        : (secondLanguage == 1)
            ? "en"
            : "tr";
    String thirdLan = (thirdLanguage == 0)
        ? "ar"
        : (thirdLanguage == 1)
            ? "en"
            : "tr";

    Translation secondData =
        await value.translate(from: firstLan, to: secondLan);
    Translation thirdData = await value.translate(from: firstLan, to: thirdLan);

    setState(() {
      secondText = secondData.text;
      thirdText = thirdData.text;
    });
  }
}
