# Only one single output remains unspent from block 123,321. What address was it sent to?

# Bloco especificado
block=123321

# Obter hash do bloco
block_hash=$(bitcoin-cli getblockhash $block)

# Obter transações do bloco
block_txs=$(bitcoin-cli getblock $block_hash 2)

# Função para verificar se output está não gasto
check_unspent() {
    local txid=$1
    local vout=$2
    local result=$(bitcoin-cli gettxout $txid $vout)
    
    # Se o resultado for "null", significa que o output foi gasto
    # Se for um objeto JSON, significa que está não gasto
    if [ "$result" != "" ]; then
        return 0
    else
        return 1
    fi
}

# Iterar sobre transações
for tx in $(echo "$block_txs" | jq -r '.tx[].txid'); do
    for ((vout=0; vout<$(echo "$block_txs" | jq --arg tx "$tx" '.tx[] | select(.txid == $tx) | .vout | length'); vout++)); do
        if check_unspent "$tx" "$vout"; then
            address=$(bitcoin-cli gettxout "$tx" "$vout" | jq -r '.scriptPubKey.address')
            echo $address
            exit 0
        fi
    done
done