# How many new outputs were created by block 123,456?

# Obtém o hash do bloco 123,456
block_hash=$(bitcoin-cli getblockhash 123456)

# Obtém os dados completos do bloco no formato JSON
block=$(bitcoin-cli getblock $block_hash 2)

# Conta o número total de "vout" no JSON usando jq
echo "$block" | jq '[.tx[].vout] | flatten | length'