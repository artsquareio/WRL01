pragma solidity ^0.4.11;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/token/StandardToken.sol";

/**
 * @title WRL01 Token
 *
 * @dev Ownable ERC20 token, v 0.1
 */
contract WRL01 is Ownable {

  string public constant name = "Kiku - Andy Wharol";
  string public constant symbol = "WRL01";
  uint8 public constant decimals = 0;
  uint public constant INITIAL_SUPPLY = 28000;

 
  /** Token will be released only after initial listing.*/
  bool public released = false;

 
  /**
   * Limit token transfer until the listing is over.
   *
   */
  modifier canTransfer(address _sender) {
    require(released);
    _;
  }


  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
  function WRL01() {
    totalSupply = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  }


  function release() onlyOwner inReleaseState(false) public {
    released = true;
  }


  function approve(address _to, uint _value) returns (bool ok) {
    return super.approve(_to, _value);
  }

  function transfer(address _to, uint _value) canTransfer(msg.sender) returns (bool success) {
    return super.transfer(_to, _value);
  }

  function transferFrom(address _from, address _to, uint _value) canTransfer(_from) returns (bool success) {
    return super.transferFrom(_from, _to, _value);
  }

}
