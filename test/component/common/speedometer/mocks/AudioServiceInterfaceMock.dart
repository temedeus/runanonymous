import 'package:runanonymous/service/audioplayer/audio_player_interface.dart';
import 'package:runanonymous/service/audioplayer/audio_service_interface.dart';

import 'AudioPlayerMock.dart';

class AudioServiceMock implements AudioServiceInterface {
  @override
  AudioPlayerInterface getAudioPlayer() {
    return AudioPlayerMock();
  }
}
