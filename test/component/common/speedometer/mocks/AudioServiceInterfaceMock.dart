import 'package:runanonymous/model/audio_player_interface.dart';
import 'package:runanonymous/service/audio_service_interface.dart';

import 'AudioPlayerMock.dart';

class AudioServiceMock implements AudioServiceInterface {
  @override
  AudioPlayerInterface getAudioPlayer() {
    return AudioPlayerMock();
  }
}
