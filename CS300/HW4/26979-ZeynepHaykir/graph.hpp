//
//  graph.hpp
//  26979-ZeynepHaykir
//
//  Created by Zeynep HAYKIR on 2021-12-16.
//

#ifndef graph_hpp
#define graph_hpp

#include <stdio.h>
#include <vector>
#include <map>
#include "node.hpp"
using namespace std;

class Graph
{
    public:
    // CHANGE HERE

    // 1. Change vector into map so that it is easier to find the word we are looking for in nodeList
    // (To find a node in a vector you have to loop through each vector element to see if its data is equal to the word)
    // (To find a node in a map you can simply call nodeList.find(word))
    // Fix compilation errors
        map<string,Node*> nodeList;
        void addNode(string s);
        void setNeighbours(Node*);
        void findShortestPath(string from,string to);
        
};


#endif /* graph_hpp */
