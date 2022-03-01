import 'package:blogclub/article.dart';
import 'package:blogclub/carousel/carousel_slider.dart';
import 'package:blogclub/data.dart';
import 'package:blogclub/gen/assets.gen.dart';
import 'package:blogclub/gen/fonts.gen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final stories = AppDatabase.stories;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xffF4F7FF),
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 25, 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi, Jonathan!',
                        style: themeData.textTheme.subtitle1,
                      ),
                      Assets.img.icons.notification.image(
                        width: 32,
                        height: 32,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                  child: Text(
                    'Explore today’s',
                    style: themeData.textTheme.headline5,
                  ),
                ),
                _StoryList(stories: stories, themeData: themeData),
                _CategoryList(themeData: themeData),
                _PostList(themeData: themeData),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final ThemeData themeData;

  const _CategoryList({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = AppDatabase.categories;

    return CarouselSlider.builder(
        itemCount: categories.length,
        itemBuilder: (context, index, realIndex) {
          return _CategoryItem(
            left: realIndex == 0 ? 40 : 8,
            right: realIndex == categories.length - 1 ? 40 : 8,
            category: categories[realIndex],
            themeData: themeData,
            realIndex: realIndex,
          );
        },
        options: CarouselOptions(
          aspectRatio: 1.35,
          viewportFraction: 0.8,
          initialPage: 0,
          scrollDirection: Axis.horizontal,
          disableCenter: true,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          scrollPhysics: const BouncingScrollPhysics(),
        ));
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    Key? key,
    required this.category,
    required this.themeData,
    required this.left,
    required this.right,
    required this.realIndex,
  }) : super(key: key);

  final Category category;
  final ThemeData themeData;
  final double left;
  final double right;
  final int realIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 100,
          left: realIndex == 0 ? 90 : 50,
          right: 50,
          bottom: 20,
          child: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 30,
                color: Color(0xff0d253c),
              ),
            ]),
          ),
        ),
        Positioned.fill(
          left: left,
          right: right,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(28),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset(
                'assets/img/posts/large/${category.imageFileName}',
                fit: BoxFit.cover,
              ),
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Color(0xff0D253C),
                    Colors.transparent,
                  ]),
            ),
          ),
        ),
        Positioned(
          bottom: 48,
          left: realIndex == 0 ? 68 : 38,
          child: Text(
            category.title,
            style: themeData.textTheme.headline6!.apply(color: Colors.white),
          ),
        )
      ],
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({
    Key? key,
    required this.stories,
    required this.themeData,
  }) : super(key: key);

  final List<StoryData> stories;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 20, 0, 32),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 93,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: stories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final story = stories[index];
              return _Story(story: story, themeData: themeData);
            }),
      ),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story({
    Key? key,
    required this.story,
    required this.themeData,
  }) : super(key: key);

  final StoryData story;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.fromLTRB(0, 1, 10, 0),
      child: Column(
        children: [
          Stack(
            children: [
              story.isViewed ? _storyBorderViewed() : _storyBorderNormal(),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/img/icons/${story.iconFileName}',
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
          Text(
            story.name,
            style: themeData.textTheme.caption,
          ),
        ],
      ),
    );
  }

  Widget _storyBorderNormal() {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      width: 68,
      height: 68,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(begin: Alignment.topLeft, colors: [
            Color(0xff376AED),
            Color(0xff49B0E2),
            Color(0xff9CECFB),
          ])),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22)),
        child: _profileImage(),
      ),
    );
  }

  Widget _storyBorderViewed() {
    return Container(
      width: 68,
      height: 68,
      margin: const EdgeInsets.only(bottom: 6),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(24),
        strokeWidth: 2,
        color: const Color(0xff7B8BB2),
        dashPattern: const [8, 3],
        padding: const EdgeInsets.all(7),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: _profileImage(),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: Image.asset(
        'assets/img/stories/${story.imageFileName}',
        width: 54,
        height: 54,
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  final ThemeData themeData;
  const _PostList({Key? key, required this.themeData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final posts = AppDatabase.posts;
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 15, 32, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Latest News',
                style: themeData.textTheme.headline6!.copyWith(
                  fontSize: 20,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'More',
                  style: TextStyle(
                    color: Color(0xff376AED),
                  ),
                ),
              ),
            ],
          ),
          ListView.builder(
              itemCount: posts.length,
              itemExtent: 141,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final post = posts[index];
                return Post(
                  post: post,
                  themeData: themeData,
                );
              })
        ],
      ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({
    Key? key,
    required this.post,
    required this.themeData,
  }) : super(key: key);

  final PostData post;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ArticleScreen())),
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0x1a5282FF),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/img/posts/small/${post.imageFileName}',
                width: 120,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.caption,
                      style: const TextStyle(
                          fontFamily: FontFamily.avenir,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff376AED)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      post.title,
                      style: themeData.textTheme.subtitle2,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              CupertinoIcons.hand_thumbsup,
                              size: 16,
                              color: themeData.textTheme.caption!.color,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              post.likes,
                              style: themeData.textTheme.caption,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              CupertinoIcons.clock,
                              size: 16,
                              color: themeData.textTheme.caption!.color,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              post.time,
                              style: themeData.textTheme.caption,
                            ),
                          ],
                        ),
                        Icon(
                          post.isBookmarked
                              ? CupertinoIcons.bookmark_fill
                              : CupertinoIcons.bookmark,
                          size: 16,
                          color: themeData.textTheme.caption!.color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
