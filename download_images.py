import os
import re
import urllib.request
import string

def slugify(text):
    text = text.lower()
    valid_chars = "-_.() %s%s" % (string.ascii_letters, string.digits)
    text = ''.join(c for c in text if c in valid_chars)
    text = text.replace(' ', '_').replace('-', '_')
    return text

html_files = ["index.html", "men.html", "women.html", "kids.html", "children.html", "traditional.html"]
image_dir = os.path.join("assets", "images")
os.makedirs(image_dir, exist_ok=True)

img_tag_pattern = re.compile(r'<img[^>]+src="([^"]+)"[^>]*>')
alt_attr_pattern = re.compile(r'alt="([^"]+)"')

for file_name in html_files:
    if not os.path.exists(file_name):
        continue
    
    with open(file_name, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Find all image tags
    img_tags = re.findall(r'<img[^>]+>', content)
    
    for tag in img_tags:
        src_match = re.search(r'src="([^"]+)"', tag)
        if not src_match:
            continue
        src = src_match.group(1)
        
        if "unsplash.com" in src or "mixkit.co" in src:
            alt_match = re.search(r'alt="([^"]+)"', tag)
            alt_text = alt_match.group(1) if alt_match else "image"
            
            # Clean alt text for filename
            filename = slugify(alt_text) + ".jpg"
            local_path = f"assets/images/{filename}"
            full_local_path = os.path.join(image_dir, filename)
            
            # Download if not exists
            if not os.path.exists(full_local_path):
                print(f"Downloading {src} to {full_local_path}")
                try:
                    req = urllib.request.Request(src, headers={'User-Agent': 'Mozilla/5.0'})
                    with urllib.request.urlopen(req) as response, open(full_local_path, 'wb') as out_file:
                        data = response.read()
                        out_file.write(data)
                except Exception as e:
                    print(f"Failed to download {src}: {e}")
                    continue
            
            # Replace in content
            content = content.replace(src, local_path)
            
    with open(file_name, 'w', encoding='utf-8') as f:
        f.write(content)
        
print("Done!")
