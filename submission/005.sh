# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

# Transação fornecida
txid="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

# Obter transação completa
tx=$(bitcoin-cli getrawtransaction $txid 1)

# Extrair chaves públicas dos inputs
pubkeys=()
for i in {0..3}; do
    pubkey=$(echo "$tx" | jq -r ".vin[$i].txinwitness[1]")
    pubkeys+=("$pubkey")
done

# Criar script multisig 1-of-4
script=$(bitcoin-cli -named createmultisig 1 "[\"${pubkeys[0]}\",\"${pubkeys[1]}\",\"${pubkeys[2]}\",\"${pubkeys[3]}\"]")

# Extrair endereço P2SH
p2sh_address=$(echo "$script" | jq -r '.address')

echo $p2sh_address