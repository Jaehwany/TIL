// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./IERC721.sol";
import "./IERC721Receiver.sol";
import "./extensions/IERC721Metadata.sol";
import "../../utils/Address.sol";
import "../../utils/Context.sol";
import "../../utils/Strings.sol";
import "../../utils/introspection/ERC165.sol";

contract ERC721 is Context, ERC165, IERC721, IERC721Metadata {
    using Address for address;
    using Strings for uint256;

    // Token name - 토큰 이름
    string private _name;

    // Token symbol - 토큰 단위
    string private _symbol;

    // Mapping from token ID to owner address - 토큰 소유자
    mapping(uint256 => address) private _owners;

    // Mapping owner address to token count - 특정 주소별 토큰 보유 수
    mapping(address => uint256) private _balances;

    // Mapping from token ID to approved address - 대리 송금 권한 정보
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals - 부여된 토큰 operator 및 권한 정보
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    /**
     * @dev ERC721 생성자
     * Token Name, Symbol 을 매개변수로 받아 상태 변수에 저장한다
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev IERC 165 supportsInterface
     * ERC 721이 반드시 구현해야할 함수를 구현하고 있는지 판별하는 함수 - IERC721, IERC721Metadata, IERC165 
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev IERC 721 balanceOf
     * 특정 주소가 몇개의 NFT 토큰을 보유하는지 반환
     */
    function balanceOf(address owner) public view virtual override returns (uint256) {
        require(owner != address(0), "ERC721: address zero is not a valid owner");
        return _balances[owner];
    }

    /**
     * @dev IERC 721 ownerOf
     * 특정 토큰의 소유자 주소 반환
     */
    function ownerOf(uint256 tokenId) public view virtual override returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: invalid token ID");
        return owner;
    }

    /**
     * @dev IERC 721 safeTransferFrom
     * NFT를 안전하게 전송 (NFT를 받을 수 있는 주소 인지 체크)
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev IERC721 safeTransferFrom
     * NFT와 data를 안전하게 전송 (NFT를 받을 수 있는 주소 인지 체크)
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public virtual override {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: caller is not token owner or approved");
        _safeTransfer(from, to, tokenId, data);
    }

    /**
     * @dev IERC721 transferFrom
     * 전송 함수 (from -> to)
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: caller is not token owner or approved");
        _transfer(from, to, tokenId);
    }

    /**
     * @dev IERC721 _safeTransfer
     * `tokenId` token from `from` to `to`
     */
    function _safeTransfer(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) internal virtual {
        _transfer(from, to, tokenId);
        //받는 주소가 스마트 컨트랙트 주소인 경우 ERC721Receiver의 onERC721Received 구현 검사
        require(_checkOnERC721Received(from, to, tokenId, data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev IERC721 _transfer
     * NFT 전송 함수, from -> to : tokenId
     * Requirements:
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     */
    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        // 송금을 지시할 수 있는 대상(from) : NFT 소유 당사자(ownerOf())
        require(ERC721.ownerOf(tokenId) == from, "ERC721: transfer from incorrect owner");
        //받는 주소가 0 주소가 아닌지
        require(to != address(0), "ERC721: transfer to the zero address");

        _beforeTokenTransfer(from, to, tokenId);

        // Check that tokenId was not transferred by `_beforeTokenTransfer` hook
        require(ERC721.ownerOf(tokenId) == from, "ERC721: transfer from incorrect owner");
        // Clear approvals from the previous owner
        delete _tokenApprovals[tokenId];

        //_balances 변경
        unchecked {
            _balances[from] -= 1;
            _balances[to] += 1;
        }
        //_owners 변경
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
        _afterTokenTransfer(from, to, tokenId);
    }

    /**
     * @dev IERC721 _isApprovedOrOwner
     * whether `spender` is allowed to manage `tokenId`.
     * Requirements:
     * - `tokenId` must exist.
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual returns (bool) {
        address owner = ERC721.ownerOf(tokenId);
        return (spender == owner || isApprovedForAll(owner, spender) || getApproved(tokenId) == spender);
    }

   /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) private returns (bool) {
        if (to.isContract()) {
            try IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, data) returns (bytes4 retval) {
                return retval == IERC721Receiver.onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert("ERC721: transfer to non ERC721Receiver implementer");
                } else {
                    /// @solidity memory-safe-assembly
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {
            return true;
        }
    }

    /**
     * @dev IERC721 approve 
     * 토큰 권한을 특정 주소에게 부여
     * Requirements:
     * - NFT 소유자만 권한을 부여할 수 있어야 한다
     * 권한이 부여되면 Approval 이벤트를 발생시킨다
     */
    function approve(address to, uint256 tokenId) public virtual override {
        address owner = ERC721.ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");
        //NFT 소유자만 권한을 부여할 수 있어야 한다
        require(
            _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not token owner or approved for all"
        );
        _approve(to, tokenId);
    }

    function _approve(address to, uint256 tokenId) internal virtual {
        _tokenApprovals[tokenId] = to;
        emit Approval(ERC721.ownerOf(tokenId), to, tokenId);
    }

    /**
     * @dev IERC721 setApprovalForAll
     * 토큰의 operator를 설정한다
     * operator : 특정 소유자의 토큰을 전송할 수 있는 모든 권한을 가지며, 
     *            토큰 소유자에 의해서만 권한을 지정할 수 있어야한다.
     */
    function setApprovalForAll(address operator, bool approved) public virtual override {
        _setApprovalForAll(_msgSender(), operator, approved);
    }

    /**
     * @dev IERC721 _setApprovalForAll
     * 'owner'가 'operator'에게 모든 권한을 준다
     */
    function _setApprovalForAll(
        address owner,
        address operator,
        bool approved
    ) internal virtual {
        require(owner != operator, "ERC721: approve to caller");
        _operatorApprovals[owner][operator] = approved;
        emit ApprovalForAll(owner, operator, approved);
    }

    /**
     * @dev IERC721 getApproved
     * 토큰의 approve 권한을 가진 주소 반환
     */
    function getApproved(uint256 tokenId) public view virtual override returns (address) {
        _requireMinted(tokenId);
        return _tokenApprovals[tokenId];
    }
    /**
     * @dev IERC721 _requireMinted
     * Token이 Mint 되었는지 check
     */
    function _requireMinted(uint256 tokenId) internal view virtual {
        require(_exists(tokenId), "ERC721: invalid token ID");
    }
    /**
     * @dev IERC721 _exists
     * Token 존재 여부를 check
     */
    function _exists(uint256 tokenId) internal view virtual returns (bool) {
        return _owners[tokenId] != address(0);
    }

    /**
     * @dev IERC 721 isApprovedForAll
     * '특정 주소'가 'operator' 권한을 갖는지 반환
     */
    function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[owner][operator];
    }
  
    /**
     * @dev IERC 721 Safe Mint
     */
    function _safeMint(address to, uint256 tokenId) internal virtual {
        _safeMint(to, tokenId, "");
    }

    /**
     * @dev IERC 721 Safe Mint with Data
     */
    function _safeMint(address to,uint256 tokenId,bytes memory data)
        internal virtual {
            _mint(to, tokenId);
            require(
                _checkOnERC721Received(address(0), to, tokenId, data),
                "ERC721: transfer to non ERC721Receiver implementer"
            );
        }

    /**
     * @dev IERC 721 _mint()
     * 상속받은 컨트랙트에 의해서만 호출 가능
     * Requirements:
     * - `tokenId` musst not exist.
     * - `to` cannot be the zero address.
     */
    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _beforeTokenTransfer(address(0), to, tokenId);

        // Check that tokenId was not minted by `_beforeTokenTransfer` hook
        require(!_exists(tokenId), "ERC721: token already minted");
        
        unchecked {
            _balances[to] += 1;
        }
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
        _afterTokenTransfer(address(0), to, tokenId);
    }

    /**
     * @dev IERC 721 _burn()
     * Requirements:
     * - `tokenId` must exist.
     */
    function _burn(uint256 tokenId) internal virtual {
        address owner = ERC721.ownerOf(tokenId);
        _beforeTokenTransfer(owner, address(0), tokenId);

        // Update ownership in case tokenId was transferred by `_beforeTokenTransfer` hook
        owner = ERC721.ownerOf(tokenId);

        // 소각할 NFT의 위임 송금 정보를 삭제한다
        delete _tokenApprovals[tokenId];

        unchecked {
            _balances[owner] -= 1;
        }
        delete _owners[tokenId];

        emit Transfer(owner, address(0), tokenId);
        _afterTokenTransfer(owner, address(0), tokenId);
    }

    /**
     * @dev IERC 721 _beforeTokenTransfer()
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {}

    /**
     * @dev IERC 721 _afterTokenTransfer()
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {}



    /**
     * @dev IERC 721 Metadata name
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev IERC 721 Metadata symbol
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev IERC 721 Metadata tokenURI
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }

    function _baseURI() internal view virtual returns (string memory) {
        return "";
    }
   
}


