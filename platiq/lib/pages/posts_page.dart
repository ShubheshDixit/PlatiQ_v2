import 'package:flutter/material.dart';
import 'package:platiq/widgets/global_widgets.dart';

class PostsPage extends StatefulWidget {
  final String id;

  const PostsPage({Key? key, required this.id}) : super(key: key);
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(widget.id),
      ),
    );
  }
}
