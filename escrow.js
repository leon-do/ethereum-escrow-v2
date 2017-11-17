/*
STATUS:
	created
	locked
	complete
*/

const item = {}
let itemNumber = 0

function ItemList (sellerValue, sellerAddress, buyerValue, buyerAddress, status){
	return {
		sellerValue: sellerValue,
		sellerAddress: sellerAddress,
		buyerValue: buyerValue,
		buyerAddress: buyerAddress,
		status: status
	}
}


// create multiple items
function createItem (_msgVal, _msgSend) {
	// DELETE
	const msg = {}
	msg.value = _msgVal
	msg.sender = _msgSend

    // new item number
	itemNumber++

    // create new item
	item[itemNumber] = new ItemList(msg.value, msg.sender, 0, msg.sender, 'created')
}


function buyItem(_msgVal, _msgSend, _itemNumber) {
	
	// REMOVE
	const msg = {}
	msg.sender = '0xBuyer'
	msg.value = _msgVal

	// if the buyer value is twice as much as the sellerValue && status is 'created'
	if (item[_itemNumber].sellerValue * 2 == msg.value && item[_itemNumber].status == "created") {
		// update the status
		item[_itemNumber].status = 'only_buyer_can_unlock';
		// add buyer address to item
		item[_itemNumber].buyerAddress = msg.sender;
		// add buyer value to item
		item[_itemNumber].buyerValue = msg.value;
	}
}


function buyerUnlock(_msgSend, _itemNumber) {

	// REMOVE
	const msg = {}
	msg.sender = _msgSend

	// if address belongs to the buyer && status is 'only_buyer_can_unlock'
	if ( item[_itemNumber].buyerAddress == msg.sender && item[_itemNumber].status == "only_buyer_can_unlock") {
		// NOTE: This actually allows both the buyer and the seller to block the refund - the withdraw pattern should be used.

		// update the status
		item[_itemNumber].status = 'item_recieved';

		// transfer buyer value to seller
		// item[_itemNumber].sellerAddress.transfer(item[_itemNumber].buyerValue)

		// transfer seller value to buyer
		// item[_itemNumber].buyerAddress.transfer(item[_itemNumber].sellerValue)
        
	}
}


function abortItem(_msgSend, _itemNumber) {
	// if address belongs to seller && status is 'created'
	if (_msgSend === item[_itemNumber].sellerAddress && item[_itemNumber].status === "created"){

		// change status to 'abort'
		item[_itemNumber].status = "abort"

		// return funds to seller
		// item[_itemNumber].sellerAddress.transfer(item[_itemNumber].sellerValue)
	}
}

function returnItem(_msgSend, _itemNumber) {
	// if address belongs to buyer && status is 'only_buyer_can_unlock'
	if (_msgSend === item[_itemNumber].buyerAddress && item[_itemNumber].status === "only_buyer_can_unlock"){

		// change status to 'only_seller_can_unlock'
		item[_itemNumber].status = 'only_seller_can_unlock'
	}
}

function sellerUnlock(_msgSend, _itemNumber) {
	// if address belongs to seller and status is 'only_buyer_can_unlock'
	if (_msgSend === item[_itemNumber].sellerAddress && item[_itemNumber].status === "only_seller_can_unlock"){

		// change status to 'seller_complete'
		item[_itemNumber].status = 'item_returned'

		// transfer buyer value to seller
		// item[_itemNumber].sellerAddress.transfer(item[_itemNumber].sellerValue)

		// transfer seller value to buyer
		// item[_itemNumber].buyerAddress.transfer(item[_itemNumber].buyerValue)		
	}
}



// =============INTERACT WITH CONTRACT===================


/*
createItem(22, '0xSeller')
abortItem('0xSeller', 1)
buyItem(44, '0xBuyer', 1)
buyerUnlock('0xBuyer', 1)
returnItem('0xBuyer', 1)
sellerUnlock('0xSeller', 1)
*/

// Item 1: completed transaction
createItem(22, '0xSeller')
buyItem(44, '0xBuyer', 1)
buyerUnlock('0xBuyer', 1)

// Item 2: abort
createItem(33, '0xSeller')
abortItem('0xSeller', 2)

// Item 3: return item
createItem(10, '0xSeller')
buyItem(20, '0xBuyer', 3)
returnItem('0xBuyer', 3)
sellerUnlock('0xSeller', 3)

// Item 4: incorrect buyValue !==
createItem(99999, '0xSeller')
buyItem(123, '0xBuyer', 4)	// status is still 'created'
buyerUnlock('0xBuyer', 4)


console.log(item)






