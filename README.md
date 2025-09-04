# My Wallet

A simple wallet management API built with **Ruby on Rails 8.0.2.1** and **Ruby 3.4.2**.  

This app provides basic wallet transactions and stock price lookups.

---

## Features

### Wallet Transactions
- **Deposit**: Add balance to a wallet.  
- **Withdraw**: Deduct balance from a wallet.  
- **Transfer**: Send balance from one wallet to another.  

### Stock Prices (via API integration)
- `price_all`: Get all stock prices.  
- `price`: Get a specific stock price.  
- `prices`: Get multiple stock prices.  

---

## Setup

### Clone Repository
```sh
git clone https://github.com/AnggaInJaya/my-wallet.git
cd my-wallet
```

### Generate JWT Keys
```sh
ssh-keygen -t rsa -P "" -b 4096 -m PEM -f keys/jwtRS256.key
```

### Setup DB
```sh
rake db:create db:migrate
```