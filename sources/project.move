module MyModule::DeFiPortfolioManagement {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    struct Portfolio has store, key {
        total_assets: u64,  // Total assets in the portfolio
    }

    /// Function to create a new portfolio for the user.
    public fun create_portfolio(owner: &signer) {
        let portfolio = Portfolio {
            total_assets: 0,
        };
        move_to(owner, portfolio);
    }

    /// Function to add assets to the portfolio.
    public fun add_assets(owner: &signer, amount: u64) acquires Portfolio {
        let portfolio = borrow_global_mut<Portfolio>(signer::address_of(owner));
        let deposit = coin::withdraw<AptosCoin>(owner, amount);
        coin::deposit<AptosCoin>(signer::address_of(owner), deposit);
        portfolio.total_assets = portfolio.total_assets + amount;
    }
}
