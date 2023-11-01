//
//  node.cpp
//  26979-ZeynepHaykir
//
//  Created by Zeynep HAYKIR on 2021-12-16.
//

#include "node.hpp"
Node::Node(string data):data(data)
{
    
}
void Node::addNeighbour(Node* node,transformation_info info)
{
    neighbours.insert({node,info});
}
