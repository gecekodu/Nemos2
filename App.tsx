import { StatusBar } from 'expo-status-bar';
import { useMemo, useState } from 'react';
import {
  Pressable,
  SafeAreaView,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import { generateGameConcept, SelectionState, steps } from './src/data/games';

type StepKey = (typeof steps)[number]['key'];

export default function App() {
  const [currentStepIndex, setCurrentStepIndex] = useState(0);
  const [selection, setSelection] = useState<SelectionState>({});

  const currentStep = steps[currentStepIndex];
  const isComplete = currentStepIndex >= steps.length;
  const generatedGame = useMemo(() => generateGameConcept(selection), [selection]);

  const handleSelect = (value: string) => {
    if (!currentStep) {
      return;
    }

    const key = currentStep.key as StepKey;
    setSelection((previous) => ({ ...previous, [key]: value }));
    setCurrentStepIndex((previous) => previous + 1);
  };

  const restartFlow = () => {
    setSelection({});
    setCurrentStepIndex(0);
  };

  return (
    <SafeAreaView style={styles.safeArea}>
      <StatusBar style="light" />
      <ScrollView contentContainerStyle={styles.container}>
        <View style={styles.heroCard}>
          <Text style={styles.badge}>Nemos Game Builder</Text>
          <Text style={styles.title}>HTML oyun fikirlerini mobil uygulamada ürünleştiren akış</Text>
          <Text style={styles.subtitle}>
            Kullanıcıya birkaç adımda seçim yaptır, ardından ona üretilmiş gibi hissettiren bir oyun konsepti sun.
          </Text>
          <View style={styles.roadmapRow}>
            <InfoPill label="20 hazır oyun" />
            <InfoPill label="Mobil odaklı" />
            <InfoPill label="Multiplayer uyumlu" />
          </View>
        </View>

        {!isComplete && currentStep ? (
          <View style={styles.sectionCard}>
            <Text style={styles.stepCount}>
              Adım {currentStepIndex + 1} / {steps.length}
            </Text>
            <Text style={styles.sectionTitle}>{currentStep.title}</Text>
            <Text style={styles.sectionDescription}>{currentStep.description}</Text>

            <View style={styles.optionList}>
              {currentStep.options.map((option) => (
                <Pressable
                  key={option}
                  onPress={() => handleSelect(option)}
                  style={({ pressed }) => [styles.optionButton, pressed && styles.optionButtonPressed]}
                >
                  <Text style={styles.optionText}>{option}</Text>
                  <Text style={styles.optionHint}>Seç ve devam et</Text>
                </Pressable>
              ))}
            </View>
          </View>
        ) : (
          <View style={styles.sectionCard}>
            <Text style={styles.stepCount}>Oyun sonucu hazır</Text>
            <Text style={styles.sectionTitle}>{generatedGame.title}</Text>
            <Text style={styles.sectionDescription}>{generatedGame.pitch}</Text>

            <View style={styles.previewCard}>
              <Text style={styles.previewTitle}>Oluşturulan oyun profili</Text>
              <Text style={styles.previewMeta}>
                {generatedGame.category} • {generatedGame.sessionType} • {generatedGame.theme} • {generatedGame.playTime}
              </Text>
              <Text style={styles.previewBody}>
                Bu alan bir sonraki aşamada WebView içinde HTML oyunun kendisini, kapak görselini ve onboarding metnini gösterecek.
              </Text>

              <Text style={styles.listTitle}>Önerilen mekanikler</Text>
              {generatedGame.mechanics.map((item) => (
                <Text key={item} style={styles.bulletItem}>
                  • {item}
                </Text>
              ))}

              <Text style={styles.listTitle}>Monetization / ürün notu</Text>
              <Text style={styles.previewBody}>{generatedGame.monetizationHint}</Text>
            </View>

            <Pressable onPress={restartFlow} style={styles.primaryButton}>
              <Text style={styles.primaryButtonText}>Yeni seçim akışı başlat</Text>
            </Pressable>
          </View>
        )}

        <View style={styles.sectionCard}>
          <Text style={styles.sectionTitle}>Bu kurulumla ne hazır?</Text>
          <View style={styles.checkList}>
            <ChecklistItem text="Kullanıcı seçim akışı ile konsept üretimi" />
            <ChecklistItem text="20 oyunluk başlangıç kütüphanesi" />
            <ChecklistItem text="Uzaktan çok oyunculu senaryolara uygun veri modeli" />
            <ChecklistItem text="Sonraki sprintte HTML/WebView entegrasyonuna uygun ekran yapısı" />
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

function InfoPill({ label }: { label: string }) {
  return (
    <View style={styles.infoPill}>
      <Text style={styles.infoPillText}>{label}</Text>
    </View>
  );
}

function ChecklistItem({ text }: { text: string }) {
  return (
    <View style={styles.checkItem}>
      <View style={styles.checkDot} />
      <Text style={styles.checkText}>{text}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#08101f',
  },
  container: {
    padding: 20,
    gap: 16,
  },
  heroCard: {
    backgroundColor: '#101a33',
    borderRadius: 24,
    padding: 20,
    gap: 12,
  },
  badge: {
    color: '#7dd3fc',
    fontSize: 13,
    fontWeight: '700',
    textTransform: 'uppercase',
    letterSpacing: 1,
  },
  title: {
    color: '#f8fafc',
    fontSize: 30,
    fontWeight: '800',
    lineHeight: 36,
  },
  subtitle: {
    color: '#cbd5e1',
    fontSize: 15,
    lineHeight: 22,
  },
  roadmapRow: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
    marginTop: 8,
  },
  infoPill: {
    borderRadius: 999,
    backgroundColor: '#162447',
    paddingHorizontal: 12,
    paddingVertical: 8,
  },
  infoPillText: {
    color: '#e0f2fe',
    fontWeight: '600',
  },
  sectionCard: {
    backgroundColor: '#0f172a',
    borderColor: '#1e293b',
    borderWidth: 1,
    borderRadius: 24,
    padding: 20,
    gap: 12,
  },
  stepCount: {
    color: '#94a3b8',
    fontSize: 13,
    fontWeight: '700',
    textTransform: 'uppercase',
  },
  sectionTitle: {
    color: '#f8fafc',
    fontSize: 24,
    fontWeight: '800',
  },
  sectionDescription: {
    color: '#cbd5e1',
    fontSize: 15,
    lineHeight: 22,
  },
  optionList: {
    gap: 12,
    marginTop: 8,
  },
  optionButton: {
    backgroundColor: '#172554',
    borderRadius: 18,
    padding: 16,
    borderWidth: 1,
    borderColor: '#2563eb',
    gap: 4,
  },
  optionButtonPressed: {
    opacity: 0.85,
    transform: [{ scale: 0.99 }],
  },
  optionText: {
    color: '#eff6ff',
    fontWeight: '700',
    fontSize: 17,
  },
  optionHint: {
    color: '#93c5fd',
    fontSize: 13,
  },
  previewCard: {
    backgroundColor: '#111827',
    borderRadius: 18,
    padding: 16,
    gap: 8,
  },
  previewTitle: {
    color: '#f8fafc',
    fontSize: 18,
    fontWeight: '700',
  },
  previewMeta: {
    color: '#67e8f9',
    fontSize: 13,
    fontWeight: '700',
  },
  previewBody: {
    color: '#dbeafe',
    fontSize: 14,
    lineHeight: 21,
  },
  listTitle: {
    color: '#e2e8f0',
    fontSize: 15,
    fontWeight: '700',
    marginTop: 8,
  },
  bulletItem: {
    color: '#cbd5e1',
    fontSize: 14,
    lineHeight: 20,
  },
  primaryButton: {
    backgroundColor: '#2563eb',
    borderRadius: 16,
    paddingVertical: 14,
    alignItems: 'center',
    marginTop: 8,
  },
  primaryButtonText: {
    color: '#eff6ff',
    fontSize: 15,
    fontWeight: '700',
  },
  checkList: {
    gap: 12,
  },
  checkItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
  },
  checkDot: {
    width: 10,
    height: 10,
    borderRadius: 999,
    backgroundColor: '#22c55e',
  },
  checkText: {
    color: '#dbeafe',
    flex: 1,
    lineHeight: 20,
  },
});
