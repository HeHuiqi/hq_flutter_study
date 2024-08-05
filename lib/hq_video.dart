import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ext_video_player/ext_video_player.dart';

class HqVideoPage extends StatefulWidget {
  @override
  _HqVideoPageState createState() => _HqVideoPageState();
}

class _HqVideoPageState extends State<HqVideoPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    var url =
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
    // 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4';
    _controller = VideoPlayerController.network(url);

    // _controller.initialize().then((_) {
    //   // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //   setState(() {
    //     print('VideoPlayerController init:${_controller.value.initialized}');
    //   });
    // });
    // _controller.addListener(() {});
    _initializeVideoPlayerFuture = _controller.initialize();
    // _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video1 player'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                // child: CircularProgressIndicator(),
                child: CupertinoTextField(
                  placeholder: '用户名',
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
