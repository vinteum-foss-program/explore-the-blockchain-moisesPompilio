# Which tx in block 257,343 spends the coinbase output of block 256,128?

# Bloco especificado
block=257343

# Obter bloco anterior
prev_block=256128

# Obter hash do bloco anterior
prev_block_hash=$(bitcoin-cli getblockhash $prev_block)

# Obter transação coinbase do bloco anterior
prev_coinbase_txid=$(bitcoin-cli getblock $prev_block_hash 1 | jq -r '.tx[0]')

# Obter bloco atual
block_hash=$(bitcoin-cli getblockhash $block)

# Buscar transação que gasta o coinbase
for tx in $(bitcoin-cli getblock $block_hash 2 | jq -r '.tx[].txid'); do
    inputs=$(bitcoin-cli getrawtransaction $tx 1 | jq '.vin')
    if echo "$inputs" | grep -q "$prev_coinbase_txid"; then
        echo $tx
        break
    fi
done