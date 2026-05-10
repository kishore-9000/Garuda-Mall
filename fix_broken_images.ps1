$files = @("index.html", "men.html", "women.html", "kids.html", "children.html", "traditional.html")
$regex = '<img[^>]+src="https://images\.unsplash\.com/[^"]+"[^>]*alt="([^"]+)"[^>]*>'

foreach ($file in $files) {
    if (-not (Test-Path -Path $file)) { continue }
    
    $content = Get-Content -Path $file -Raw
    $matches = [regex]::Matches($content, $regex)
    
    foreach ($match in $matches) {
        $fullMatch = $match.Groups[0].Value
        $altText = $match.Groups[1].Value
        
        # Replace spaces with plus for URL
        $encodedAlt = $altText -replace ' ', '+'
        
        # Generate placeholder URL
        $newSrc = "https://placehold.co/600x400/222/d4af37?text=$encodedAlt"
        
        # Reconstruct the img tag to keep onerror
        $newImgTag = "<img onerror=`"handleImageError(this)`" src=`"$newSrc`" alt=`"$altText`">"
        
        $content = $content.Replace($fullMatch, $newImgTag)
    }
    
    Set-Content -Path $file -Value $content
}
Write-Host "Done!"
