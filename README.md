h1. Tarefa

h3. Gerenciador Financeiro

------------------------------------------------------------------------------------

* A Proposta é criar um pequeno gerenciador financeiro, que rode em dispositivos móveis, onde possa ser possível registrar os gastos e associar a uma categoria.
* Posteriormente, pode ser feito um acompanhamento da previsao de gastos de uma categoria e o que foi efetivamente registrado.

* Para isso o é necessário um registro das categorias, com os campos:
** ID
** Nome

* E uma tabela de lancamentos dos gastos:
** ID
** Emissao (data do gasto com data e hora)
** Valor
** Observacao
** Categoria

* Apresentar um menu lateral onde o usuario possa acessar os lancamentos e categorias, e demais opcoes que o sistema necessitar

* Na tela inicial, oferecer uma opcao para lancar um novo gasto de forma simples, sem ter que acessar menus e botoes.

* Na opcao de categorias, apresentar uma listagem, onde possa ser possivel ter um CRUD completo (Create, Read, Update, Delete)
* O mesmo na opcao de lancamentos, uma listagem com CRUD, com opcao de aplicar filtros. Inicialmente o filtro traz os lancamentos dos ultimos 10 dias, com a opcao de redefinir o periodo e de filtrar por categoria e observacao.
* No final da listagem, apresentar a quantidade de registros e o valor total dos lancamentos
* Opcao de exportar os lancamentos selecionados no formato CSV:

| data | valor | observacao | categoria |

* Mais um menu de consultas, ainda a ser melhor detalhado, mas que inicialmente permita ver os gastos de um determinado periodo totalizados por categoria.
* Se possivel, com a presença de um grafico no formato pizza

* O passo seguinte é ter a possibilidade de fazer uma previsao de gastos em um determinado periodo.
* Onde o usuario seleciona um mes e ano, e o sistema permite definir um orcamento para cada categoria.

* Em uma tela de consulta, o usuario seleciona o mes desejado, e o sistema apresenta a categoria, o valor previsto e o valor real de cada categoria.
* Se possivel, apresentando um grafico de barras onde para cada categoria teria uma barra com o previsto e uma com o realizado
