import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:platiq/globals.dart';
import 'package:platiq/widgets/global_widgets.dart';

class ChatsPage extends StatefulWidget {
  final bool isNested, workMode;

  const ChatsPage({Key? key, this.isNested = false, required this.workMode})
      : super(key: key);
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Builder(
          builder: (context) {
            return CustomScrollView(
              key: PageStorageKey<String>('Chats'),
              slivers: [
                SliverAppBar(
                  backgroundColor: widget.workMode
                      ? Theme.of(context).primaryColor
                      : GlobalValues.accentColor,
                  pinned: true,
                  automaticallyImplyLeading: !widget.isNested,
                  title: ListTile(
                    leading: CircleAvatar(),
                    title: TitleText('Username'),
                    subtitle: SubtitleText('Online'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.phoneAlt),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.video),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.ellipsisV),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        title: TitleText('Hello'),
                      );
                    },
                    childCount: 8,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
