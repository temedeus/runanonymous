import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:runanonymous/model/audio_player_interface.dart';

class AudioPlayerFacade implements AudioPlayerInterface {
  AudioCache _audioCache;

  AudioPlayerFacade() {
    AudioPlayer audioPlayer = AudioPlayer(
        mode: PlayerMode.LOW_LATENCY, playerId: 'runonymous-player');
    _audioCache = AudioCache(fixedPlayer: audioPlayer);
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
