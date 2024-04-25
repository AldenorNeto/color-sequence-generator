array_exemplo = [
  { nome: "Alice", idade: 30 },
  { nome: "Bob", idade: 25 },
  { nome: "Carol", idade: 35 },
  { nome: "David", idade: 28 },
  { nome: "Eva", idade: 32 },
  { nome: "Frank", idade: 40 },
  { nome: "Grace", idade: 22 },
  { nome: "Helen", idade: 38 },
  { nome: "Ivan", idade: 27 },
  { nome: "Julia", idade: 33 }
]

trataArray = array_exemplo.map do |pessoa|
  { nome: pessoa[:nome], idade: pessoa[:idade] * 2 }
end

puts trataArray.map { |pessoa| pessoa[:idade] }
