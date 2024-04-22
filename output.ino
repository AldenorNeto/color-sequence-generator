#include <FastLED.h>

// Defina o número total de LEDs que você está usando
#define NUM_LEDS 38
#define LED_PIN     7

CRGB leds[NUM_LEDS];

// Função para converter valores hexadecimais em objetos CRGB
CRGB hexParaCRGB(uint32_t corHex) {
  // Extrair os valores RGB do código hexadecimal
  uint8_t r = (corHex >> 16) & 0xFF;
  uint8_t g = (corHex >> 8) & 0xFF;
  uint8_t b = corHex & 0xFF;

  // Retornar o objeto CRGB correspondente
  return CRGB(r, g, b);
}

// Função para preencher os LEDs com as cores fornecidas em um array de hexadecimal
void preencherLEDsHex(CRGB leds[], const uint32_t cores[], const int valores[], int tamanho) {
  for (int i = 0; i < min(tamanho, NUM_LEDS); i++) {
    leds[i] = hexParaCRGB(cores[valores[i]]);
  }
}

int* gerarValoresAleatorios(int tamanho) {
  int* array = new int[tamanho]; // Aloca dinamicamente o array
  for (int i = 0; i < tamanho; i++) {
    array[i] = random(1, 11); // Gera valores aleatórios entre 1 e 10
  }

  return array;
}

// Função para calcular o próximo valor de acordo com as regras especificadas
int proximo_valor(int valor_atual, int valor_anterior) {
  int incremento = random(-2, 3); // Random de -2 a 2

  int novo_valor = valor_atual + incremento;

  if (random(2) == 1) {
    novo_valor = random(2) == 1 ? valor_anterior : (valor_atual + valor_anterior) / 2;
  }

  novo_valor = constrain(novo_valor, 0, 10);

  return novo_valor;
}

void setup() {
  Serial.begin(9600);
  FastLED.addLeds<WS2812, LED_PIN, GRB>(leds, NUM_LEDS);
}

void imprimirArray(int* array, int tamanho) {
  Serial.println("Valores aleatórios gerados:");
  for (int i = 0; i < tamanho; i++) {
    Serial.print(array[i]);
    Serial.print(" ");
  }
  Serial.println();
}

void loop() {
    // Inicializa o array com 10 valores zeros
  int arrayInicial[NUM_LEDS] = {0};

  // Array de cores em formato hexadecimal
  const uint32_t coresHex[] = {
    0x070707, 0x1f0707, 0x2f0f07, 0x470f07, 0x571707, 0x671f07, 0x771f07,
    0x8f2707, 0x9f2f07, 0xaf3f07, 0xbf4707, 0xc74707, 0xdf4f07, 0xdf5707,
    0xdf5707, 0xd75f07, 0xd75f07, 0xd7670f, 0xcf6f0f, 0xcf770f, 0xcf7f0f,
    0xcf8717, 0xc78717, 0xc78f17, 0xc7971f, 0xbf9f1f, 0xbf9f1f, 0xbfa727,
    0xbfa727, 0xbfaf2f, 0xb7af2f, 0xb7b72f, 0xb7b737, 0xcfcf6f, 0xdfdf9f,
    0xefefc7, 0xffffff, 
  };


  for (;;) {
    int novo_array[NUM_LEDS];
    for (int i = 0; i < NUM_LEDS; i++) {
      int valor_anterior = (i > 0) ? arrayInicial[i - 1] : 0; // Valor anterior, se disponível
      novo_array[i] = proximo_valor(arrayInicial[i], valor_anterior);
    }

    // Atualiza o arrayInicial com os novos valores calculados
    for (int i = 0; i < NUM_LEDS; i++) {
      arrayInicial[i] = novo_array[i];
    }

    imprimirArray(novo_array, NUM_LEDS);
    // Chame a função para preencher os LEDs com as cores fornecidas em formato hexadecimal
    preencherLEDsHex(leds, coresHex, novo_array, NUM_LEDS);

    // Exibe os LEDs
    FastLED.show();
    delay(500);

    delete[] novo_array;
  }
}
