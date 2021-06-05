import 'package:flutter/material.dart';
import 'package:platiq/widgets/global_widgets.dart';

class CallsPage extends StatefulWidget {
  @override
  _CallsPageState createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
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
