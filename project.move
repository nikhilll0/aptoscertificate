module MyModule::DigitalWill {

    use aptos_framework::signer;
    use aptos_framework::vector;
    use aptos_framework::account;

    /// Struct representing the will.
    struct Will has store, key {
        owner: address,              // Owner of the will
        beneficiaries: vector<address>, // List of beneficiaries
        is_executed: bool,           // Execution status of the will
    }

    /// Function to create a new will.
    public fun create_will(owner: &signer, beneficiaries: vector<address>) {
        let will = Will {
            owner: signer::address_of(owner),
            beneficiaries,
            is_executed: false,
        };
        move_to(owner, will);  // Now the will can be moved to the owner's address
    }

    /// Function to execute the will and distribute assets.
    public fun execute_will(owner: &signer) acquires Will {
        let will = borrow_global_mut<Will>(signer::address_of(owner));
        assert!(will.is_executed == false, 1); // Ensure it hasn't been executed before
        
        // Logic for distributing assets to beneficiaries goes here
        
        will.is_executed = true; // Mark the will as executed
    }
}
