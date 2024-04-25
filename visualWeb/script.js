const fileName = "zigzag";

async function carregarDados() {
  try {
    const resposta = await fetch(`../FixedsSequences/${fileName}.json`);
    const indices = await resposta.json();

    function criarDivComDivsFilhasComPadding(sequenciaCores, indice) {
      const divPai = document.getElementById("main");
      divPai.innerHTML = "";
      divPai.style.border = "1px solid black";
      divPai.style.display = "flex";

      sequenciaCores.forEach((cor) => {
        const divFilha = document.createElement("div");
        divFilha.style.padding = "30px 10px";
        divFilha.style.width = "0";
        divFilha.style.height = "0";
        divFilha.style.background = cor;
        divPai.appendChild(divFilha);
      });

      document.body.appendChild(divPai);
    }

    function main(indice) {
      if (indice >= indices.length) {
        indice = 0;
      }

      criarDivComDivsFilhasComPadding(indices[indice], indice);

      setTimeout(() => main(indice + 1), 100);
    }

    main(0);
  } catch (erro) {
    console.error("Falha ao carregar o arquivo JSON", erro);
  }
}

function startUp() {
  const divElement = document.createElement("div");
  divElement.id = "main";
  document.body.appendChild(divElement);
  document.body.style.backgroundColor = "black";
}

startUp();
carregarDados();
