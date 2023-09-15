// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Twitter {
    uint16 public MAX_TWEET_LENGTH = 280;

    // creating a tweet struct
    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier checkOwner() {
        require(
            msg.sender == owner,
            "You can't chnage the length of the Tweet because you are not owner"
        );
        _;
    }

    function changetweetlength(uint16 length) public checkOwner {
        MAX_TWEET_LENGTH = length;
    }

    // Create tweet function
    function createTweet(string memory _tweet) public {
        require(
            bytes(_tweet).length <= MAX_TWEET_LENGTH,
            "Max length of Tweet exceeds."
        );

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    // like tweet function
    function likeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "Tweet Not Exists");
        tweets[author][id].likes++;
    }

    // unlike tweet function
    function unlikeTweer(address author, uint256 id) external {
        require(tweets[author][id].id == id, "Tweet Not Exists");
        require(tweets[author][id].likes > 0, "This Tweet has no like");
        tweets[author][id].likes--;
    }

    // Get Tweet based on the index value Function
    function getTweet(uint256 _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    //Get All Tweets Function
    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}