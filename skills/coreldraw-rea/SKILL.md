---
name: coreldraw-rea
description: Criar ou reconstruir artes editaveis no CorelDRAW a partir de briefing ou imagem, com imagens novas de qualidade, mascotes em vetor e REA para verificar funcoes de automacao. Use para criar esta arte no CorelDRAW usando REA, vetorizar uma referencia ou finalizar em CDR.
---

# Artes no CorelDRAW com REA

Entregue uma arte nativa editavel em CDR, com uma prova visual. REA investiga o aplicativo e suas bibliotecas; a automacao COM do CorelDRAW executa a criacao. Nao confunda catalogo de metodos com comportamento testado, nem prometa conhecer todas as funcoes do produto.

## Fluxo

1. Examine o briefing e a imagem de referencia. Obtenha tamanho final e dados essenciais ausentes. Para demonstracoes autorizadas, use dados ficticios identificados. Reconstrua textos e geometria em objetos editaveis. Para imagens novas, mascotes e qualidade de impressao, siga as regras abaixo. Informe fontes substituidas e aproximacoes.
2. Verifique o executavel, a versao instalada e as bibliotecas de automacao existentes. Leia [ambiente-validado.md](references/ambiente-validado.md) para os caminhos e a base ja testada. Confirme novamente fatos que possam ter mudado.
3. Use REA para inspecionar os membros gerenciados relevantes de `Corel.Interop.VGCore.dll`. Se a mesma biblioteca ainda tiver o SHA-256 registrado na evidencia anterior e os metodos necessarios ja estiverem documentados, reutilize essa evidencia. Investigue funcoes novas de forma focada. Leia a skill reverse-engineer-anything disponivel quando precisar de outras rotas REA. Use o CLI instalado quando nao houver ferramentas MCP na sessao; nao altere a configuracao do agente para executar um trabalho que o CLI resolve.
4. Planeje paginas, camadas, tamanhos, hierarquia tipografica, cores e elementos. Crie documento novo com COM; preserve documentos abertos do usuario. Trabalhe em pasta de saida explicita e nao sobrescreva arte existente sem autorizacao. Mantenha o objeto retornado por CreateDocument em vez de depender continuamente de ActiveDocument.
5. Aplique os recursos identificados e verifique o resultado real. Consulte assinaturas e valores opcionais da biblioteca local para metodos desconhecidos. Nao instale motores de engenharia reversa ou altere o CorelDRAW para uma operacao disponivel na API de automacao.
6. Salve CDR e uma prova em PDF ou imagem. Confira dimensoes, paginas, objetos e textos; inspecione visualmente frente e verso ou todas as paginas relevantes. Para controlar a interface, siga a skill computer-use disponivel. Uma execucao sem erro nao substitui a conferencia visual.
7. Entregue links absolutos para CDR e prova. Resuma o que ficou editavel, aproximacoes e o que foi realmente validado. So chame de pronto para impressao depois de verificar tamanho, sangria, margens, fontes e requisitos de cor/exportacao da grafica. Nao imprima nem publique sem pedido.

## Fontes semelhantes pelo Google Fonts

Ao reconstruir uma referencia, analise peso, largura, contraste, inclinacao, terminais, altura-x e desenho de letras distintivas. Identificacao visual e uma hipotese: nao afirme fonte exata sem evidencia. Procure candidatas atuais no Google Fonts, compare o mesmo texto da arte e prefira a mais proxima em vez de usar Arial Black como substituicao automatica. Se a melhor opcao for clara, prossiga; mostre alternativas quando houver diferenca relevante ou preferencia do usuario pendente.

Use apenas arquivos obtidos do catalogo oficial `https://fonts.google.com` ou do repositorio oficial `https://github.com/google/fonts`. Verifique familia, peso, estilo, suporte a portugues e licenca especifica. Para desktop, baixe TTF/OTF, preferindo versoes estaticas quando disponiveis; CSS/WOFF2 de web nao substituem uma instalacao desktop. Se so houver fonte variavel, teste seu reconhecimento e peso no CorelDRAW antes de adota-la.

Quando autorizado pelo usuario, pesquise, baixe e instale as fontes semelhantes selecionadas para o usuario atual do Windows e aplique-as no CorelDRAW. Preserve autorizacoes ja dadas na sessao. Esse escopo nao inclui comprar fontes, substituir versoes existentes, remover fontes ou instalar para todos os usuarios. Reutilize instalacoes equivalentes; se houver conflito de nomes/versoes, preserve a existente e resolva antes de substituir. Guarde o arquivo original, licenca, URL de origem, nome interno da familia, peso e hash numa subpasta `fontes` da arte.

Verifique que a fonte foi realmente registrada para o usuario e aparece no CorelDRAW: carregar uma fonte temporariamente em um processo nao comprova instalacao persistente. Se o aplicativo precisar reiniciar para atualizar o catalogo, preserve os documentos do usuario e informe a necessidade, sem fecha-los automaticamente. Aplique pelo nome interno da familia e estilo correto; confirme que nao houve substituicao silenciosa. Confira acentos, cedilha, numeros, pontuacao e quebras de linha visualmente. Ajuste tamanho e espacamento antes de deformar horizontalmente os caracteres.

Mantenha o CDR principal com textos editaveis. Quando necessario, entregue outra copia com textos em curvas, preservando o principal. Registre a fonte aplicada, sua origem e se a correspondencia e aproximada. Uma consulta REA confirma metodos de texto disponiveis, mas nao identifica por si so a fonte usada numa fotografia.

## Vetores e imagens

Uma imagem inserida no CDR nao equivale a uma arte vetorizada. Recrie curvas e formas quando viavel, mantenha texto editavel no arquivo principal e gere copia com textos em curvas apenas quando necessario. Confira contornos, vazados, proporcoes e detalhes contra a referencia. Nao prometa vetor perfeito para fotografias ou imagens sem detalhes suficientes.

## Imagens novas e mascotes

- Preferencia deste usuario: quando a referencia trouxer fotos pequenas ou recortes de apresentacao, crie imagens novas de boa qualidade para compor a arte, em vez de reutilizar esses recortes como resultado final. Preserve o original se o pedido exigir reproducao exata de produto, pessoa ou marca; esclareca a diferenca antes de inventar detalhes que mudem sua identidade.
- Use a skill imagegen disponivel para gerar fotos, alimentos, texturas ou outras imagens raster. Peça fundo transparente quando o elemento precisar de recorte. Copie o resultado selecionado para a pasta da arte e confira alpha, bordas, composicao e resolucao real antes de importar. Imagem gerada nao e automaticamente vetor nem prova fidelidade ao produto real.
- Calcule a resolucao efetiva no tamanho colocado: pixels / (milimetros / 25,4). Para fotos destinadas a impressao, busque 300 ppi, salvo especificacao diferente da grafica; nao apresente simples ampliacao como ganho de detalhe. Um raster de pagina inteira com 100 x 150 mm precisa de aproximadamente 1181 x 1772 pixels a 300 ppi, sem contar sangria.
- Para bonequinhos, mascotes, icones e ilustracoes simples solicitados em vetor, construa curvas fechadas, preenchimentos e contornos nativos ou importe SVG com caminhos reais e verifique a editabilidade no CorelDRAW. Uma imagem gerada pode servir de estudo visual, mas deve ser reconstruida em curvas para entregar vetor. Agrupe por partes e mantenha cores e formas acessiveis. Se precisar de tracado automatico, descubra a API efetivamente instalada pelo REA e confira o resultado; nao assuma que o recurso existe ou produza curvas limpas.
- Nao use PowerClip de bitmap como substituto silencioso de vetorizacao. Prefira fotos novas para conteudo fotografico e curvas para o mascote, mantendo os textos separados e editaveis.

## Reaproveitar funcoes verificadas

Use a evidencia e os scripts locais existentes para as operacoes conhecidas. Para uma funcao nova (curvas, preenchimento, contorno, importacao, agrupamento, recorte ou exportacao), consulte os membros exatos com REA e salve evidencia focada na pasta do trabalho. Leia apenas o subconjunto necessario; nao despeje o catalogo completo na conversa.

Diferencie tres estados ao registrar uma receita reutilizavel: assinatura observada pelo REA, execucao real confirmada por COM e resultado visual conferido. Registre versao/hash, parametros que funcionaram, caminho do exemplo e limitacoes. Antes de alterar esta skill ou suas referencias com novas receitas, obtenha pedido explicito de atualizacao; produzir uma arte nao autoriza por si so modificar permanentemente as instrucoes. Evidencia do trabalho pode ficar na propria pasta da arte.

Nao tente descobrir ou testar todas as funcoes do CorelDRAW a cada pedido. Amplie o conjunto verificado conforme a necessidade, sem executar comandos destrutivos ou alterar documentos do usuario para explorar a API. Quando a biblioteca mudar, revalide as receitas afetadas.

## Acionamento

Exemplos: "Crie esta arte no CorelDRAW usando REA, tamanho 9 x 5 cm"; "Recrie esta imagem em CDR editavel usando REA". A instrucao define um fluxo de trabalho; nao e um servico permanente nem garante acesso a ferramentas indisponiveis em outro computador.

