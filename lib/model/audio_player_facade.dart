import 'package:audioplayers/audio_cache.dart';
import 'package:runanonymous/model/audio_player_interface.dart';

class AudioPlayerFacade implements AudioPlayerInterface {
  AudioCache _audioCache;

  AudioPlayerFacade() {
    _audioCache = AudioCache();
  }

  @override
  Future<void> playSound(String sound) async {
    await _audioCache.play(sound);
  }

  @override
  void clear() {
    _audioCache.clearCache();
  }
}
