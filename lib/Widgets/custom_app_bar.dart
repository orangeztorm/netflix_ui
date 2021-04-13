import 'package:flutter/material.dart';
import 'package:netflix_ui/Widgets/widgets.dart';
import 'package:netflix_ui/assets.dart';


class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({Key key, this.scrollOffset = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
      color:
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: Responsive(mobile: _CustomAppBarMobile(),
      desktop: _CustomAppBarDesktop(),),
    );
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                  ontap: () => print('Tv shows'),
                  title: 'TV Shows',
                ),
                _AppBarButton(
                  ontap: () => print('Movies'),
                  title: 'Movies',
                ),
                _AppBarButton(
                  ontap: () => print('My List'),
                  title: 'My List',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                  ontap: () => print('Home'),
                  title: 'Home ',
                ),
                _AppBarButton(
                  ontap: () => print('Tv shows'),
                  title: 'TV Shows',
                ),
                _AppBarButton(
                  ontap: () => print('Movies'),
                  title: 'Movies',
                ),
                _AppBarButton(
                  ontap: () => print('Latest'),
                  title: 'Latest',
                ),
                _AppBarButton(
                  ontap: () => print('My List'),
                  title: 'My List',
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.search), iconSize: 28.0, color: Colors.white,
                  onPressed: () => print('search'),
                  padding: EdgeInsets.zero,
                ),
                _AppBarButton(
                  ontap: () => print('KIDS'),
                  title: 'KIDS',
                ),
                _AppBarButton(
                  ontap: () => print('DVD'),
                  title: 'DVD',
                ),
                IconButton(
                  icon: Icon(Icons.card_giftcard), iconSize: 28.0, color: Colors.white,
                  onPressed: () => print('card'),
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  icon: Icon(Icons.notifications), iconSize: 28.0, color: Colors.white,
                  onPressed: () => print('notifications'),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class _AppBarButton extends StatelessWidget {
  final String title;
  final Function ontap;

  const _AppBarButton({Key key, this.title, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
