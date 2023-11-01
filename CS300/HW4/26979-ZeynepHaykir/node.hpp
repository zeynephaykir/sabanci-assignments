//
//  node.hpp
//  26979-ZeynepHaykir
//
//  Created by Zeynep HAYKIR on 2021-12-16.
//

#ifndef node_hpp
#define node_hpp

#include <stdio.h>
#include <vector>
#include <string>
#include <map>
using namespace std;

class Node
{
    public:

        struct transformation_info
        {
            string event;
            char before;
            char after;
            int index;
        };
        string data;
        map<Node*,transformation_info> neighbours;
        Node(string data);
        void addNeighbour(Node*,transformation_info);
    
};

#endif /* node_hpp */
