const RealEstateEscrow = artifacts.require("RealEstateEscrow");

module.exports = async function(deployer) {
  await deployer.deploy(RealEstateEscrow);
};