// SPDX-License-Identifier: MIT
pragma solidity >0.5.1;

contract solidity {
    string public value = "myvalue";
    // to create state var- declare data type then visibility  then variable name
    //    function get()public view returns(string memory){
    //         return value;
    //     }  same as if we write public in global var

    // function set(string memory _value) public{
    //     value = _value;
    // }

    // enum - enumerated lists - way of keeping track of enumerated lists in Solidity.
    // enum State {
    //     waiting,
    //     active,
    //     dead
    // } //created ds
    // State public state; //here u declared it as var

    // constructor() {
    //     // value = "myvalue"
    //     state = State.waiting;
    // }

    // function activate() public {
    //     state = State.active;
    // }

    // structs
    // struct identity {
    //     string fname;
    //     string lname;
    // }

    // array
    // identity[] public people; //we used people array to store data from identity

    uint256 public peopleCount = 0;

    // function addPerson(
    //     string memory _firstName,
    //     string memory _lastName
    // ) public {
    //     people.push(identity(_firstName, _lastName));
    //     peopleCount += 1;
    // }

    // mapping -allows us to store key-value pairs. This structure acts much like an associative array or a hash table in other functions. We'll treat the key like a database id. We
    // mapping(uint => identity) public mapped;
    // struct identity { uint _id; string _firstName; string _lastName; }

    // function id(string memory _firstName, string memory _lastName)public {
    //     peopleCount +=1;
    //     mapped[peopleCount] = identity(peopleCount, _firstName, _lastName);
    // }

//public function visibility several times so that the smart contract functions can be called outside the smart contract by accounts connected to the network


    //  internal visibility - if we wanted to create functions that are only used inside the smart contract

    // function modifiers. These will allow us to add special behavior to our functions, like add permissions
    address owner;
    modifier onlyowner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function get() public onlyowner view returns(address){
        return(owner);
    }

// events - 
}
