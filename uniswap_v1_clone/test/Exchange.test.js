require("chai")
    .use(require("chai-as-promised"))
    .should()


const { ether, tokens } = require("./helpers")



const EXCHANGE = artifacts.require("./Exchange")
const TOKEN = artifacts.require("./ERC20")

contract ("Exchange", ([lister1, LP1])=>{

    let komusExchange
    let komusToken

    beforeEach(async()=>{

        komusToken = await TOKEN.new("KOMUS", "KOM")
        komusExchange = await EXCHANGE.new(komusToken.address)
    })

    describe("contract deployment", ()=>{

        it("should have contract address", ()=>{
            komusToken.address.should.not.be.equal("", "token contract has an address")
            komusExchange.address.should.not.be.equal("", "exchange contract has an address")
        })


    })

    describe("registered token address", ()=>{

        it("should return the token address for the exchange", async()=>{

            const returnedTokenAddress = await komusExchange.getTokenAddress()

            returnedTokenAddress.should.be.equal(komusToken.address, "it returns the address of the registered token in the exchange contract")

        })

    })

    describe("liquidity providal", ()=>{

        beforeEach(async()=>{
            await komusToken.transfer(LP1, tokens(1))
            await komusToken.approve(komusExchange.address, tokens(1), {from: LP1})
        })

        it("provides liquidity", async()=>{

            await komusExchange.addLiquidity(tokens(1), {from: LP1, value: ether(1)})

            const updatedReserve = await komusExchange.getReserve()
            updatedReserve.toString().should.be.equal(tokens(1).toString(), "the reserve was updated after liquidity was provided")
        })

    })

})