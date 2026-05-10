$files = @("index.html", "men.html", "women.html", "kids.html", "children.html", "traditional.html")

$replacements = @{
    "https://placehold.co/600x400/222/d4af37?text=Sherwani" = "assets/images/ethnic.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Lehenga" = "assets/images/traditional_saree.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Kurta" = "assets/images/bandhgala.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Pattu+Pavadai" = "assets/images/saree.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Anarkali" = "assets/images/dress.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Shirt" = "assets/images/suit.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Polo" = "assets/images/blazer.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Shorts" = "assets/images/jeans.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Kids+Casual" = "assets/images/kids_wear.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Kids+Dress" = "assets/images/kids_pajamas.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Kids+Print" = "assets/images/kids_ethnic.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Kids+Traditional" = "assets/images/kids_collection.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Kids+Outerwear" = "assets/images/baby.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Children's+World" = "assets/images/puzzle.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Luxury+Shirt" = "assets/images/men_s_blazer.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Escalator" = "assets/images/mall_interior.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Fashion+Show" = "assets/images/luxury_display.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Toys" = "assets/images/puzzle.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Musical" = "assets/images/art.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Vehicle" = "assets/images/stroller.jpg"
    "https://placehold.co/600x400/222/d4af37?text=Clothing" = "assets/images/kids_accessories.jpg"
}

foreach ($file in $files) {
    if (-not (Test-Path -Path $file)) { continue }
    
    $content = Get-Content -Path $file -Raw
    
    foreach ($key in $replacements.Keys) {
        $val = $replacements[$key]
        # Using string replacement to ensure exact match of the URL
        $content = $content.Replace($key, $val)
    }
    
    Set-Content -Path $file -Value $content
}
Write-Host "Done replacing placeholders with local images!"
