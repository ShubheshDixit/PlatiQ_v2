import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:platiq/animations/fade_animations.dart';
import 'package:platiq/animations/scale_animation.dart';
import 'package:platiq/globals.dart';
import 'package:platiq/pages/calls_page.dart';
import 'package:platiq/pages/chats_page.dart';
import 'package:platiq/pages/contacts_page.dart';
import 'package:platiq/pages/intro_page.dart';
import 'package:platiq/widgets/global_widgets.dart';
import 'package:routemaster/routemaster.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return IntroPage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool workMode = false;
  late TabPageState tabPage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tabPage = TabPage.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth > 500
            ? Scaffold(
                body: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Material(
                        elevation: 2.0,
                        child: SizedBox(
                          child: _HomePageLeft(
                            onPressed: () {
                              setState(() {
                                workMode = !workMode;
                              });
                            },
                            tabController: tabPage.controller,
                            workMode: workMode,
                            isNested: true,
                            pageStack: tabPage.stacks,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ChatsPage(
                        isNested: true,
                        workMode: workMode,
                      ),
                    )
                  ],
                ),
              )
            : _HomePageLeft(
                onPressed: () {
                  setState(() {
                    workMode = !workMode;
                  });
                },
                pageStack: tabPage.stacks,
                tabController: tabPage.controller,
                workMode: workMode);
      },
    );
  }
}

class _HomePageLeft extends StatelessWidget {
  final Function() onPressed;
  final TabController tabController;
  final bool workMode, isNested;
  final List<PageStack> pageStack;

  const _HomePageLeft(
      {Key? key,
      required this.onPressed,
      required this.tabController,
      required this.workMode,
      this.isNested = false,
      required this.pageStack})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                pinned: innerBoxIsScrolled,
                forceElevated: innerBoxIsScrolled,
                backgroundColor: workMode
                    ? Theme.of(context).primaryColor
                    : GlobalValues.accentColor,
                title: TitleText('Welcome, Shubh'),
                actions: [
                  IconButton(
                      onPressed: () {}, icon: Icon(FontAwesomeIcons.bell)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.bars),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
                child: ModeTileView(
              onPressed: onPressed,
              workMode: workMode,
            )),
            SliverPersistentHeader(
              pinned: true,
              delegate: SectionHeaderDelegate(
                Material(
                  elevation: 8.0,
                  child: Container(
                    height: 70,
                    color: Theme.of(context).cardColor,
                    child: TabBar(
                      controller: tabController,
                      tabs: [
                        Tab(
                          child: Icon(
                            FontAwesomeIcons.solidCommentDots,
                            size: 25,
                          ),
                        ),
                        Tab(
                          child: Icon(
                            FontAwesomeIcons.phoneAlt,
                            size: 25,
                          ),
                        ),
                        Tab(
                          child: Icon(
                            FontAwesomeIcons.userFriends,
                            size: 25,
                          ),
                        ),
                        // Tab(
                        //   child: Icon(
                        //     FontAwesomeIcons.image,
                        //     size: 25,
                        //   ),
                        // ),
                      ],
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 4.0,
                    ),
                  ),
                ),
                70,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [ChatViewPage(), CallsPage(), ContactsPage()],
        ),
      ),
    );
  }
}

class ChatViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isNested =
        MediaQuery.of(context).size.width > 500 ? true : false;
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) {
          return Material(
            color:
                isNested ? Theme.of(context).canvasColor : Colors.transparent,
            elevation: 0.0,
            child: CustomScrollView(
              key: PageStorageKey<String>('Chats_tab'),
              slivers: [
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        leading: CircleAvatar(),
                        title: TitleText('username'),
                        subtitle: SubtitleText('this is sdf d dkf'),
                      );
                    },
                    childCount: 20,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  SectionHeaderDelegate(this.child, [this.height = 50]);

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

class ModeTileView extends StatelessWidget {
  final bool workMode, isNested;
  final Function() onPressed;
  const ModeTileView(
      {Key? key,
      required this.workMode,
      required this.onPressed,
      this.isNested = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 300,
      duration: Duration(milliseconds: 500),
      color:
          workMode ? Theme.of(context).primaryColor : GlobalValues.accentColor,
      child: FadeAnimation(
        delay: 0.2,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: TextButton(
                        onPressed: onPressed,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 8.0),
                              child: SubtitleText(
                                'Work Mode is ${workMode ? 'On' : 'Off'}',
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  color: !workMode
                                      ? Theme.of(context).primaryColorDark
                                      : GlobalValues.accentColor,
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  TitleText(
                    !workMode ? 'It\'s relax time' : 'It\'s office time',
                    color: Colors.white,
                    fontSize: 22,
                    extraBold: true,
                  ),
                  SubtitleText(
                    !workMode
                        ? 'You will get all notifications until you turn work mode on.'
                        : 'You will only get notifications for emergency contacts and office contacts.',
                    color: Colors.grey.shade300,
                    textAlign: TextAlign.center,
                  ),
                  ScaleAnimation(
                    child: Image.asset(
                      !workMode
                          ? GlobalValues.socialImage
                          : GlobalValues.workImage,
                      height: 220,
                      fit: BoxFit.cover,
                      width: 300,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
