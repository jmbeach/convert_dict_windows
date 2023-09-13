[string]$correctOutput = ./out/convert_dict.exe

New-Item -ItemType Directory -Force ./tmp
$dontDelete = @('convert_dict.exe', 'icudtl.dat')

Get-ChildItem ./out | ForEach-Object {
  $file = $_
  if ($file.Name -in $dontDelete) {
    return
  }

  Move-Item $file ./tmp
  [string]$output = ./out/convert_dict.exe
  if ($output -ne $correctOutput) {
    Move-Item "./tmp/$($file.Name)" ./out
  }
}

Remove-Item -Recurse -Force ./tmp