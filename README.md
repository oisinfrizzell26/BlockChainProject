# Blockchain Ticketing System

A decentralized ticketing system DApp built on the Ethereum Sepolia testnet. Users can create wallets, purchase event tickets, check balances, and return tickets, all powered by a custom ERC-20 smart contract.

## Features
- **Wallet Creation:** Generate a new Ethereum wallet and download the encrypted keystore file.
- **Wallet Decryption:** Load and decrypt an existing wallet using a keystore file and password.
- **Balance Checking:** View Sepolia ETH and ticket token balances for attendees, doormen, and venue roles.
- **Ticket Purchase:** Buy event tickets using Sepolia ETH via MetaMask.
- **Ticket Return:** Return unused tickets to the vendor.
- **MetaMask Integration:** Secure wallet connection and transaction signing.

## How to Run
1. **Clone or Download the Repository**
2. **Open the Project Folder in [Visual Studio Code](https://code.visualstudio.com/)**
3. **Install the [Live Server Extension](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)**
4. **Right-click `index.html` and select "Open with Live Server"**
5. **Ensure MetaMask is installed and set to the Sepolia Test Network**
6. **Interact with the DApp via your browser**

## Folder Structure
- `index.html` - Entry point, redirects to the home page
- `homePage/` - Main navigation page
- `createWallet/` - Wallet creation functionality
- `decryptWallet/` - Wallet decryption functionality
- `checkBalance/` - Balance checking for all roles
- `buyTicket/` - Ticket purchase page
- `returnTicket/` - Ticket return page
- `payableContract/` - Solidity smart contract source code

## Additional Notes
- All blockchain interactions require MetaMask and Sepolia ETH (get test ETH from a Sepolia faucet).
- Transaction links and contract details can be viewed on [Sepolia Etherscan](https://sepolia.etherscan.io/address/0x6235B92645D8EC813C5ebf47CC5D2D28966D7682).

