TAMANHO_ARRAY = 100
NUM_INTERACOES = 30

# Paleta de cores
COLOR_PALETTE = [
  "#070707", "#1f0707", "#2f0f07", "#470f07", "#571707",
  "#671f07", "#771f07", "#8f2707", "#9f2f07", "#af3f07",
  "#bf4707", "#c74707", "#df4f07", "#df5707","#d75f07", 
  "#d7670f", "#cf6f0f", "#cf770f", "#cf7f0f", "#cf8717", 
  "#c78717", "#c78f17", "#c7971f", "#bf9f1f", "#bfa727", 
  "#bfaf2f", "#b7af2f", "#b7b72f", "#b7b737", "#cfcf6f", 
  "#dfdf9f", "#efefc7", "#ffffff"
]
VALOR_MAXIMO = COLOR_PALETTE.size - 1

# Inicializa o array com valores aleatórios da paleta de cores
array_inicial = Array.new(TAMANHO_ARRAY) { COLOR_PALETTE[rand(COLOR_PALETTE.size)] }

# Função para calcular o próximo valor (cor) de acordo com as regras especificadas
def proximo_valor(valor_atual, valor_anterior, color_palette)
  indice_atual = color_palette.index(valor_atual)
  indice_anterior = color_palette.index(valor_anterior)
  incremento = rand(-2..2)
  novo_indice = indice_atual + incremento

  # Chance de atualizar o próximo valor
  if rand(2) == 1
    novo_indice = rand(2) == 1 ? indice_anterior : (indice_atual + indice_anterior) / 2
  end

  # Garante que o índice esteja dentro dos limites da paleta
  novo_indice = [0, [VALOR_MAXIMO, novo_indice].min].max

  return color_palette[novo_indice]
end

# Array para armazenar os arrays gerados
arrays_gerados = []

# Loop para gerar os arrays e armazená-los
NUM_INTERACOES.times do
  novo_array = []
  array = array_inicial.dup  # Copia o array inicial para não modificá-lo diretamente
  
  # Loop para atualizar cada posição do array
  array.each_with_index do |valor_atual, i|
    valor_anterior = i > 0 ? array[i - 1] : array_inicial[i]  # Valor anterior, se disponível
    novo_array << proximo_valor(valor_atual, valor_anterior, COLOR_PALETTE)
  end
  
  arrays_gerados << novo_array 
end

# Para escrever os arrays em um arquivo JSON, você pode usar a biblioteca JSON do Ruby
require 'json'
require 'fileutils'

# Pega o nome base do arquivo Ruby atual sem a extensão
base_name = File.basename(__FILE__, File.extname(__FILE__))

# Define o caminho do arquivo JSON com o mesmo nome base do arquivo Ruby
json_file_path = "../FixedsSequences/#{base_name}.json"

# Garanta que o diretório exista, criando-o se necessário
FileUtils.mkdir_p(File.dirname(json_file_path))
# Abre o arquivo para escrita e grava os dados em formato JSON
File.write(json_file_path, JSON.pretty_generate(arrays_gerados))
