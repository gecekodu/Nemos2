import 'package:nemos/models/game.dart';

class BuilderStep<T> {
  const BuilderStep({
    required this.id,
    required this.title,
    required this.description,
    required this.options,
  });

  final String id;
  final String title;
  final String description;
  final List<T> options;
}

const builderSteps = [
  BuilderStep<GameCategory>(
    id: 'category',
    title: 'Nasıl bir oyun istiyorsun?',
    description: 'Önce temel türü seçelim.',
    options: GameCategory.values,
  ),
  BuilderStep<SessionType>(
    id: 'sessionType',
    title: 'Oyuncular nasıl bağlanacak?',
    description: 'Bugün tek oyuncu ile başlayıp sonra multiplayer açabiliriz.',
    options: SessionType.values,
  ),
  BuilderStep<ThemeStyle>(
    id: 'theme',
    title: 'Görsel tema ne olsun?',
    description: 'Hazır HTML oyun paketlerini buna göre eşleştirebiliriz.',
    options: ThemeStyle.values,
  ),
  BuilderStep<PlayTime>(
    id: 'playTime',
    title: 'Oturum süresi ne kadar olsun?',
    description: 'Mobil kullanıcı için hızlı ve net deneyim seçelim.',
    options: PlayTime.values,
  ),
];

const gameLibrary = [
  GameConcept(
    id: 'pixel-dash-arena',
    title: 'Pixel Dash Arena',
    category: GameCategory.arcade,
    sessionType: SessionType.solo,
    theme: ThemeStyle.retroNeon,
    playTime: PlayTime.short,
    pitch: 'Sonsuz koşu parkurunda reflekslerini test eden hızlı tempolu skor oyunu.',
    mechanics: ['Tek dokunuş zıplama', 'Skor çarpanı', 'Günlük görev'],
    monetizationHint: 'Kozmetik karakter paketleri ve reklamla ikinci şans.',
    packageStatus: PackageStatus.prototype,
    htmlDelivery: 'Tek HTML dosyası + skor servisi entegrasyonu',
    multiplayerNote: 'Önce tek oyuncu skor sistemi, sonra ghost replay.',
  ),
  GameConcept(
    id: 'rune-grid',
    title: 'Rune Grid',
    category: GameCategory.puzzle,
    sessionType: SessionType.solo,
    theme: ThemeStyle.fantasy,
    playTime: PlayTime.medium,
    pitch: 'Mana zincirleri kurduğun rahatlatıcı puzzle oyunu.',
    mechanics: ['Match-3 varyasyonu', 'Büyü komboları', 'Seviye hedefleri'],
    monetizationHint: 'Premium bölüm paketleri.',
    packageStatus: PackageStatus.ready,
    htmlDelivery: 'Level JSON dosyalarıyla içerik güncellenebilir',
    multiplayerNote: 'Asenkron günlük challenge uygun.',
  ),
  GameConcept(
    id: 'star-forge-tactics',
    title: 'Star Forge Tactics',
    category: GameCategory.strategy,
    sessionType: SessionType.remoteMultiplayer,
    theme: ThemeStyle.sciFi,
    playTime: PlayTime.long,
    pitch: 'Farklı cihazlardan oynanabilen hafif taktik savaş.',
    mechanics: ['Sıralı tur sistemi', 'Kısa PvP maçları', 'Kart destekli yetenekler'],
    monetizationHint: 'Sezonluk görev kartı ve takım skinleri.',
    packageStatus: PackageStatus.planned,
    htmlDelivery: 'HTML istemci + websocket/turn API katmanı',
    multiplayerNote: 'Room yönetimi ve match state servisi gerekir.',
  ),
  GameConcept(
    id: 'cave-echo',
    title: 'Cave Echo',
    category: GameCategory.adventure,
    sessionType: SessionType.solo,
    theme: ThemeStyle.minimal,
    playTime: PlayTime.medium,
    pitch: 'Ses dalgalarıyla yolu ortaya çıkaran keşif deneyimi.',
    mechanics: ['Bulmaca odaları', 'Basit envanter', 'Checkpoint yapısı'],
    monetizationHint: 'Ek hikâye bölümleri.',
    packageStatus: PackageStatus.prototype,
    htmlDelivery: 'Offline-first HTML paketi',
    multiplayerNote: 'Co-op varyantı için rol tabanlı puzzle eklenebilir.',
  ),
  GameConcept(
    id: 'metro-mayhem',
    title: 'Metro Mayhem',
    category: GameCategory.party,
    sessionType: SessionType.remoteMultiplayer,
    theme: ThemeStyle.minimal,
    playTime: PlayTime.short,
    pitch: 'Arkadaş grubuna hızlı görevler atayan sosyal mini oyun hub fikri.',
    mechanics: ['Lobi kodu', 'Hızlı görevler', 'Anlık emoji tepkileri'],
    monetizationHint: 'Oda temaları ve etkinlik paketleri.',
    packageStatus: PackageStatus.planned,
    htmlDelivery: 'Lobby-first HTML launcher',
    multiplayerNote: 'En güçlü multiplayer adaylarından biri.',
  ),
];

const roadmapItems = [
  ('HTML Runtime Katmanı', 'Her oyun sonucunu WebView ile çalıştıracak runtime katmanı.'),
  ('İçerik Yönetimi', 'Oyun paketlerini JSON/CMS yapısından yönetmek.'),
  ('Multiplayer Servisleri', 'Lobby, room ve match-state servisleri.'),
  ('Analitik', 'Hangi seçimlerin daha çok tercih edildiğini izlemek.'),
];

GameConcept generateGameConcept(SelectionState selection) {
  for (final game in gameLibrary) {
    if (game.category == selection.category &&
        game.sessionType == selection.sessionType &&
        game.theme == selection.theme &&
        game.playTime == selection.playTime) {
      return game;
    }
  }

  GameConcept bestMatch = gameLibrary.first;
  var bestScore = -1;

  for (final game in gameLibrary) {
    var score = 0;
    if (game.category == selection.category) score++;
    if (game.sessionType == selection.sessionType) score++;
    if (game.theme == selection.theme) score++;
    if (game.playTime == selection.playTime) score++;

    if (score > bestScore) {
      bestScore = score;
      bestMatch = game;
    }
  }

  return bestMatch;
}

List<(String, String)> getRoadmapItems() => roadmapItems;
