# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

txid="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"

# Obter transação completa
tx=$(bitcoin-cli getrawtransaction $txid true)

# Extrair script de testemunha do input 0
script=$(echo "$tx" | jq -r '.vin[0].txinwitness[2]')
witness_flag=$(echo "$tx" | jq -r '.vin[0].txinwitness[1]')

# Decodificar script
decodeScript=$(bitcoin-cli decodescript $script)

# Extrair chaves públicas
pubkeys=$(echo "$decodeScript" | jq -r '.asm' | grep -oP '([0-9a-fA-F]{66})')

# Converter flag de witness para decimal
witness_index=$((16#${witness_flag}))

# Converter para array
mapfile -t pubkey_array <<< "$pubkeys"

# Exibir apenas a chave correspondente ao índice
echo "${pubkey_array[$witness_index - 1]}"