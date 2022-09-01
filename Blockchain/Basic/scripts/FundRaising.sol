// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract FundRaising {
    uint public constant MINIMUN_AMOUT = 1e17; // 0.01 eth = 10 ** 16 
    uint public fundRaisingCloses; //모금 종료 시각
    address public beneficiary; //모금 수령자

    mapping(address => uint256) funderToAmount;
    address[] funders;

    constructor (uint _duration, address _beneficiary) {
       fundRaisingCloses = block.timestamp + _duration; //block.timestamp = 현재 블록의 유닉스 타임스탬프 값
       beneficiary = _beneficiary;
    }

    function fund() public payable {
        require(msg.value >= MINIMUN_AMOUT,"Miniman Amount : 0.01 eth");
        require(block.timestamp < fundRaisingCloses, "Fund Raising Closed");

        addFunder(msg.sender);
        funderToAmount[msg.sender] += msg.value;
    }

    function addFunder(address _funder) internal {
        if(funderToAmount[_funder] == 0 ) {
            funders.push(_funder);
        }
    }

    function currentCollection() public view returns(uint256){
        return address(this).balance;  
    }

    modifier onlyBeneficiary(){
        require(msg.sender == beneficiary,"");
        _;
    }

    modifier onlyAfterFundCloses() {
        require(block.timestamp > fundRaisingCloses,"");
        _;
    }

    function withdraw() public payable onlyBeneficiary onlyAfterFundCloses {
        payable(msg.sender).transfer(address(this).balance);
    }

    function selectRandomFunder() public view returns (address, uint256) {
        if(funders.length == 0) return (address(0), 0);

        bytes32 rand = keccak256(abi.encodePacked(blockhash(block.number)));
        address selected = (funders.length == 1 ) ? funders[0] : funders[uint(rand) % funders.length];
        return (selected, funderToAmount[selected]);
    }

}
