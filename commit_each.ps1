$items = Get-ChildItem -Recurse -File | Where-Object {
    $_.FullName -notmatch '\\(node_modules|\.next|\.data|\.git)\\' -and
    $_.Name -ne '.env.local' -and
    $_.Name -ne 'next-env.d.ts'
}

Write-Host "Total files to commit: $($items.Count)"

foreach ($item in $items) {
    $relPath = Resolve-Path -Relative $item.FullName
    $cleanPath = $relPath.Replace('.\', '')
    git add $cleanPath
    $msg = "Add $cleanPath"
    git commit -m $msg
}

Write-Host "All commits completed successfully."
