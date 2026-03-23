import glob

files = glob.glob('assets/games/html/*.html')

for f in files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    modified = content
    
    # Hide the text
    modified = modified.replace('ctx.fillText("Başlamak için dokun / Space",', '// ctx.fillText(')
    modified = modified.replace('ctx.fillText("Başla: Space veya dokun",', '// ctx.fillText(')
    modified = modified.replace('ctx.fillText("Başlamak için Space veya dokun",', '// ctx.fillText(')
    
    # Try injecting resetGame and fixing mode
    if 'window.autoStartedNemos' not in modified:
        hook = """
      if (!window.autoStartedNemos) {
        window.autoStartedNemos = true;
        if (typeof resetGame === 'function') resetGame();
        if (typeof init === 'function') { init(); if (typeof gameState !== 'undefined') gameState = 'PLAYING'; }
      }
"""
        # Find where to inject (before the final closing IIFE brace or requestAnimationFrame block)
        if "requestAnimationFrame(frame);" in modified:
            modified = modified.replace("requestAnimationFrame(frame);", hook + "\n      requestAnimationFrame(frame);")
        elif "requestAnimationFrame(gameLoop);" in modified:
            modified = modified.replace("requestAnimationFrame(gameLoop);", hook + "\n      requestAnimationFrame(gameLoop);")
        elif "requestAnimationFrame(draw);" in modified:
            modified = modified.replace("requestAnimationFrame(draw);", hook + "\n      requestAnimationFrame(draw);")
            
        modified = modified.replace('mode: "menu",', 'mode: "playing",')
        modified = modified.replace("let gameState = 'START';", "let gameState = 'PLAYING';")
        
    if content != modified:
        with open(f, 'w', encoding='utf-8') as out:
            out.write(modified)
        print("Patched:", f)
