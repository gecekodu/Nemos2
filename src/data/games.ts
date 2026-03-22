export type GameCategory = 'Arcade' | 'Bulmaca' | 'Strateji' | 'Macera' | 'Parti';
export type SessionType = 'Tek Oyuncu' | 'Aynı Ekran Çoklu' | 'Uzaktan Çoklu';
export type ThemeStyle = 'Retro Neon' | 'Minimal' | 'Fantastik' | 'Bilim Kurgu';
export type PlayTime = '3-5 dk' | '5-10 dk' | '10+ dk';

export type GameConcept = {
  id: string;
  title: string;
  category: GameCategory;
  sessionType: SessionType;
  theme: ThemeStyle;
  playTime: PlayTime;
  pitch: string;
  mechanics: string[];
  monetizationHint: string;
};

export const steps = [
  {
    key: 'category',
    title: 'Nasıl bir oyun istiyorsun?',
    description: 'Önce temel türü seçelim.',
    options: ['Arcade', 'Bulmaca', 'Strateji', 'Macera', 'Parti'] as const,
  },
  {
    key: 'sessionType',
    title: 'Oyuncular nasıl bağlanacak?',
    description: 'Bugün tek oyuncu ile başlayıp yarın multiplayer açabiliriz.',
    options: ['Tek Oyuncu', 'Aynı Ekran Çoklu', 'Uzaktan Çoklu'] as const,
  },
  {
    key: 'theme',
    title: 'Görsel tema ne olsun?',
    description: 'Hazır HTML oyun şablonlarını buna göre eşleştirebiliriz.',
    options: ['Retro Neon', 'Minimal', 'Fantastik', 'Bilim Kurgu'] as const,
  },
  {
    key: 'playTime',
    title: 'Oturum süresi ne kadar olsun?',
    description: 'Mobil kullanıcı için hızlı ve net deneyim seçelim.',
    options: ['3-5 dk', '5-10 dk', '10+ dk'] as const,
  },
] as const;

export const gameLibrary: GameConcept[] = [
  {
    id: 'pixel-dash-arena',
    title: 'Pixel Dash Arena',
    category: 'Arcade',
    sessionType: 'Tek Oyuncu',
    theme: 'Retro Neon',
    playTime: '3-5 dk',
    pitch: 'Sonsuz koşu parkurunda reflekslerini test eden hızlı tempolu bir skor oyunu.',
    mechanics: ['Tek dokunuş zıplama', 'Skor çarpanı', 'Günlük görev'],
    monetizationHint: 'Kozmetik karakter paketleri ve reklamla ikinci şans.',
  },
  {
    id: 'sync-smash-party',
    title: 'Sync Smash Party',
    category: 'Parti',
    sessionType: 'Aynı Ekran Çoklu',
    theme: 'Retro Neon',
    playTime: '3-5 dk',
    pitch: 'Aynı cihazda mini mücadeleler oynatan rekabetçi parti deneyimi.',
    mechanics: ['Bölünmüş ekran', '3 turlu mini oyun seti', 'Anlık skor tablosu'],
    monetizationHint: 'Turnuva biletleri ve özel parti temaları.',
  },
  {
    id: 'rune-grid',
    title: 'Rune Grid',
    category: 'Bulmaca',
    sessionType: 'Tek Oyuncu',
    theme: 'Fantastik',
    playTime: '5-10 dk',
    pitch: 'Sembolleri eşleştirerek mana zincirleri kurduğun rahatlatıcı puzzle oyunu.',
    mechanics: ['Match-3 varyasyonu', 'Büyü komboları', 'Seviye hedefleri'],
    monetizationHint: 'Enerji sistemi olmadan premium bölüm paketleri.',
  },
  {
    id: 'star-forge-tactics',
    title: 'Star Forge Tactics',
    category: 'Strateji',
    sessionType: 'Uzaktan Çoklu',
    theme: 'Bilim Kurgu',
    playTime: '10+ dk',
    pitch: 'Asenkron hamle sistemiyle farklı cihazlardan oynanabilen hafif taktik savaş.',
    mechanics: ['Sıralı tur sistemi', 'Kısa PvP maçları', 'Kart destekli yetenekler'],
    monetizationHint: 'Sezonluk görev kartı ve takım skinleri.',
  },
  {
    id: 'cave-echo',
    title: 'Cave Echo',
    category: 'Macera',
    sessionType: 'Tek Oyuncu',
    theme: 'Minimal',
    playTime: '5-10 dk',
    pitch: 'Ses dalgalarıyla yolu ortaya çıkaran atmosferik keşif deneyimi.',
    mechanics: ['Bulmaca odaları', 'Basit envanter', 'Checkpoint yapısı'],
    monetizationHint: 'Ek hikâye bölümleri.',
  },
  {
    id: 'orbital-rush',
    title: 'Orbital Rush',
    category: 'Arcade',
    sessionType: 'Uzaktan Çoklu',
    theme: 'Bilim Kurgu',
    playTime: '3-5 dk',
    pitch: 'Farklı cihazlardan bağlanılan kısa süreli rekabetçi uzay yarışı.',
    mechanics: ['Ghost yarış modu', 'Lider tablosu', 'Haftalık pistler'],
    monetizationHint: 'Araç kaplamaları ve sezonluk pist bileti.',
  },
  {
    id: 'glyphkeepers',
    title: 'Glyphkeepers',
    category: 'Strateji',
    sessionType: 'Tek Oyuncu',
    theme: 'Fantastik',
    playTime: '10+ dk',
    pitch: 'Kule savunmasını kart sinerjileriyle birleştiren bölüm tabanlı strateji.',
    mechanics: ['Kule yükseltme', 'Kart destesi', 'Boss dalgaları'],
    monetizationHint: 'Kampanya genişleme paketleri.',
  },
  {
    id: 'mirror-bounce',
    title: 'Mirror Bounce',
    category: 'Bulmaca',
    sessionType: 'Aynı Ekran Çoklu',
    theme: 'Minimal',
    playTime: '3-5 dk',
    pitch: 'İki kişinin aynı ekranda lazerleri aynalarla yönlendirdiği co-op puzzle.',
    mechanics: ['Kooperatif görevler', 'Zaman baskısı', 'Yıldız sistemi'],
    monetizationHint: 'Premium bulmaca paketleri.',
  },
  {
    id: 'kingdom-sprint',
    title: 'Kingdom Sprint',
    category: 'Macera',
    sessionType: 'Uzaktan Çoklu',
    theme: 'Fantastik',
    playTime: '5-10 dk',
    pitch: 'Arkadaşlarınla aynı haritada görev tamamlama yarışına girdiğin hafif macera.',
    mechanics: ['Görev zincirleri', 'Arkadaş daveti', 'Ortak etkinlikler'],
    monetizationHint: 'Avatar aksesuarları.',
  },
  {
    id: 'tap-temple',
    title: 'Tap Temple',
    category: 'Parti',
    sessionType: 'Aynı Ekran Çoklu',
    theme: 'Fantastik',
    playTime: '3-5 dk',
    pitch: 'Refleks ve ritim tabanlı mini oyunları bir araya getiren hızlı parti paketi.',
    mechanics: ['Ritim bölümleri', 'Hızlı düello', 'Skor serisi'],
    monetizationHint: 'Yeni mini oyun sezonları.',
  },
  {
    id: 'neon-tiles',
    title: 'Neon Tiles',
    category: 'Bulmaca',
    sessionType: 'Tek Oyuncu',
    theme: 'Retro Neon',
    playTime: '3-5 dk',
    pitch: 'Kaydırmalı taş bulmacasını günlük hedeflerle zenginleştiren minimalist tasarım.',
    mechanics: ['Grid tabanlı bulmaca', 'Seri bonusları', 'Günlük challenge'],
    monetizationHint: 'İpucu paketi ve tema renkleri.',
  },
  {
    id: 'astro-link',
    title: 'Astro Link',
    category: 'Bulmaca',
    sessionType: 'Uzaktan Çoklu',
    theme: 'Bilim Kurgu',
    playTime: '5-10 dk',
    pitch: 'Oyuncuların farklı cihazlardan enerji düğümlerini eş zamanlı bağladığı takım puzzle oyunu.',
    mechanics: ['Gerçek zamanlı görevler', 'Rol bazlı sorumluluk', 'Takım puanı'],
    monetizationHint: 'Kurumsal/okul etkinliği paketleri.',
  },
  {
    id: 'void-raiders',
    title: 'Void Raiders',
    category: 'Arcade',
    sessionType: 'Uzaktan Çoklu',
    theme: 'Retro Neon',
    playTime: '5-10 dk',
    pitch: 'Kısa arenalarda geçen twin-stick shooter tarzı HTML oyun fikri.',
    mechanics: ['Power-up düşüşü', '2v2 maçlar', 'Basit kontrol şeması'],
    monetizationHint: 'Savaş bileti ve efekt paketleri.',
  },
  {
    id: 'forest-fold',
    title: 'Forest Fold',
    category: 'Bulmaca',
    sessionType: 'Tek Oyuncu',
    theme: 'Fantastik',
    playTime: '10+ dk',
    pitch: 'Kağıt katlama mantığını büyülü orman görevleriyle birleştiren rahat deneyim.',
    mechanics: ['Origami benzeri kontroller', 'Bölüm haritası', 'Toplanabilir notlar'],
    monetizationHint: 'Dekoratif arkaplan setleri.',
  },
  {
    id: 'signal-ops',
    title: 'Signal Ops',
    category: 'Strateji',
    sessionType: 'Uzaktan Çoklu',
    theme: 'Minimal',
    playTime: '5-10 dk',
    pitch: 'Asenkron eşleşmelerle ilerleyen kaynak yönetimi ve üs savunma karışımı.',
    mechanics: ['Planlama fazı', 'Kaynak döngüsü', 'Haftalık klan görevi'],
    monetizationHint: 'Klan amblemleri ve premium raporlar.',
  },
  {
    id: 'pocket-questline',
    title: 'Pocket Questline',
    category: 'Macera',
    sessionType: 'Tek Oyuncu',
    theme: 'Retro Neon',
    playTime: '10+ dk',
    pitch: 'Mini kararlarla dallanan hikâyeye sahip hafif RPG/macera yapısı.',
    mechanics: ['Seçim ekranları', 'Basit savaşlar', 'Bölüm bölünmüş hikâye'],
    monetizationHint: 'Ek kahraman hikâyeleri.',
  },
  {
    id: 'metro-mayhem',
    title: 'Metro Mayhem',
    category: 'Parti',
    sessionType: 'Uzaktan Çoklu',
    theme: 'Minimal',
    playTime: '3-5 dk',
    pitch: 'Arkadaş grubuna hızlı görevler atayan sosyal mini oyun hub fikri.',
    mechanics: ['Lobi kodu', 'Hızlı görevler', 'Anlık emoji tepkileri'],
    monetizationHint: 'Oda temaları ve etkinlik paketleri.',
  },
  {
    id: 'skyline-stack',
    title: 'Skyline Stack',
    category: 'Arcade',
    sessionType: 'Tek Oyuncu',
    theme: 'Minimal',
    playTime: '3-5 dk',
    pitch: 'Düşen parçaları dengeleyerek kule inşa ettiğin yüksek tekrar oynanabilirlikli oyun.',
    mechanics: ['Fizik tabanlı bloklar', 'Skor hedefleri', 'Tek el kontrol'],
    monetizationHint: 'Tema paketleri ve özel kule efektleri.',
  },
  {
    id: 'chrono-camp',
    title: 'Chrono Camp',
    category: 'Strateji',
    sessionType: 'Aynı Ekran Çoklu',
    theme: 'Bilim Kurgu',
    playTime: '10+ dk',
    pitch: 'Tek cihazda sıra paylaşımıyla oynanan üs kurma düellosu.',
    mechanics: ['Tur paylaşımı', 'Tech tree', 'Kaynak sabotajı'],
    monetizationHint: 'Harita setleri.',
  },
  {
    id: 'dream-lanterns',
    title: 'Dream Lanterns',
    category: 'Macera',
    sessionType: 'Aynı Ekran Çoklu',
    theme: 'Fantastik',
    playTime: '5-10 dk',
    pitch: 'İki kişinin tek ekranda karakterleri koordine ettiği hikâye odaklı bulmaca macera.',
    mechanics: ['Rol paylaşımı', 'İşbirlikçi bulmacalar', 'Bölüm sonu seçimleri'],
    monetizationHint: 'Yeni hikâye bölümleri.',
  },
];

export type SelectionState = {
  category?: GameCategory;
  sessionType?: SessionType;
  theme?: ThemeStyle;
  playTime?: PlayTime;
};

const fallbackGame = gameLibrary[0];

export function generateGameConcept(selection: SelectionState): GameConcept {
  const exactMatch = gameLibrary.find(
    (game) =>
      game.category === selection.category &&
      game.sessionType === selection.sessionType &&
      game.theme === selection.theme &&
      game.playTime === selection.playTime,
  );

  if (exactMatch) {
    return exactMatch;
  }

  const scoredMatches = gameLibrary
    .map((game) => ({
      game,
      score:
        Number(game.category === selection.category) +
        Number(game.sessionType === selection.sessionType) +
        Number(game.theme === selection.theme) +
        Number(game.playTime === selection.playTime),
    }))
    .sort((a, b) => b.score - a.score);

  return scoredMatches[0]?.game ?? fallbackGame;
}
