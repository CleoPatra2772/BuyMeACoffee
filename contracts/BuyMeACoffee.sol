// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//Deployed to Goerli at 0xA983ab3160926D57d1F731074f9a6bbdE28ce358


// Import this file to use console.log
import "hardhat/console.sol";

contract BuyMeACoffee {
    //Even to emit when a Meno is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    //Memo struct,
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of all memos received from friends
    Memo[] memos;

    //Address of contract deployer,
    address payable owner;

    //Deploy logic -only runs when it is deployed
    constructor(){
        owner = payable(msg.sender);
    }

    /** 
    * @dev buy a coffee for contract owner
    * @param _name name of the coffee buyer
    * @param _message a nice message from the coffee buyer
    */
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee with 0 eth" );

        //Add memo to storage
        memos.push (Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message

        ));

        //Emit a log wh
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message

        );
    }

    /** 
    * @dev send the entire balance stored in this contract to the owner
    */

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

     /** 
    * @dev retrieve all the memos stored on blockchain.
    */

    function getMemos() public view returns(Memo[] memory){
        return memos;
    }

    

}
