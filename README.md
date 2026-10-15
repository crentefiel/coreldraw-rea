# CorelDRAW + REA

Skill para criar e reconstruir artes editáveis no CorelDRAW usando agentes, REA para investigar métodos e automação COM para executar a criação.

Este é um projeto de integração independente. O REA original é desenvolvido em [morluto/rea](https://github.com/morluto/rea); seu código não é redistribuído aqui. CorelDRAW é software proprietário e exige instalação e licença próprias.

## Requisitos

- Windows e CorelDRAW com automação COM (exemplos testados na versão 2026, 27.0.0.121).
- Node.js compatível com a versão do REA escolhida e npm no PATH.
- Um agente com execução local; geração de imagens exige ferramenta própria do agente.

## Instalação

No PowerShell, na pasta deste projeto:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\Instalar.ps1
```

O instalador copia a skill para `CODEX_HOME/skills/coreldraw-rea` (ou `~/.codex/skills/coreldraw-rea`) e instala `rea-agents@6.5.0` localmente em `runtime`. Preserva a primeira cópia anterior da skill em uma pasta de backup. Não instala CorelDRAW, Node.js, fontes ou motores de análise. Não registra MCP automaticamente.

Abra `Iniciar-REA.cmd` para o terminal. Para conectar um agente, execute `rea setup`, revise as alterações propostas e aprove apenas as desejadas. Reinicie o agente para carregar novas skills/conexões.

## Uso

Envie uma referência e peça:

> Use $coreldraw-rea para recriar esta arte em 20 × 20 cm, com textos editáveis, vetores e prova em PDF.

A skill orienta a pesquisar fontes semelhantes no Google Fonts, gerar fotografias novas quando necessário, construir curvas e conferir o resultado no CorelDRAW. Fonte identificada por aparência é uma aproximação até ser comprovada. Fotos continuam rasterizadas; colocar uma foto em CDR não é vetorização.

## Exemplos

- `examples/Criar-Cartao.ps1`: cartão fictício de advogado, frente e verso, 90 × 50 mm.
- `examples/Criar-Estampa-Vetorial.ps1`: estampa tipográfica quadrada de 200 × 200 mm; fundo e lettering rabiscado vetoriais, frase principal editável. Requer a fonte Luckiest Guy instalada pelo usuário; fonte disponível no [Google Fonts](https://fonts.google.com/specimen/Luckiest+Guy). O exemplo reconstrói lettering colorido aproximado; não é um logotipo oficial.

Execute os exemplos em PowerShell com o CorelDRAW disponível. Eles criam documentos novos e recusam sobrescrever o CDR de saída. A estampa usa System.Drawing do Windows. Saídas ficam em subpastas dos exemplos e não devem ser versionadas.

## Validação e limites

Os exemplos originais foram executados localmente via COM e conferidos visualmente no CorelDRAW 2026. As cópias publicadas tiveram caminhos de saída ajustados e validação sintática; não constituem um novo teste end-to-end em outro computador. Confira dimensões, fontes e aparência após executar.

As APIs investigadas pelo REA incluem criação de documentos, texto artístico, formas, cores, importação, conversão em curvas e exportação. Assinatura observada, execução real e conferência visual são evidências distintas. Não há promessa de conhecer todas as funções do CorelDRAW.

Os PDFs dos exemplos são provas sem sangria e não configuram fechamento de produção. Ajuste sangria, margens, fontes e perfil de cor conforme a gráfica. A skill não executa impressão ou publicação automaticamente.

## Conteúdo e créditos

Inclui apenas instruções e código da integração. Não inclui programas proprietários, arquivos de clientes, referências recebidas, fontes de terceiros, dependências instaladas ou testes abandonados. Respeite direitos de marcas e materiais utilizados em suas próprias artes.
