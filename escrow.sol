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




    
    function createItem()
        payable
    {
        // new item number
        itemNumber++;
        
        // create new item to the itemList
        itemList[itemNumber] = Item(msg.value, msg.sender, msg.sender, 0, "created");
    }
    
    function getSellerValue(uint _item) returns (uint){
        return itemList[_item].sellerValue;
    }
    
    function getSellerAddress(uint _item) returns (address){
        return itemList[_item].sellerAddress;
    }
 
    function getBuyerAddress(uint _item) returns (address){
        return itemList[_item].buyerAddress;
    }   
    
    function getBuyerValue(uint _item) returns (uint){
        return itemList[_item].buyerValue;
    }  
    
    function getItemStatus(uint _item) returns (string){
        return itemList[_item].status;
    }  
    
}