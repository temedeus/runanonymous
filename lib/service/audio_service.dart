import 'package:runanonymous/model/audio_player_facade.dart';
import 'package:runanonymous/model/audio_player_interface.dart';
import 'package:runanonymous/service/audio_service_interface.dart';

class AudioService implements AudioServiceInterface {
  @override
  AudioPlayerInterface getAudioPlayer() {
    return AudioPlayerFacade();
  }
}
