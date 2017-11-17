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
    
    uint public itemNumber = 0;
    
    struct ItemList {
        uint sellerValue;
        address sellerAddress;
        address buyerAddress;
        uint buyerValue;
        string status;
    }
    
    mapping(uint => ItemList) public item;
    

    
    function createItem()
        payable
    {
        // new item number
        itemNumber++;
        
        // create new item
        item[itemNumber] = ItemList(msg.value, msg.sender, msg.sender, 0, "created");
    }
    
    function getSellerValue(uint _item) returns (uint){
        return item[_item].sellerValue;
    }
    
    function getSellerAddress(uint _item) returns (address){
        return item[_item].sellerAddress;
    }
 
    function getBuyerAddress(uint _item) returns (address){
        return item[_item].buyerAddress;
    }   
    
    function getBuyerValue(uint _item) returns (uint){
        return item[_item].buyerValue;
    }  
    
    function getItemStatus(uint _item) returns (string){
        return item[_item].status;
    }  
    
}