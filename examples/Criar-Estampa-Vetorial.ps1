$ErrorActionPreference='Stop'
$out=Join-Path $PSScriptRoot 'output-estampa'
New-Item -ItemType Directory -Force $out | Out-Null
if(Test-Path (Join-Path $out 'Meu-Pai-Rabiscado-20x20.cdr')){throw 'Arquivo existente. Preserve a arte anterior antes de executar novamente.'}
Add-Type -AssemblyName System.Drawing
$inv=[Globalization.CultureInfo]::InvariantCulture
function N($v){([double]$v).ToString('0.###',$inv)}
$svg=[Text.StringBuilder]::new();[void]$svg.Append('<svg xmlns="http://www.w3.org/2000/svg" width="200mm" height="200mm" viewBox="0 0 200 200"><rect width="200" height="200" fill="white"/>')
function Glyph($letter,$font,$x,$y,$w,$h){$p=[Drawing.Drawing2D.GraphicsPath]::new();$p.AddString($letter,[Drawing.FontFamily]::new($font),0,100,[Drawing.PointF]::new(0,0),[Drawing.StringFormat]::GenericDefault);$b=$p.GetBounds();$m=[Drawing.Drawing2D.Matrix]::new();$m.Translate(-$b.X,-$b.Y);$p.Transform($m);$m.Dispose();$m=[Drawing.Drawing2D.Matrix]::new();$m.Scale(($w/$b.Width),($h/$b.Height));$p.Transform($m);$m.Dispose();$m=[Drawing.Drawing2D.Matrix]::new();$m.Translate($x,$y);$p.Transform($m);$m.Dispose();return ,$p}
$rng=[Random]::new(773)
$chars='OAEHJRWPXBDYKNST'
for($row=0;$row -lt 8;$row++){for($col=0;$col -lt 9;$col++){$h=$rng.Next(10,27);$w=$h*.72;$x=[Math]::Min(200-$w,[Math]::Max(0,$col*23+$rng.Next(-7,6)));$y=[Math]::Min(200-$h,[Math]::Max(0,$row*26+$rng.Next(-5,6)));$p=Glyph ([string]$chars[$rng.Next($chars.Length)]) 'Times New Roman' $x $y $w $h;$p.Flatten();$data=[Text.StringBuilder]::new();$pts=$p.PathPoints;$types=$p.PathTypes;for($i=0;$i -lt $pts.Length;$i++){if(($types[$i] -band 7) -eq 0){$c='M'}else{$c='L'};[void]$data.Append($c+(N $pts[$i].X)+' '+(N $pts[$i].Y));if($types[$i] -band 128){[void]$data.Append('Z')}};[void]$svg.Append('<path fill="#d5d5d3" fill-rule="evenodd" transform="rotate('+($rng.Next(-25,26))+' '+(N ($x+$w/2))+' '+(N ($y+$h/2))+')" d="'+$data+'"/>');$p.Dispose()}}
$letters=@(@('G',16,29,43,42,'#507ab8'),@('o',60,42,29,29,'#ea3f35'),@('o',89,42,29,29,'#fabc0c'),@('g',118,42,29,42,'#507ab8'),@('l',147,29,9,40,'#489f53'),@('e',156,42,29,29,'#ea3f35'))
foreach($v in $letters){$p=Glyph $v[0] 'Arial' $v[1] $v[2] $v[3] $v[4];$x=[double]$v[1];$y=[double]$v[2];$w=[double]$v[3];$h=[double]$v[4];[void]$svg.Append('<g stroke="'+$v[5]+'" stroke-width="0.55" stroke-linecap="round" fill="none">');for($d=$x-$h-2;$d -lt $x+$w+2;$d+=.78){$start=$null;$end=$null;for($t=0;$t -le $h;$t+=.16){$px=$d+$t*1.25;$py=$y+$h-$t;if($p.IsVisible([single]$px,[single]$py)){if($null -eq $start){$start=@($px,$py)};$end=@($px,$py)}elseif($null -ne $start){[void]$svg.Append('<path d="M'+(N $start[0])+' '+(N $start[1])+'L'+(N $end[0])+' '+(N $end[1])+'"/>');$start=$null}};if($null -ne $start){[void]$svg.Append('<path d="M'+(N $start[0])+' '+(N $start[1])+'L'+(N $end[0])+' '+(N $end[1])+'"/>')}};[void]$svg.Append('</g>');$p.Dispose()}
[void]$svg.Append('</svg>');$file=Join-Path $out 'fundo-google-rabiscado.svg';[IO.File]::WriteAllText($file,$svg.ToString())
$app=New-Object -ComObject CorelDRAW.Application.27
$doc=$app.CreateDocument();$doc.Unit=3;$doc.ActivePage.SetSize(200,200);$app.Optimization=$true
try {
$layer=$doc.ActiveLayer;$layer.Name='01 - Fundo e Google em riscos vetoriais'
$f=$layer.ImportEx($file,0,$app.CreateStructImportOptions());$f.Finish()
$range=$layer.Shapes.All();if($range.Count -gt 1){$s=$range.Group()}else{$s=$range.Item(1)};$s.SetSize(200,200);$s.LeftX=[double]0;$s.TopY=[double]200
$layer=$doc.ActivePage.CreateLayer('02 - Frase editavel')
function Txt($t,$x,$top,$w,$h,$c,$angle){$s=$layer.CreateArtisticText(0,0,$t,0,0,'Luckiest Guy',20);$s.Fill.ApplyUniformFill($app.CreateRGBColor($c[0],$c[1],$c[2]));$s.Outline.SetNoOutline();$s.SetSize($w,$h);$s.RotationAngle=[double]$angle;$s.LeftX=[double]$x;$s.TopY=[double]$top;return $s}
$black=@(25,26,24);$blue=@(80,122,184);$red=@(234,63,53);$yellow=@(250,188,12)
$null=Txt 'PRA QUE?' 29 125 81 14 $black -2
$null=Txt 'MEU' 24 100 61 26 $black 4
$null=Txt 'P' 90 105 35 45 $blue -3
$null=Txt 'A' 122 105 37 45 $yellow 4
$null=Txt 'I' 162 105 12 45 $red -2
$null=Txt 'SABE TUDO!' 20 58 157 24 $black -2
foreach($v in @(@(122,113,$red),@(145,113,$yellow),@(168,113,$blue),@(32,65,$red),@(55,65,$yellow),@(78,65,$blue))){$s=$layer.CreateEllipse2($v[0],$v[1],3.1,3.1);$s.Fill.ApplyUniformFill($app.CreateRGBColor($v[2][0],$v[2][1],$v[2][2]));$s.Outline.SetNoOutline()}
$doc.ClearSelection();$doc.SaveAs((Join-Path $out 'Meu-Pai-Rabiscado-20x20.cdr'),$app.CreateStructSaveAsOptions());$doc.PublishToPDF((Join-Path $out 'Meu-Pai-Rabiscado-Prova.pdf'))
}finally{$app.Optimization=$false;$app.Refresh()}
$doc.ActiveWindow.ActiveView.ToFitPage()

