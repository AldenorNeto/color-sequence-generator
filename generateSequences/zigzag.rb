require 'json'
require 'fileutils'

# Constantes
TAMANHO_ARRAY = 100
NUM_INTERACOES = 200
COLOR_PALETTE = 
[
  "#00ffeb",
  "#01ebe6",
  "#02d6e0",
  "#0594cd",
  "#0766c1",
  "#092eb1",
  "#09199b",
  "#070e7e",
  "#05095f",
  "#040443",
  "#020223",
  "#000000"
]

VALOR_MAXIMO = COLOR_PALETTE.size - 1

def intera(index)
  alvo = 0
  if index < 100
    alvo = index
  else 
    alvo = 200 - index
  end

  alvo
end

# Função para gerar os arrays
def gerar_arrays
  length = COLOR_PALETTE.size - 1

  array_inicial = Array.new(TAMANHO_ARRAY, length)

  arrays_gerados = []

  NUM_INTERACOES.times do | index |
    # array = arrays_gerados.size > 0 ? arrays_gerados[index - 1] : array_inicial.dup
    reference = intera(index)
    
    construtc = array_inicial.dup

    (-length..length).each do |i|
      result = reference + i
      if result > construtc.size - 1 || result < 0
        
      else
        construtc[result] = i.abs
      end
    end
    
    arrays_gerados << construtc.map {|const|  COLOR_PALETTE[const]}
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
