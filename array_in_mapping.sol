/*

addressList = {
    0xAddress1 : [1, 6, 9],
    0xAddress2 : [2, 4, 7],
    0xAddress3 : [3, 5, 8]
}

*/


pragma solidity ^0.4.0;

contract array_in_mapping{

    uint public itemNumber = 0;

    struct Address{
        uint item;
    }

    mapping(address => Address[]) addressList;

    function add() public {
        // new itemNumber
        itemNumber++;
        
        // add new itemNumber to item
        addressList[msg.sender].push(Address(itemNumber));
    }

    function get_items_from_address(address _address, uint index) public returns(uint){
        return addressList[_address][index].item;
    }
}






