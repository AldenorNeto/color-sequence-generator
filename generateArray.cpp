void setup() {
  Serial.begin(9600);
}

void loop() {
  // Inicializa o arrayInicial com 10 valores zeros
  int arrayInicial[10] = {0};

  for (;;) {
    // Atualiza cada posição do arrayInicial de acordo com as regras especificadas
    int novo_array[10];
    for (int i = 0; i < 10; i++) {
      int valor_anterior = (i > 0) ? arrayInicial[i - 1] : 0; // Valor anterior, se disponível
      novo_array[i] = proximo_valor(arrayInicial[i], valor_anterior);
    }

    // Atualiza o arrayInicial com os novos valores calculados
    for (int i = 0; i < 10; i++) {
      arrayInicial[i] = novo_array[i];
    }

    // Aguarda 1 segundo antes de continuar para o próximo ciclo
    delay(1000);
  }
}
