// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_mj/controllers/utilites.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';

//import 'package:record_example/audio_player.dart';
class AudioRecorder extends StatefulWidget {
  final void Function(String path) onStop;
  const AudioRecorder({required this.onStop});
  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  bool _isRecording = false;
  bool _isPaused = false;
  bool _isStoped = false;
  int _recordDuration = 0;
  Timer? _timer;
  Timer? _ampTimer;
  final _audioRecorder = Record();
  ap.AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    _isRecording = false;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildRecordStopControl(),
                const SizedBox(width: 20),
                _buildPauseResumeControl(),
                const SizedBox(width: 20),
                _buildText(),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         if (_isStoped) {
            //           setState(() {
            //             _audioRecorder.stop();
            //             Utilities.audiopath = "";
            //             _isStoped = false;
            //           });
            //         }
            //       },
            //       child: Icon(
            //         Icons.delete,
            //         color: _isStoped ? Colors.black : Colors.grey,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 50,
            //     ),
            //     InkWell(
            //       onTap: () {
            //         if (_isStoped) {
            //           setState(() {
            //             _audioRecorder.stop();
            //             Utilities.audiopath = "";
            //             _isStoped = false;
            //           });
            //         }
            //       },
            //       child: Icon(
            //         Icons.restore,
            //         color: _isStoped ? Colors.black : Colors.grey,
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ],
    );
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_isRecording || _isPaused) {
      icon = Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 25);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 46, height: 46, child: icon),
          onTap: () {
            _isRecording ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (!_isRecording && !_isPaused) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (!_isPaused) {
      icon = Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 46, height: 46, child: icon),
          onTap: () {
            _isPaused ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_isRecording || _isPaused) {
      return _buildTimer();
    }

    return Text(
      "Record Picture description",
      style: TextStyle(fontSize: 12),
    );
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });
        _startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final path = await _audioRecorder.stop();
    print("Printing path");
    // print(path);
    if (path != null) {
      Utilities.audiopath = path;
      widget.onStop(path);
      setState(() => _isRecording = false);
      player.setFilePath(path);
    }
    print(Utilities.audiopath);
    setState(() {
      _isStoped = true;
    });
  }

  Future<void> _pause() async {
    _timer?.cancel();
    await _audioRecorder.pause();
    setState(() => _isPaused = true);
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();
    setState(() => _isPaused = false);
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}

class RecorderExample extends StatefulWidget {
  @override
  _RecorderExampleState createState() => _RecorderExampleState();
}

class _RecorderExampleState extends State<RecorderExample> {
  bool showPlayer = false;
  ap.AudioSource? audioSource;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AudioRecorder(
      onStop: (path) async {
        setState(() {
          audioSource = ap.AudioSource.uri(Uri.parse(path));
          showPlayer = true;
        });
      },
    );
  }
}
