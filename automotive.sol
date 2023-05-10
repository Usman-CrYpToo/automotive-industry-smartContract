// SPDX-License-Identifier: MIT

pragma solidity >= 0.7.0;

contract automotive{
     struct details{
          string make;
          string model;
          uint price ;
          uint units;
          bool stockava;
          address owner;
     }
        address owner ;
       constructor() {
            owner = msg.sender;
       }
      mapping(address => bool) public permissionGiven;
      
      mapping (string => mapping(string => details)) public store;
      mapping (string => details[]) public allmodels;
      mapping (address => details[]) public carOwned;

     function permission(address company) external {
         require(msg.sender == owner, " you are not the owner");
         permissionGiven[company] = !(permissionGiven[company]);
     }
        
     function addMaker(string memory _make, string memory _model, uint _price,uint _units) public {
          require(permissionGiven[msg.sender] == true,"first take permission from the owner");
          require(store[_make][_model].stockava == false,"you have already added the model");
          require((_price * (10 ** 18)) > 0 && _units > 0);
          details memory d1 = details(_make,_model,(_price * (10 ** 18)),_units,true,msg.sender);
        store[_make][_model] = d1;
        allmodels[_make].push(d1);
     }

     function buyer(string memory _make, string memory _model,uint _units) external payable  {
           require(store[_make][_model].stockava == true, "stock not available");
           require(store[_make][_model].units >= _units,"uints are not avaliable");
           require((store[_make][_model].price * _units) == msg.value,"ether must be correct");
           details memory de =store[_make][_model];
           de.owner = msg.sender;
           de.units = 1;
        
           for(uint i = 0; i < _units; i++){
             store[_make][_model].units -=1;
             carOwned[msg.sender].push(de);
           }
           if(store[_make][_model].units == 0){
               store[_make][_model].stockava = false;
           }
           (payable(store[_make][_model].owner)).transfer(msg.value);

     }  
}