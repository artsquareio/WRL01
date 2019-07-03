pragma solidity ^0.5.0;

import "github.com/OpenZeppelin/zeppelin-solidity/contracts/ownership/Ownable.sol";
import "github.com/OpenZeppelin/zeppelin-solidity/contracts/token/ERC20/ERC20.sol";

/**
 * @title WRL01 Token
 *
 * @dev Ownable ERC20 token, v 0.1
 */
contract WRL01 is ERC20, Ownable {

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

  /** The function can be called only before or after the tokens have been releasesd */
  modifier inReleaseState(bool releaseState) {
    require(releaseState == released);
    _;
  }

  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
  constructor() public {
    _mint(msg.sender, INITIAL_SUPPLY);
  }


  function release() onlyOwner inReleaseState(false) public {
    released = true;
  }


  function approve(address _to, uint _value) public returns (bool ok) {
    return super.approve(_to, _value);
  }

  function transfer(address _to, uint _value) public canTransfer(msg.sender) returns (bool success) {
    return super.transfer(_to, _value);
  }

  function transferFrom(address _from, address _to, uint _value) public canTransfer(_from) returns (bool success) {
    return super.transferFrom(_from, _to, _value);
  }

}
