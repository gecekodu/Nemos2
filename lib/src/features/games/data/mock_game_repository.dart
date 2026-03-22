import '../../../core/utils/game_matcher.dart';
import '../domain/game_models.dart';

class MockGameRepository {
  MockGameRepository() : _matcher = const GameMatcher();

  final GameMatcher _matcher;

  List<GameProfile> get featuredGames => _games;

  List<FriendProfile> get friends => _friends;

  List<LeaderboardEntry> get leaderboard => _leaderboard;

  GameProfile generateForSelection(BuilderSelection selection) {
    return _matcher.match(selection: selection, library: _games);
  }

  int get totalPossibilityCount =>
      GameMode.values.length *
      GameTempo.values.length *
      SocialStyle.values.length *
      WorldTheme.values.length;
}

const List<GameProfile> _games = [
  GameProfile(id: 'n1', title: 'Rift Rivals', shortDescription: 'Kısa PvP düelloları sunan tempolu arena oyunu.', experience: 'Aşağı kaydırmalı keşfet ekranında öne çıkan rekabetçi deneyim.', mode: GameMode.rekabet, tempo: GameTempo.hizli, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.bilimKurgu, tags: ['Rekabet', 'Hızlı', 'arena'], likes: 1240, comments: 183, score: 9220),
  GameProfile(id: 'n2', title: 'Dream Garden', shortDescription: 'Rahatlatıcı görev döngüsü olan soft progression oyunu.', experience: 'Günün sonunda sakinleşmek isteyen kullanıcıya hitap eder.', mode: GameMode.rahat, tempo: GameTempo.orta, socialStyle: SocialStyle.tekKisilik, theme: WorldTheme.fantastik, tags: ['Rahat', 'Orta', 'koleksiyon'], likes: 830, comments: 77, score: 6410),
  GameProfile(id: 'n3', title: 'Chronicle Echo', shortDescription: 'Seçim bazlı bölümlerle ilerleyen mobil hikâye oyunu.', experience: 'Kişiselleştirilmiş oyun sonucu ekranında güçlü bir “senin için üretildi” hissi verir.', mode: GameMode.hikaye, tempo: GameTempo.uzun, socialStyle: SocialStyle.tekKisilik, theme: WorldTheme.fantastik, tags: ['Hikâye', 'Uzun', 'karar'], likes: 910, comments: 119, score: 7025),
  GameProfile(id: 'n4', title: 'Pocket Party Rush', shortDescription: 'Arkadaşlarla oynanan hızlı mini oyun serisi.', experience: 'Reels benzeri akışta yüksek etkileşim alan sosyal içerik.', mode: GameMode.parti, tempo: GameTempo.refleks, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.fantastik, tags: ['Parti', 'Refleks', 'arkadaş'], likes: 1944, comments: 312, score: 10020),
  GameProfile(id: 'n5', title: 'Nebula Board', shortDescription: 'Kısa oturumlu ama düşünerek oynanan taktik savaş.', experience: 'Liderlik sıralamasında tekrar oynanabilirlik sağlayan stratejik yapı.', mode: GameMode.strateji, tempo: GameTempo.dusunerek, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.bilimKurgu, tags: ['Strateji', 'Düşünerek', 'sıralama'], likes: 1180, comments: 166, score: 8810),
  GameProfile(id: 'n6', title: 'Turbo Tiles', shortDescription: 'Tek dokunuşla ilerleyen refleks tabanlı eşleştirme.', experience: 'Kısa seans arayan kullanıcı için idealdir.', mode: GameMode.rekabet, tempo: GameTempo.refleks, socialStyle: SocialStyle.tekKisilik, theme: WorldTheme.bilimKurgu, tags: ['Rekabet', 'Refleks', 'skor'], likes: 1112, comments: 80, score: 7600),
  GameProfile(id: 'n7', title: 'Mistik Yolculuk', shortDescription: 'Bölüm bölüm açılan hikâye ve keşif yapısı.', experience: 'Görsel dünya ve anlatıyı öne çıkarır.', mode: GameMode.hikaye, tempo: GameTempo.orta, socialStyle: SocialStyle.tekKisilik, theme: WorldTheme.fantastik, tags: ['Hikâye', 'Orta', 'keşif'], likes: 680, comments: 59, score: 5580),
  GameProfile(id: 'n8', title: 'Co-Op Cosmos', shortDescription: 'İki arkadaşın görevleri birlikte çözdüğü sosyal yapboz.', experience: 'Arkadaş sistemiyle doğal bağ kurar.', mode: GameMode.strateji, tempo: GameTempo.orta, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.bilimKurgu, tags: ['Strateji', 'Orta', 'arkadaş'], likes: 1040, comments: 131, score: 7899),
  GameProfile(id: 'n9', title: 'Forest Flick', shortDescription: 'Dikey akışta viral potansiyeli yüksek refleks koşusu.', experience: 'Keşfet sayfasının en paylaşılabilir oyunlarından biri.', mode: GameMode.parti, tempo: GameTempo.hizli, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.fantastik, tags: ['Parti', 'Hızlı', 'viral'], likes: 2104, comments: 407, score: 10990),
  GameProfile(id: 'n10', title: 'Signal Siege', shortDescription: 'Bilim kurgu temalı kısa kule savunma deneyimi.', experience: 'Strateji isteyen ama uzun seans istemeyen kullanıcıya uygun.', mode: GameMode.strateji, tempo: GameTempo.hizli, socialStyle: SocialStyle.tekKisilik, theme: WorldTheme.bilimKurgu, tags: ['Strateji', 'Hızlı', 'savunma'], likes: 870, comments: 93, score: 6305),
  GameProfile(id: 'n11', title: 'Luna Lounge', shortDescription: 'Yavaş tempolu dekorasyon ve ilerleme loop’u.', experience: 'Geri dönme oranını artıran rahat deneyim.', mode: GameMode.rahat, tempo: GameTempo.uzun, socialStyle: SocialStyle.tekKisilik, theme: WorldTheme.bilimKurgu, tags: ['Rahat', 'Uzun', 'dekorasyon'], likes: 720, comments: 61, score: 5200),
  GameProfile(id: 'n12', title: 'Hero Draft', shortDescription: 'Arkadaşlarla seçim yapıp takım kurulan taktik eşleşmeler.', experience: 'Sosyal ve rekabetçi kullanıcı segmentini aynı anda besler.', mode: GameMode.strateji, tempo: GameTempo.dusunerek, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.fantastik, tags: ['Strateji', 'Düşünerek', 'takım'], likes: 1320, comments: 172, score: 9320),
  GameProfile(id: 'n13', title: 'Pixel Picnic', shortDescription: 'Hafif görevler ve samimi atmosfer sunan casual deneyim.', experience: 'Ana sayfadaki öneri blokları için güvenli broad appeal içerik.', mode: GameMode.rahat, tempo: GameTempo.hizli, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.fantastik, tags: ['Rahat', 'Hızlı', 'casual'], likes: 980, comments: 100, score: 7002),
  GameProfile(id: 'n14', title: 'Echo Frames', shortDescription: 'Karar bazlı bilim kurgu bölümleri ve çoklu sonlar.', experience: 'Oyun oluştur ekranındaki premium his için uygun.', mode: GameMode.hikaye, tempo: GameTempo.dusunerek, socialStyle: SocialStyle.tekKisilik, theme: WorldTheme.bilimKurgu, tags: ['Hikâye', 'Düşünerek', 'sinematik'], likes: 1150, comments: 134, score: 8211),
  GameProfile(id: 'n15', title: 'Arena Loop', shortDescription: 'Hızlı maç bul ve hemen savaşa gir deneyimi.', experience: 'Rekabet odaklı çekirdek kullanıcıları tutar.', mode: GameMode.rekabet, tempo: GameTempo.hizli, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.fantastik, tags: ['Rekabet', 'Hızlı', 'ranked'], likes: 1760, comments: 243, score: 9833),
  GameProfile(id: 'n16', title: 'Soft Orbit', shortDescription: 'Tek başına rahatça akan bilim kurgu idle-casual yapı.', experience: 'Firebase sonrası retention ve notification denemeleri için uygun.', mode: GameMode.rahat, tempo: GameTempo.orta, socialStyle: SocialStyle.tekKisilik, theme: WorldTheme.bilimKurgu, tags: ['Rahat', 'Orta', 'idle'], likes: 660, comments: 42, score: 4890),
  GameProfile(id: 'n17', title: 'Guild Sprint', shortDescription: 'Arkadaşlarla görev tamamlama yarışına dayalı event oyunu.', experience: 'Arkadaşlık sistemiyle birlikte canlı operasyon için güçlü aday.', mode: GameMode.parti, tempo: GameTempo.orta, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.fantastik, tags: ['Parti', 'Orta', 'etkinlik'], likes: 1450, comments: 211, score: 8990),
  GameProfile(id: 'n18', title: 'Vault Mind', shortDescription: 'Bulmaca ve planlama hissi veren taktiksel tek kişilik deneyim.', experience: 'Düşünerek oynayan kullanıcı segmenti için güvenilir içerik.', mode: GameMode.strateji, tempo: GameTempo.dusunerek, socialStyle: SocialStyle.tekKisilik, theme: WorldTheme.fantastik, tags: ['Strateji', 'Düşünerek', 'tek'], likes: 890, comments: 95, score: 6504),
  GameProfile(id: 'n19', title: 'Nova Story Jam', shortDescription: 'Arkadaşlarla seçim yaparak dallanan bölüm akışı.', experience: 'Sosyal hikâye tüketimi için farklılaşan bir öneri.', mode: GameMode.hikaye, tempo: GameTempo.uzun, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.bilimKurgu, tags: ['Hikâye', 'Uzun', 'arkadaş'], likes: 1094, comments: 143, score: 8110),
  GameProfile(id: 'n20', title: 'Blink Bash', shortDescription: 'Anlık karar ve refleks isteyen mini mücadele akışı.', experience: 'Dikey kaydırmada izlenme ve yeniden deneme motivasyonu yüksek.', mode: GameMode.rekabet, tempo: GameTempo.refleks, socialStyle: SocialStyle.arkadaslarla, theme: WorldTheme.bilimKurgu, tags: ['Rekabet', 'Refleks', 'mini maç'], likes: 1864, comments: 279, score: 9710),
];

const List<FriendProfile> _friends = [
  FriendProfile(name: 'Ece', handle: '@eceplays', level: 18, status: 'Şu an Rift Rivals oynuyor'),
  FriendProfile(name: 'Mert', handle: '@mertnova', level: 24, status: 'Seni düelloya davet etti'),
  FriendProfile(name: 'Deniz', handle: '@denizloop', level: 15, status: 'Yeni oyun oluşturdu'),
];

const List<LeaderboardEntry> _leaderboard = [
  LeaderboardEntry(rank: 1, player: 'NovaQueen', points: 15240, favoriteGame: 'Arena Loop'),
  LeaderboardEntry(rank: 2, player: 'TaktikMert', points: 14810, favoriteGame: 'Hero Draft'),
  LeaderboardEntry(rank: 3, player: 'EcePixel', points: 14170, favoriteGame: 'Forest Flick'),
  LeaderboardEntry(rank: 4, player: 'DenizZen', points: 13340, favoriteGame: 'Dream Garden'),
  LeaderboardEntry(rank: 5, player: 'OrbitAda', points: 12880, favoriteGame: 'Signal Siege'),
];
