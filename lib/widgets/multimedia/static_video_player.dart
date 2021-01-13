import 'dart:io';
import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class CustomVideoPlayer extends StatefulWidget {
  final File file;
  CustomVideoPlayer({Key key, this.file}) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState(file: file);
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
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
      height: _sizeUtils.xasisSobreYasis * 0.03,
      width: _sizeUtils.xasisSobreYasis * 0.03,
       child: VideoPlayer(_controller),
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