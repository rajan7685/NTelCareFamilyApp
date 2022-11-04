import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:video_player/video_player.dart';

class LiveStreamWidget extends StatefulWidget {
  String rtsp;
  LiveStreamWidget({Key key, this.rtsp}) : super(key: key);

  @override
  State<LiveStreamWidget> createState() => _LiveStreamWidgetState();
}

class _LiveStreamWidgetState extends State<LiveStreamWidget> {
  // VlcPlayerController _controller;
  VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    _controller = VideoPlayerController.network(
        "rtsp://regami:regami@49.206.201.172:554/stream1");
    _controller.initialize().then((_) {
      _controller.play();
    });
    // _controller = VlcPlayerController.network(
    //   widget.rtsp,
    //   hwAcc: HwAcc.full,
    //   autoPlay: true,
    //   options: VlcPlayerOptions(),
    // );
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    // _controller.startRendererScanning();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.rtsp);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Live Stream RTSP'),
        ),
        // Use a FutureBuilder to display a loading spinner while waiting for the
        // VideoPlayerController to finish initializing.
        body: widget.rtsp != null
            ? Center(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : VideoPlayer(_controller),
              )
            : Center(
                child: Text("RTSP link has not been set"),
              ));
  }
}
