import 'dart:async';
import 'package:flutter/material.dart';
import 'package:n_tel_care_family_app/flutter_flow/flutter_flow_util.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Map<String, dynamic> videoData;
  final String title;
  const VideoPlayerScreen(
      {Key key, @required this.videoData, @required this.title})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  bool _isLoading = true;
  double _playBackPosition = 0;
  Timer _playbackTimer;

  int _videoSyncTimeStamp = 1;

  @override
  void initState() {
    super.initState();
    _initiallizePlayer();
  }

  String _displayDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours != 0)
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";

    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  double _updatePlaybackPosition(double pos) {
    return min(pos, _controller.value.duration.inMilliseconds.toDouble());
  }

  Duration _getPlaybackPos({@required double milis}) {
    return Duration(milliseconds: milis.toInt());
  }

  void _killPlayer() {
    setState(() {
      _playbackTimer.cancel();
      _playBackPosition = 0;
      _controller.pause();
    });
  }

  void _initiallizePlayer() {
    _controller = VideoPlayerController.network(widget.videoData["path"],
        videoPlayerOptions: VideoPlayerOptions());
    _controller.initialize().then((_) {
      _controller.play();
      setState(() => _isLoading = false);
      _playbackTimer = Timer.periodic(
        Duration(milliseconds: _videoSyncTimeStamp),
        (timer) {
          setState(() {
            _playBackPosition = _updatePlaybackPosition(timer.tick.toDouble());
          });
          if (_playbackTimer.tick >=
              _controller.value.duration.inMilliseconds.toDouble())
            _killPlayer();
        },
      );
    });
  }

  void _resumeTimer(double position) {
    print("timer: $position");
    _playbackTimer =
        Timer.periodic(Duration(milliseconds: _videoSyncTimeStamp), (timer) {
      setState(() {
        _playBackPosition =
            _updatePlaybackPosition((position + timer.tick).toDouble());
      });
      if (_playbackTimer.tick >=
          _controller.value.duration.inMilliseconds.toDouble()) _killPlayer();
    });
  }

  void _pauseTimer() {
    _playbackTimer.cancel();
  }

  Future<void> _seekToPosition(double pos) async {
    _pauseTimer();
    await _controller.seekTo(Duration(milliseconds: pos.toInt()));
    _resumeTimer(pos);
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_playbackTimer.isActive) _playbackTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )),
          Positioned(
              bottom: 40,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          _displayDuration(
                              _getPlaybackPos(milis: _playBackPosition)),
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            min: 0,
                            max: _controller.value.duration.inMilliseconds
                                .toDouble(),
                            value: _playBackPosition,
                            onChanged: (val) async {
                              // await _seekToPosition(val);
                              // _resumeTimer(val);
                              // setState(() {
                              //   _playBackPosition = val;
                              // });
                            },
                          ),
                        ),
                        Text(
                          _displayDuration(_controller.value.duration),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () {
                            if (_controller.value.isPlaying)
                              setState(() {
                                _pauseTimer();
                                _controller.pause();
                              });
                            else
                              setState(() {
                                if (_playBackPosition !=
                                    _controller.value.duration.inMilliseconds) {
                                  _resumeTimer(_controller
                                      .value.position.inMilliseconds
                                      .toDouble());
                                  _controller.play();
                                }
                              });
                          },
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause_circle_outline
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 42,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
