require("chai")
    .use(require("chai-as-promised"))
    .should()


const EXCHANGE = artifacts.require("./Exchange")
const TOKEN = artifacts.require("./ERC20")

contract ("Exchange", ([lister1])=>{

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

})