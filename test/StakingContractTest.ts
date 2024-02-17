import {
    time,
    loadFixture,
  } from "@nomicfoundation/hardhat-toolbox/network-helpers";
  import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
  import { expect, assert } from "chai";
  import { ethers } from "hardhat";
import { token } from "../typechain-types/@openzeppelin/contracts";

  describe.only("StakingContract ", async ()=>{
        
    const deploySmartContract =async ()=>{
        const tokenMinted = 30000000000;
        const amountStaked = 5000;
        const amountAllowedToSpend= 2000000;

        const [owner, otherAccount, otherAccount1] = await ethers.getSigners();
        const EmaxToken = await ethers.getContractFactory("EmaxToken");
        const emaxToken = await EmaxToken.deploy(owner.address);

        const StakingContract = await ethers.getContractFactory("StakingContract");
        const stakingContract = await StakingContract.deploy(emaxToken.target);


        return { stakingContract, emaxToken ,otherAccount, owner, tokenMinted , amountAllowedToSpend, amountStaked};
    }
    describe("Deployment of Staking Contract", async ()=>{
        it("test that contract has be deployed", async()=>{
            const {stakingContract, emaxToken, owner} = await loadFixture(deploySmartContract);
            assert.isNotNull(stakingContract);
            assert.isNotNull(emaxToken);
        })
        it("test that token 100000000 token can be transfered to the contract", async()=>{
            const {stakingContract, emaxToken, owner, otherAccount, tokenMinted} = await loadFixture(deploySmartContract);
            const deployedTokenOwner = await emaxToken.balanceOf(owner.address); 
            expect(deployedTokenOwner).to.equal(tokenMinted)
                       

        })
        it("should have 0.01% rewards per hour", async function () {
            const {stakingContract, emaxToken, owner} = await loadFixture(deploySmartContract);

            expect(await stakingContract.rewardsPerHour()).to.equal(1000)
          });
    });

    describe("Deposit Token", async()=>{
        it("test that user can deposit to the staknig contract and check balance", async()=>{
            const {stakingContract, emaxToken, owner, amountStaked, amountAllowedToSpend} = await loadFixture(deploySmartContract);
              
                const userSakingBalance = await stakingContract.balanceOf(owner.address);
                expect(userSakingBalance).to.equal(0);

                emaxToken.connect(owner).approve(stakingContract.target, amountAllowedToSpend);
                
                await stakingContract.deposit(amountStaked);
                expect(await stakingContract.balanceOf(owner.address)).to.equal(amountStaked)
        });

        it("test that we can keep track of when the user lastUpdated equal to the latest block timestamp", async function () {
            await staking.deposit(amount)
            const latest = await time.latest()
            expect(await staking.lastUpdated(signer.address)).to.eq(latest)
          })
    })

  })