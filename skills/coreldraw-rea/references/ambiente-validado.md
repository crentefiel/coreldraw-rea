# Ambiente e receitas verificadas

Baseline local: Windows, CorelDRAW 2026 27.0.0.121 e REA 6.5.0. Confirme os caminhos no computador atual antes de usar.

- REA deste projeto: `runtime/node_modules/.bin/rea.cmd`.
- CorelDRAW normalmente em `C:\Program Files\Corel\CorelDRAW Graphics Suite\27\Programs64\CorelDRW.exe`.
- Biblioteca: `Programs64/Assemblies/Corel.Interop.VGCore.dll`.
- SHA-256 da biblioteca investigada: `f0dd4083d185263b6cdf3e0dc19c161522ef229e128af18480cd50f6b759333f`.
- Receitas de código: `examples/Criar-Cartao.ps1` e `examples/Criar-Estampa-Vetorial.ps1` na raiz deste repositório.

Exemplo de investigação (substitua o caminho pela biblioteca instalada e salve o resultado em arquivo):

```powershell
rea inspect-managed-members CAMINHO_DA_BIBLIOTECA --type Corel.Interop.VGCore.IVGApplication --type Corel.Interop.VGCore.IVGDocument --type Corel.Interop.VGCore.IVGLayer --type Corel.Interop.VGCore.IVGShape --format json
```

Subconjunto executado localmente: CreateDocument, Unit=3 para milímetros, ActivePage.SetSize, AddPages, CreateArtisticText, CreateRectangle2, CreateCMYKColor/CreateRGBColor, ApplyUniformFill, SetNoOutline, ImportEx/Finish e exportação. Para SaveAs em PowerShell, passe opções explícitas:

```powershell
$options = $app.CreateStructSaveAsOptions()
$doc.SaveAs($caminhoNovo, $options)
$doc.PublishToPDF($caminhoPdf)
```

Use novos caminhos de saída e confira FullFileName após salvar. Para importação, obtenha os objetos da camada de destino ou SelectionRange do documento; não suponha que ActiveSelectionRange exista no documento. Capture o documento retornado e não dependa de ActiveDocument durante operações longas. Otimização deve ser restaurada em finally.

O exemplo rabiscado constrói contornos com System.Drawing e traços SVG vetoriais; a frase continua texto editável. Esse fluxo teve resultado visual conferido. As tentativas abandonadas de interseção/recorte e rotação não estão incluídas. Métodos novos exigem investigação e teste próprios.
