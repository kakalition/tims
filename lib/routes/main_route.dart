import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MainRoute extends StatelessWidget {
  const MainRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Study Timer"),
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(LineIcons.gripLines),
            );
          }),
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(LineIcons.cog))
          ],
        ),
        drawer: Drawer(
          child: Text("TEST"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ));
  }
}
