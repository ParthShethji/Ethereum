const {ethers} = require('ethers')


// there are 2 ways to connect to etherum blockchain
// one by metamask and other by this RPC client
const alchemyid = '6ov7B6dwrYdagdgMjUVRxycHsQvIm8Pj'

// A connection to the Ethereum network (a Provider)
// Holds your private key and can sign things (a Signer)

const provider = new ethers.providers.JsonRpcProvider(`https://eth-mainnet.g.alchemy.com/v2/OU8sLFB1YQoLzENXCfIbQ3vY0fbObK5_`);
// Once you have a Provider, you have a read-only connection to the blockchain  which you can use to query the current state

const main = async ()=>{
    const bal = await ethers.getBalance('0x388c818ca8b9251b393131c08a736a67ccb19297')
    console.log(bal)
}

main()