Algoritmo de sincronização: Cristian Algorithm
Este é um algoritmo simples de sincronização onde os clientes se comunicam com um servidor central, o qual response com a data, e então cabe ao cliente realizar os cálculos para ajustar conforme a latência.
O único problema deste algoritmo é a sua simplicidade, que para casos mais complexos pode não ser o ideal.

Algoritmo de eleição de lider: Bully
Este algoritmo funciona através de ID's, onde a entidade com maior ID é elegida lider.
O problema deste algoritmo está no cenário onde a entidade de menor ID inicia uma votação, sendo assim, cada ID maior que ela irá se eleger lider, deixando o algoritmo ineficiente nestes casos.
