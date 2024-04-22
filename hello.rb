TAMANHO_ARRAY = 3

# Função para calcular o próximo valor de acordo com as regras especificadas
def proximo_valor(valor_atual, valor_anterior)
  incremento = rand(-2..2)
  novo_valor = valor_atual + incremento

  # Chance de atualizar o próximo valor
  if rand(2) == 1
    novo_valor = rand(2) == 1 ? valor_anterior : (valor_atual + valor_anterior) / 2
  end

  # Garante que o valor esteja entre 0 e 10
  novo_valor = [0, [10, novo_valor].min].max

  return novo_valor
end

# Inicializa o array com TAMANHO_ARRAY valores zeros
array = [0] * TAMANHO_ARRAY

loop do
  # Exibe o array atual
  puts "#{array}"

  # Atualiza cada posição do array de acordo com as regras especificadas
  novo_array = array.map.with_index do |valor_atual, i|
    valor_anterior = i > 0 ? array[i - 1] : 0 # Valor anterior, se disponível
    proximo_valor(valor_atual, valor_anterior)
  end

  # Atualiza o array com os novos valores calculados
  array = novo_array

  # Aguarda 1 segundo antes de continuar para o próximo ciclo
  sleep(1)
end
