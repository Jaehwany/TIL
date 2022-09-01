// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract Struct{

    struct Todo{
        string title;
        bool completed;
    }

    Todo[] public todos;

    function create(string memory _title ) public {
        todos.push(Todo(_title, false));
    }

    function update(uint _index, string memory _title) public{
        Todo storage todo = todos[_index];
        todo.title=_title;
    }

    function toggle(uint _index) public{
        Todo storage todo= todos[_index];
        todo.completed = !todo.completed;
    }

    function get(uint _index) public view returns(string memory title, bool completed){
        Todo storage todo = todos[_index];
        return (todo.title, todo.completed);
    }

}