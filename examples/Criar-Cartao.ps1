$ErrorActionPreference = 'Stop'
$out = Join-Path $PSScriptRoot 'cartao-advogado'
New-Item -ItemType Directory -Force $out | Out-Null
if (Test-Path (Join-Path $out 'Cartao-Advogado.cdr')) { throw 'O CDR ja existe. Use outra pasta para preservar a arte.' }
$app = New-Object -ComObject CorelDRAW.Application.27
$doc = $app.CreateDocument()
$doc.Unit = 3 # cdrMillimeter
$doc.ActivePage.SetSize(90,50)
$navy = $app.CreateCMYKColor(95,75,45,60)
$gold = $app.CreateCMYKColor(20,30,65,10)
$paper = $app.CreateCMYKColor(2,2,5,0)
$ink = $app.CreateCMYKColor(70,55,40,60)
function Box($layer,$x,$y,$w,$h,$color) {
    $s = $layer.CreateRectangle2($x,$y,$w,$h)
    $s.Fill.ApplyUniformFill($color)
    $s.Outline.SetNoOutline()
    return $s
}
function Txt($layer,$x,$y,$text,$font,$size,$color) {
    $s = $layer.CreateArtisticText($x,$y,$text,0,0,$font,$size)
    $s.Fill.ApplyUniformFill($color)
    $s.Outline.SetNoOutline()
    return $s
}
$layer = $doc.ActiveLayer
$layer.Name = 'Frente - textos editaveis'
$null = Box $layer 0 0 90 50 $navy
$null = Box $layer 7 8 0.35 34 $gold
$null = Txt $layer 12 31 'RAFAEL' 'Georgia' 22 $paper
$null = Txt $layer 12 21 'ALMEIDA' 'Georgia' 22 $paper
$null = Txt $layer 12 12 'A D V O C A C I A' 'Arial' 7 $gold
$null = Txt $layer 65 8 'OAB/UF 000000' 'Arial' 5.5 $paper
$null = $doc.AddPages(1)
$doc.Pages.Item(2).Activate()
$doc.ActivePage.SetSize(90,50)
$layer = $doc.ActiveLayer
$layer.Name = 'Verso - contatos editaveis'
$null = Box $layer 0 0 90 50 $paper
$null = Box $layer 0 47.5 90 2.5 $navy
$null = Txt $layer 7 37 'Rafael Almeida' 'Georgia' 15 $ink
$null = Txt $layer 7 31 'ADVOGADO  |  OAB/UF 000000' 'Arial' 6 $ink
$null = Box $layer 7 26.5 15 0.35 $gold
$null = Txt $layer 7 20 '(00) 00000-0000' 'Arial' 8 $ink
$null = Txt $layer 7 14 'contato@exemplo.com' 'Arial' 8 $ink
$null = Txt $layer 7 7 'Endereco do escritorio - Cidade / UF' 'Arial' 6.5 $ink
$doc.Pages.Item(1).Activate()
$saveOptions = $app.CreateStructSaveAsOptions()
$doc.SaveAs((Join-Path $out 'Cartao-Advogado.cdr'),$saveOptions)
$doc.PublishToPDF((Join-Path $out 'Cartao-Advogado-Prova.pdf'))
$doc.ActiveWindow.ActiveView.ToFitPage()
[pscustomobject]@{ File=$doc.FullFileName; Pages=$doc.Pages.Count; Width=$doc.ActivePage.SizeWidth; Height=$doc.ActivePage.SizeHeight; FrontShapes=$doc.Pages.Item(1).Shapes.Count; BackShapes=$doc.Pages.Item(2).Shapes.Count } | ConvertTo-Json | Set-Content (Join-Path $out 'validacao.json')
