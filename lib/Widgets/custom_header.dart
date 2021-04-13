import 'package:flutter/material.dart';
import 'package:netflix_ui/models/content_model.dart';
import 'package:video_player/video_player.dart';

import 'widgets.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({Key key, this.featuredContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _CustomHeaderMobile(featuredContent: featuredContent),
        desktop: _CustomHeaderDesktop(featuredContent: featuredContent));
  }
}

class _CustomHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  const _CustomHeaderMobile({Key key, this.featuredContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(featuredContent.imageUrl),
            fit: BoxFit.cover,
          )),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
              width: 250.0, child: Image.asset(featuredContent.titleImageUrl)),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                  icon: Icons.add,
                  title: 'List',
                  onTap: () => print('My List')),
              _PlayButton(),
              VerticalIconButton(
                  icon: Icons.info_outline,
                  title: 'Info',
                  onTap: () => print('Info')),
            ],
          ),
        )
      ],
    );
  }
}

class _CustomHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _CustomHeaderDesktop({Key key, this.featuredContent}) : super(key: key);

  @override
  __CustomHeaderDesktopState createState() => __CustomHeaderDesktopState();
}

class __CustomHeaderDesktopState extends State<_CustomHeaderDesktop> {
  VideoPlayerController _videoPlayerController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.featuredContent.videoUrl)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoPlayerController.value.isInitialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            bottom: -1.0,
            left: 0,
            right: 0,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.isInitialized
                  ? _videoPlayerController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
              ),
            ),
          ),

          Positioned(
              left: 60.0,
              right: 60.0,
              bottom: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: Image.asset(widget.featuredContent.titleImageUrl),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    widget.featuredContent.description,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(2.0, 4.0),
                              blurRadius: 6.0),
                        ]),
                  ),
                  Row(
                    children: [
                      _PlayButton(),
                      const SizedBox(width: 16.0),
                      TextButton.icon(
                          onPressed: () => print('more info'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 5.0))),
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.black,size: 30.0,
                          ),
                          label: const Text(
                            'More Info',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          )),
                      const SizedBox(width: 20.0),
                      if (_videoPlayerController.value.isInitialized)
                        IconButton(
                          icon: Icon(
                              _isMuted ? Icons.volume_off : Icons.volume_up),
                          color: Colors.white,
                          iconSize: 30,
                          onPressed: () =>  setState(() {
                            _isMuted
                                ? _videoPlayerController.setVolume(100)
                                : _videoPlayerController.setVolume(0);
                            _isMuted =  _videoPlayerController.value.volume == 0;
                          }),
                        )
                    ],
                  ),
                ],
              )),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => print('play'),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: !Responsive.isDesktop(context) ? MaterialStateProperty.all(
              EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)): MaterialStateProperty.all(
    EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 5.0))),
      icon: const Icon(
        Icons.play_arrow,
        color: Colors.black,
        size: 30.0,
      ),
      label: const Text(
        'Play',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
