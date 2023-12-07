var chavesConta = {mateus1:"0xe70e4EA3C1ec10D7Ca7494Db4e187f8Dfdb85D71", mateus2:"0x48Aae16eC7Ec8fae197E40A4988a230083afC53b", mateus3:"0x3032f4265804e498aD07D0D9882965374e1aE5cd"};


var tranferirMoeda = function(conta1, conta2, qtde, valorGas, senhaConta1) {
    if (!valorGas) {
        valorGas = 21000;
    }


    if (Object.keys(chavesConta).includes(conta1) && Object.keys(chavesConta).includes(conta2) && qtde) {
        if (!senhaConta1) {
            personal.unlockAccount(chavesConta[conta1]);
        }
        else
        {
            personal.unlockAccount(chavesConta[conta1], senhaConta1);
        }


        eth.sendTransaction({from:chavesConta[conta1], to:chavesConta[conta2], value:qtde, gas:valorGas})
    }
    else if (!Object.keys(chavesConta).includes(conta1) || !Object.keys(chavesConta).includes(conta2))
    {
        return "Uma das contas infomadas nao foram encontradas";
    }
    else
    {
        return "Necessario ser uma quantidade valida para tranferir"
    }
}
