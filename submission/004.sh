# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`

# Chave pública estendida fornecida
xpub="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

# Criar descriptor Taproot (tr()) no índice 100
desc=$(bitcoin-cli -named getdescriptorinfo "tr($xpub/100)" | jq -r ".descriptor")

# Gerar o endereço Taproot
addresses=$(bitcoin-cli -named deriveaddresses "$desc")

# Imprimir o endereço
echo "$addresses" | jq -r '.[]'