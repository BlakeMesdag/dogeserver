Dogeserver
==========

All requests must be json and over https. 

### Creating an account
    POST https://dogeserver.herokuapp.com/accounts

#### Params
    account: {
      name: 'account-name',
      key: 'your-secret-key'
    }



### Showing account
    GET https://dogeserver.herokuapp.com/accounts/:account_name

#### Params
    key: 'your-secret-key'



### Creating a tip
    POST https://dogeserver.herokuapp.com/accounts/:account_name/tips

#### Params
    tip: {
      to: 'some-other-account-name',
      amount: 9001  
    },
    key: 'your-secret-key'



### Creating a withdrawal
    POST https://dogeserver.herokuapp.com/accounts/:account_name/withdrawals

#### Params
    withdrawal: {
        to: 'dogecoin-wallet-address',
        amount: 9001
    },
    key: 'your-secret-key'
