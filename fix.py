import os
import glob

# HTML parsing to change START to PLAYING
files = glob.glob('assets/games/html/*.html')

for f in files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # We want to replace initial let gameState = 'START'; with 'PLAYING';
    content = content.replace("let gameState = 'START';", "let gameState = 'PLAYING';")
    content = content.replace('let gameState = "START";', 'let gameState = "PLAYING";')
    content = content.replace('gameState === "START"', 'false')
    content = content.replace("gameState === 'START'", "false")
    
    with open(f, 'w', encoding='utf-8') as file:
        file.write(content)

print('Replacement complete.')
