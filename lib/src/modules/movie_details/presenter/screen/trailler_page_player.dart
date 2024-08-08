import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerYoutube extends StatefulWidget {
  static const routeName = '/trailler';
  final String? urlTrailler;
  const PlayerYoutube({this.urlTrailler, super.key});
  @override
  State<PlayerYoutube> createState() => _PlayerYoutubeState();
}

class _PlayerYoutubeState extends State<PlayerYoutube> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController? _controller;
  TextEditingController? _idController;
  TextEditingController? _seekToController;

  PlayerState? playerState;
  YoutubeMetaData? videoMetaData;

  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.urlTrailler!)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.unknown;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    setLandscape();
  }

  void setLandscape() async {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller!.value.isFullScreen) {
      setState(() {
        playerState = _controller!.value.playerState;
        videoMetaData = _controller!.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _controller!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _idController!.dispose();
    _seekToController!.dispose();
    resetOrientation();
    showSystemBars();
    super.dispose();
  }

  void resetOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void showSystemBars() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: false,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller!.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration()
        ],
        onReady: () {
          _isPlayerReady = true;
        },
      ),
    );
  }
}
