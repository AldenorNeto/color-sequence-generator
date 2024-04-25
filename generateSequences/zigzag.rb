require 'json'
require 'fileutils'

# Constantes
TAMANHO_ARRAY = 100
NUM_INTERACOES = 100
COLOR_PALETTE = [
  "#000000",
  "#00403b",
  "#007d73",
  "#00c4b5",
  "#00ffeb",
  "#01e3e1",
  "#03b9d3",
  "#0496c7",
  "#0578bc",
  "#065eb3",
  "#074ead",
  "#083ba7",
  "#0929a7",
  "#0a17a7",
  "#0b0ba7"
]

VALOR_MAXIMO = COLOR_PALETTE.size - 1

def proximo_valor(valor_atual, valor_anterior, color_palette)



  return color_palette[indice_anterior + 1]
end

# Função para gerar os arrays
def gerar_arrays
  array_inicial = Array.new(TAMANHO_ARRAY) { COLOR_PALETTE[0] }
  array_inicial[0] = COLOR_PALETTE[9]

  arrays_gerados = []

  NUM_INTERACOES.times do | index |
    array = arrays_gerados.size > 0 ? arrays_gerados[index - 1] : array_inicial.dup

    newarray = array.map.with_index do |numero, indice| 
      
      indiceAfter = indice >= array.size - 1 ? 0 : indice + 1

      array[indiceAfter]
    end

    arrays_gerados << newarray
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

# Execução do programa
begin
  salvar_arrays_json(gerar_arrays)
  puts "Os arrays foram gerados e salvos com sucesso."
rescue => e
  puts "Ocorreu um erro: #{e.message}"
end
