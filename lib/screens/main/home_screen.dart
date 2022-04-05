import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/main/challenge_feed.dart';
import 'package:social_media/screens/main/posts.dart';

class Home extends StatefulWidget {
  final int pageIndex;
  const Home({Key? key, required this.pageIndex}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Key keyFeed = const PageStorageKey("pageFeed");
  final Key keyPosts = const PageStorageKey("pagePosts");
  final GlobalKey _bottomNavigationKey = GlobalKey();
  int _activePage = 0;

  @override
  void initState() {
    _activePage = widget.pageIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> _tabItems = [
      Feed(),
      Posts(),
    ];
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          buttonBackgroundColor: Colors.grey[300],
          backgroundColor: Colors.blue,
          animationDuration: const Duration(milliseconds: 250),
          index: _activePage,
          animationCurve: Curves.bounceInOut,
          key: _bottomNavigationKey,
          height: 55,
          items: const [
            Icon(Icons.explore, size: 25),
            Icon(Icons.bookmark, size: 25),
          ],
          onTap: (index) {
            if (index != _activePage) {
              setState(() {
                _activePage = index;
              });
            }
          },
        ),
        body: _tabItems[_activePage]);
  }
}
