import 'dart:io';
import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VisualizableVideoPlayer extends StatefulWidget {
  final File file;
  VisualizableVideoPlayer({Key key, @required this.file}) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState(file: file);
}

class _CustomVideoPlayerState extends State<VisualizableVideoPlayer> {
  final VideoPlayerController _controller;
  SizeUtils _sizeUtils;
  _CustomVideoPlayerState({File file}):
    _controller = VideoPlayerController.file(file)
    ;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState((){});
    });
    _controller.setLooping(true);
    _controller.initialize().then((value) => setState((){}));
    //_controller.play();
  }

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Container(
      height: _sizeUtils.xasisSobreYasis * 0.6,
      width: _sizeUtils.xasisSobreYasis * 0.6,
      child: Stack(
        children: [
          VideoPlayer(_controller),
          _ControlsOverlay(controller: _controller),
          VideoProgressIndicator(_controller, allowScrubbing: true)
        ],
      )     
    );
  }

  void _initInitialConfiguration(BuildContext appContext){
    _sizeUtils = SizeUtils();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ControlsOverlay extends StatelessWidget {
  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];
  final VideoPlayerController controller;
  const _ControlsOverlay({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
            ? SizedBox.shrink()
            : Container(
                color: Colors.black26,
                child: Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 100.0,
                  ),
                ),
              ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}