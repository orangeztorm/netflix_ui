import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_ui/Widgets/widgets.dart';
import 'package:netflix_ui/cubits/app_bar/app_bar_cubit.dart';
import 'package:netflix_ui/data/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<AppBarCubit>().setOffset(_scrollController.offset);
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(ScreenSize.width, 50),
        child: BlocBuilder<AppBarCubit, double>(
            builder: (context, scrollOffset) => CustomAppBar(scrollOffset: scrollOffset),),
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
        onPressed: () => print('cast'),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                title: 'previews',
                contentList: previews,
                key: PageStorageKey('previews'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                title: 'My List',
                contentList: myList,
                key: PageStorageKey('My List')),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('Originals'),
                title: 'Netflix Originals',
                contentList: originals,
                isOriginals: true),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              key: PageStorageKey('Trending'),
              child: ContentList(title: 'Trending', contentList: trending),
            ),
          ),
        ],
      ),
    );
  }
}
