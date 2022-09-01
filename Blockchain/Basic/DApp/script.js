var web3;
const ROPSTEN_URL = 'https://ropsten.infura.io/v3/';
const CA = '0x267c2b4e75f2f0Fc351a69311239cc5ca8c92B21';
const STORAGE_ABI = [
    {
        "inputs": [],
        "name": "retrieve",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "num",
                "type": "uint256"
            }
        ],
        "name": "store",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    }
]
const privateKey = '6b70cb71d04cf361aeb5e7532d832cf93c3b35fa12df5f2b91512ac1934ddd3b';
var sender;
var senderAddress;
var storageContract;

window.addEventListener('load', () => {
    if (typeof web3 !== 'undefined') {
        window.web3 = new Web3(web3.currentProvider);
        alert('web3 injected');

    } else {
        window.web3 = new web3(new web3.providers.HttpProvider(ROPSTEN_URL));
    }
    startApp();
});

/**
 * TODO:
 * 계정 정보 생성 및 초기 값 세팅
 */
function startApp() {
    
    // 1. 계정 정보
    sender = web3.eth.accounts.privateKeyToAccount('0x' + privateKey);
    web3.eth.accounts.wallet.add(sender);
    web3.eth.defaultAccount = sender.address;
    senderAddress = web3.eth.defaultAccount;
    
    // 2. storage 컨트랙트 인스턴스
    storageContract = new web3.eth.Contract(STORAGE_ABI, CA);

    // 3. 화면에 초기 값 세팅 
    document.getElementById('contractAddr').innerHTML = getAddrLink(CA);
    document.getElementById('accountAddr').innerHTML = getAddrLink(web3.eth.defaultAccount);


    retrieve();
}

function getAddrLink(addr) {
    return '<a target="_blank" href=https://ropsten.etherscan.io/address/' + addr + '>' + addr +'</a>';
}

function getTxLink(txHash) {
    return '<a target="_blank" href=https://ropsten.etherscan.io/tx/' + txHash + '>' + txHash +'</a>';
}

function getBlockLink(number) {
    return '<a target="_blank" href=https://ropsten.etherscan.io/block/' + number + '>' + number +'</a>';
}

function retrieve() {
    storageContract.methods.retrieve().call({from: senderAddress})
    .then(result => {
        document.getElementById('storedData').innerHTML = result;
    });

    web3.eth.getBlockNumber(function(error, result){
        document.getElementById('lastBlock').innerHTML = getBlockLink(result);
    });
}

function store() {
        let newValue = document.getElementById('newValue').value;

        storageContract.methods.store(newValue).estimateGas({ gas: 3000000 }, (error, gasAmount) => {
            storageContract.methods.store(newValue).send({
                from: senderAddress,
                gas: 3000000,
                gasPrice: 10000000000
            }).on("transactionHash", (hash) => {
                document.getElementById('txHash').innerHTML = getTxLink(hash);
            }).on("receipt", receipt => {
                if(receipt.status){
                    retrieve();
                }
            }).on("error", (error, receipt) => {
                console.error(error);
                console.log(">> receipt: ", receipt);
            });
    });
}