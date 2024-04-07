import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_arabic_app/data/model/collection.dart';
import 'package:learn_arabic_app/logic/collections/bloc/collections_bloc.dart';
import 'package:learn_arabic_app/presentation/screens/error/components/error_component.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'components/collection_card.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({super.key});

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  int firstIndex = 0;
  int lastIndex = 39;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CollectionsBloc>(context)
        .add(LoadCollections(firstIndex, lastIndex));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollectionsBloc, CollectionsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return content(context, state);
      },
    );
  }

  Widget content(BuildContext context, CollectionsState state) {
    if (state is CollectionsLoaded) {
      return buildLoadedlayout(state.data);
    } else if (state is CollectionsLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CollectionsError) {
      return ErrorComponent(errorContent: state.error);
    } else {
      return const SizedBox();
    }
  }

  Widget buildLoadedlayout(List<Collection> data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StaggeredGrid.count(
            crossAxisCount: 2,
            children: data.map((collection) {
              return CollectionCard(collection);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
