$files = @("index.html", "men.html", "women.html", "kids.html", "children.html", "traditional.html")
$imageDir = "assets\images"
if (-not (Test-Path -Path $imageDir)) {
    New-Item -ItemType Directory -Path $imageDir | Out-Null
}

$regex = '<img[^>]+src="([^"]+)"[^>]*alt="([^"]*)"'

foreach ($file in $files) {
    if (-not (Test-Path -Path $file)) { continue }
    
    $content = Get-Content -Path $file -Raw
    $matches = [regex]::Matches($content, $regex)
    
    foreach ($match in $matches) {
        $src = $match.Groups[1].Value
        $alt = $match.Groups[2].Value
        
        if ($src -match "unsplash.com" -or $src -match "mixkit.co") {
            # Make a safe filename
            $safeName = $alt -replace '[^a-zA-Z0-9]', '_'
            if ([string]::IsNullOrWhiteSpace($safeName)) {
                $safeName = "image"
            }
            $safeName = $safeName.ToLower()
            $fileName = "$safeName.jpg"
            if ($src -match "mixkit.co") {
                $fileName = "$safeName.mp4"
            }
            $localPath = "assets/images/$fileName"
            $fullLocalPath = Join-Path -Path $imageDir -ChildPath $fileName
            
            if (-not (Test-Path -Path $fullLocalPath)) {
                Write-Host "Downloading $src to $fullLocalPath"
                try {
                    Invoke-WebRequest -Uri $src -OutFile $fullLocalPath -UseBasicParsing
                } catch {
                    Write-Host "Failed to download $src"
                    continue
                }
            }
            
            $content = $content.Replace($src, $localPath)
        }
    }
    
    Set-Content -Path $file -Value $content
}
Write-Host "Done!"
