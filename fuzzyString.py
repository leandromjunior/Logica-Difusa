from fuzzywuzzy import fuzz

# Verifica a similaridade da string
fuzz.ratio('Apple Inc.', 'Apple')

fuzz.ratio('Apple Inc.', 'Apple')
fuzz.partial_ratio('Apple Inc.', 'Apple') # Verifica a similaridade parcial da string

fuzz.ratio('Flamengo x Santos', 'Santos x Flamengo')
fuzz.partial_ratio('Flamengo x Santos', 'Santos x Flamengo')
fuzz.token_sort_ratio('Flamengo x Santos', 'Santos x Flamengo') # Ignora a ordem das palavras

fuzz.ratio('Today we have a great game: Flamengo x Santos', 'Santos x Flamengo')
fuzz.partial_ratio('Today we have a great game: Flamengo x Santos', 'Santos x Flamengo')
fuzz.token_sort_ratio('Today we have a great game: Flamengo x Santos', 'Santos x Flamengo')
fuzz.token_set_ratio('Today we have a great game: Flamengo x Santos', 'Santos x Flamengo') # Ignora palavras duplicadas

# Leia-se o resultado(saída) em porcentagem