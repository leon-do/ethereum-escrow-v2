/*
status
  1  created
  2  aborted
  3  only_buyer_can_unlock
  4  only_seller_can_unlock  
  5  item_recieved
  6  item_returned
*/




/* 
item =
{
    '0xSender' : {        
        sellerValue: 12,
        sellerAddress: 0xSeller
        buyerAddress: 0xBuyer
        buyerValue: 0
        status: 1
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
            status: 1
        }
    }
    */
    uint public itemNumber = 0;
    struct Item {
        uint sellerValue;
        address sellerAddress;
        address buyerAddress;
        uint buyerValue;
        uint status;
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




    
    function add_new_itemNumber()
        payable
        returns (uint)
    {
        // new item number
        itemNumber++;
        
        // add new item to the itemList
        itemList[itemNumber] = Item(msg.value, msg.sender, msg.sender, 0, 1);

        // add new item to the addressList
        addressList[msg.sender].push(Address(itemNumber));

        // return the itemNumber
        return itemNumber;
    }
    
    function get_seller_value(uint _itemNumber) returns (uint){
        return itemList[_itemNumber].sellerValue;
    }
    
    function get_seller_address(uint _itemNumber) returns (address){
        return itemList[_itemNumber].sellerAddress;
    }
 
    function get_buyer_address(uint _itemNumber) returns (address){
        return itemList[_itemNumber].buyerAddress;
    }   
    
    function get_buyer_value(uint _itemNumber) returns (uint){
        return itemList[_itemNumber].buyerValue;
    }  
    
    function get_itemNumber_status(uint _itemNumber) returns (uint){
        return itemList[_itemNumber].status;
    }

    function get_itemNumber_from_address(address _address, uint index) public returns(uint){
        return addressList[_address][index].item;
    }

    function cancel_item(uint _itemNumber) returns (uint) {
        if (itemList[_itemNumber].sellerAddress == msg.sender && itemList[_itemNumber].status == 1) {
            // seller.transfer(value)
            itemList[_itemNumber].sellerAddress.transfer(itemList[_itemNumber].sellerValue);
        }
    }
    
}










