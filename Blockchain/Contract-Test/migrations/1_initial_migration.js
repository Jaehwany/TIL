//const Migrations = artifacts.require("Migrations");
//const SsafyToken = artifacts.require("SsafyToken");
const AnimalNFT = artifacts.require("AnimalNFT");

module.exports = function (deployer) {
  deployer.deploy(AnimalNFT);
};
