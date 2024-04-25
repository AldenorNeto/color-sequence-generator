require 'json'
require 'fileutils'

# Constantes
TAMANHO_ARRAY = 100
NUM_INTERACOES = 30
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

# Função para calcular o próximo valor de acordo com as regras especificadas
def proximo_valor(valor_atual, valor_anterior, color_palette)
  indice_atual = color_palette.index(valor_atual)
  indice_anterior = color_palette.index(valor_anterior)
  incremento = rand(-2..2)
  novo_indice = indice_atual

  # Chance de atualizar o próximo valor
  if rand(2) == 1
    novo_indice = rand(2) == 1 ? indice_anterior : (indice_atual + indice_anterior) / 2
  end

  # Garante que o índice esteja dentro dos limites da paleta
  novo_indice = [0, [VALOR_MAXIMO, novo_indice].min].max

  return color_palette[novo_indice]
end

# Função para gerar os arrays
def gerar_arrays
  array_inicial = Array.new(TAMANHO_ARRAY) { COLOR_PALETTE[rand(COLOR_PALETTE.size)] }
  arrays_gerados = []

  NUM_INTERACOES.times do
    novo_array = []
    array = array_inicial.dup

    array.each_with_index do |valor_atual, i|
      valor_anterior = i > 0 ? array[i - 1] : array_inicial[i]
      novo_array << proximo_valor(valor_atual, valor_anterior, COLOR_PALETTE)
    end

    arrays_gerados << novo_array
  end

  return arrays_gerados
end

# Função para salvar os arrays em um arquivo JSON
def salvar_arrays_json(arrays)
  base_name = File.basename(__FILE__, File.extname(__FILE__))
  json_file_path = "../FixedsSequences/#{base_name}.json"

  FileUtils.mkdir_p(File.dirname(json_file_path))
  
  File.write(json_file_path, JSON.pretty_generate(arrays))
end

# Geração do array de cores
begin
  salvar_arrays_json(gerar_arrays)
  puts "Os arrays foram gerados e salvos com sucesso."
rescue => e
  puts "Ocorreu um erro: #{e.message}"
end
