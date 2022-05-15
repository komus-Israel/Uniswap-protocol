const ether=(n)=>{
    return new web3.utils.BN(
        web3.utils.toWei(n.toString(), 'ether')
    )
    
}

const tokens = (n) => ether(n)

module.exports = { ether, tokens }