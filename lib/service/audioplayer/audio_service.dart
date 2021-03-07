import 'audio_player_facade.dart';
import 'audio_player_interface.dart';
import 'audio_service_interface.dart';

class AudioService implements AudioServiceInterface {
  @override
  AudioPlayerInterface getAudioPlayer() {
    return AudioPlayerFacade();
  }
}
