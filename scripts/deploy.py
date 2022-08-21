from brownie import LoyaltyProgramPaymentGateway, accounts

DROVA_DAO = '0xe84f3857dc41eb77d57765e9f7579480263e46fc'
DROVA_LP = "0xeD84E24E90d8e26876DC9902B97c81e303259612"
DEPLOYER = "XXX_BROWNIE_ACCOUNT_NAME_FIXME_XXX"
BOOKKEEPER = "XXX_BOOKEEPER_ADDRESS_FIXME_XXX"


# brownie run scripts/deploy.py --network polygon-test
def main():
    deployer = accounts.load(DEPLOYER)
    gateway = deployer.deploy(LoyaltyProgramPaymentGateway,
                              DROVA_LP,
                              BOOKKEEPER,
                              DROVA_DAO,
                              10,
                              publish_source=True,
                              )
    gateway.grantRole(gateway.BOOKKEEPER(), BOOKKEEPER, {'from': deployer})
