[string]$correctOutput = ./convert_dict.exe

New-Item -ItemType Directory -Force ./tmp
$dontDelete = @(
  'convert_dict.exe',
  'icudtl.dat',
  'msvcp140.dll',
  'README.md',
  'remove-unnecessary.ps1',
  'tmp',
  'ucrtbased.dll',
  'vcruntime140_1d.dll',
  'vcruntime140.dll',
  'vcruntime140d.dll'
)

Get-ChildItem . | ForEach-Object {
  $file = $_
  if ($file.Name -in $dontDelete) {
    return
  }

  Move-Item $file ./tmp
  [string]$output = ./convert_dict.exe
  if ($output -ne $correctOutput) {
    Move-Item "./tmp/$($file.Name)" ./
  }
}

Remove-Item -Recurse -Force ./tmp