/* 
item =
{
    '0xSender' : {        
        sellerValue: 12,
        sellerAddress: 0xSeller
        buyerAddress: 0xBuyer
        buyerValue: 0
        status: "created"
    }
}
*/

pragma solidity ^0.4.0;

contract myContract {
    

    /*
    itemList =
    {
        '0xSender' : {        
            sellerValue: 12,
            sellerAddress: 0xSeller
            buyerAddress: 0xBuyer
            buyerValue: 0
            status: "created"
        }
    }
    */
    uint public itemNumber = 0;
    struct Item {
        uint sellerValue;
        address sellerAddress;
        address buyerAddress;
        uint buyerValue;
        string status;
    }
    mapping(uint => Item) public itemList;
    




    /*
    addressList = {
        0xAddress1 : [1, 6, 9],
        0xAddress2 : [2, 4, 7],
        0xAddress3 : [3, 5, 8]
    }
    */
    struct Address{
        uint item;
    }
    mapping(address => Address[]) public addressList;




    
    function add_new_item()
        payable
    {
        // new item number
        itemNumber++;
        
        // add new item to the itemList
        itemList[itemNumber] = Item(msg.value, msg.sender, msg.sender, 0, "created");

        // add new item to the addressList
        addressList[msg.sender].push(Address(itemNumber));
    }
    
    function get_seller_value(uint _item) returns (uint){
        return itemList[_item].sellerValue;
    }
    
    function get_seller_address(uint _item) returns (address){
        return itemList[_item].sellerAddress;
    }
 
    function get_buyer_address(uint _item) returns (address){
        return itemList[_item].buyerAddress;
    }   
    
    function get_buyer_value(uint _item) returns (uint){
        return itemList[_item].buyerValue;
    }  
    
    function get_item_status(uint _item) returns (string){
        return itemList[_item].status;
    }

    function get_item_from_address(address _address, uint index) public returns(uint){
        return addressList[_address][index].item;
    }
    
}