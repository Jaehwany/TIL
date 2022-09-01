# Truffle Setting by Solidity

<br>

> 환경 설정

1. `truffle` 설치

   ```bash
   $ npm install -g truffle
   ```

2. `nft-contracts` 폴더 생성

   ```bash
   $ mkdir nft-contracts
   ```

3. 폴더 내부에서 truffle 시작

   ```bash
   $ truffle init
   ```

4. 메인에서 다시 `openzepplin` 설치

   ```bash
   $ npm install @openzeppelin/contracts
   ```

5. hdwallet 라이브러리 설치

   ```bash
   $ npm install @truffle/hdwallet-provider
   ```

<br>

> 배포

1. truffle 컴파일

   ```bash
   $ truffle compile
   ```

2. truffle migrate

   ```bash
   $ truffle migrate --network {네트워크 이름}
   ```

3. Result

   ```bash
   Starting migrations...
   ======================
   > Network name:    'ssafy'
   > Network id:      202112031219
   > Block gas limit: 9007199254740991 (0x1fffffffffffff)
   
   
   1_initial_migration.js
   ======================
   
      Deploying 'AnimalNFT'
      ---------------------
      > transaction hash:    0x99f6d4624a54a6e3981274767d78c4642b7f6685ffd5c44fcbe628c7feb596b3
      > Blocks: 0            Seconds: 0
      > contract address:    0x6c65a74E0E7E4ff6D16F232904b7319E1e76cA55
      > block number:        4634440
      > block timestamp:     1662042203
      > account:             0x85c991c497f62ECE1b577eFEB6D5E518C42683D4
      > balance:             0
      > gas used:            2916799 (0x2c81bf)
      > gas price:           0 gwei
      > value sent:          0 ETH
      > total cost:          0 ETH
   
      > Saving artifacts
      -------------------------------------
      > Total cost:                   0 ETH
   
   Summary
   =======
   > Total deployments:   1
   > Final cost:          0 ETH
   ```

4. 네트워크 접속

   ```bash
   truffle console --network {네트워크명}
   ```

   
