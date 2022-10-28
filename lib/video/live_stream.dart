import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class LiveStreamWidget extends StatefulWidget {
  String rtsp;
  LiveStreamWidget({Key key, this.rtsp}) : super(key: key);

  @override
  State<LiveStreamWidget> createState() => _LiveStreamWidgetState();
}

class _LiveStreamWidgetState extends State<LiveStreamWidget> {
  VlcPlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    _controller = VlcPlayerController.network(
      widget.rtsp,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.startRendererScanning();
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Expanded(
                      child: VlcPlayer(
                        controller: _controller,
                        aspectRatio: 16 / 9,
                        placeholder: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text("RTSP link has not been set"),
              ));
  }
}
