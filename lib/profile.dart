import 'package:blogclub/data.dart';
import 'package:blogclub/gen/assets.gen.dart';
import 'package:blogclub/home.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final posts = AppDatabase.posts;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeData.colorScheme.background.withOpacity(0),
        title: const Text('Profle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 24)
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 64),
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color:
                            themeData.colorScheme.onBackground.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Assets.img.stories.story8.image(
                                width: 84,
                                height: 84,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('@joviedan'),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Text(
                                      'Jovi Daniel',
                                      style: themeData.textTheme.headline6,
                                    ),
                                  ),
                                  Text(
                                    'UX Designer',
                                    style: themeData.textTheme.bodyText1!
                                        .apply(
                                          color: themeData.colorScheme.primary,
                                        )
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'About me',
                          style: themeData.textTheme.bodyText1!
                              .copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Madison Blackstone is a director of user experience design, with experience managing global teams.',
                          style: themeData.textTheme.subtitle2,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 104,
                  right: 104,
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color:
                            themeData.colorScheme.onBackground.withOpacity(0.5),
                      )
                    ]),
                  ),
                ),
                Positioned(
                  bottom: 32,
                  left: 72,
                  right: 72,
                  child: Container(
                    height: 68,
                    decoration: BoxDecoration(
                      color: themeData.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff2151cd),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '52',
                                  style: themeData.textTheme.headline6!
                                      .copyWith(
                                          color:
                                              themeData.colorScheme.onPrimary),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Post',
                                  style: themeData.textTheme.caption!.copyWith(
                                      color: themeData.colorScheme.onPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '250',
                                style: themeData.textTheme.headline6!.copyWith(
                                    color: themeData.colorScheme.onPrimary),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Following',
                                style: themeData.textTheme.caption!.copyWith(
                                    color: themeData.colorScheme.onPrimary),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '4.5K',
                                style: themeData.textTheme.headline6!.copyWith(
                                    color: themeData.colorScheme.onPrimary),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Followers',
                                style: themeData.textTheme.caption!.copyWith(
                                    color: themeData.colorScheme.onPrimary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: themeData.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: themeData.colorScheme.onBackground.withOpacity(0.1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 32, 40, 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'My Posts',
                            style: themeData.textTheme.headline6,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Assets.img.icons.grid
                              .svg(color: themeData.colorScheme.primary),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Assets.img.icons.table.svg(),
                        ),
                      ],
                    ),
                    for (var i = 0; i < posts.length; i++)
                      Post(post: posts[i], themeData: themeData)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
