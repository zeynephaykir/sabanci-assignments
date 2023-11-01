//
//  graph.cpp
//  26979-ZeynepHaykir
//
//  Created by Zeynep HAYKIR on 2021-12-16.
//

#include "graph.hpp"
#include<queue>
#include<iostream>

void Graph::addNode(string s)
{
    Node* newNode = new Node(s);
    setNeighbours(newNode);
    nodeList.insert({s,newNode});
}

void Graph::setNeighbours(Node* n)
{
    int n_size = (int)n->data.size();
    for (pair<string,Node*> node:nodeList)
    {
        Node* currentNode = node.second;
        int currentNode_size = (int)currentNode->data.size();
        int difference = currentNode_size - n_size;
        if (abs(difference)>1)
        {
            continue;
        }
        bool check = false;
        Node::transformation_info n_info;
        Node::transformation_info node_info;
        if (difference == 0)
        {
            n_info.event = "change";
            node_info.event = "change";
            int count = 0;
            for (int i=0 ; i< n_size; i++)
            {
                if (n->data[i] != currentNode->data[i])
                {
                    count++;
                    n_info.index = i;
                    node_info.index = i;
                    n_info.before = n->data[i];
                    n_info.after = currentNode->data[i];
                }
                if (count > 1)
                {
                    check=true;
                    break;
                }
            }
        }
        else
        {
            int count = 0;
            Node* shortNode = n_size < currentNode_size ? n:currentNode;
            Node* longNode = n_size < currentNode_size ? currentNode:n;
            n_info.event = n_size < currentNode_size ? "insert":"delete";
            node_info.event = n_size > currentNode_size ? "insert":"delete";
            int j = 0;
            for (int i=0; i<shortNode->data.size(); i++)
            {
                if (shortNode->data[i] != longNode->data[j])
                {
                    if (shortNode->data[i] == longNode->data[j+1])
                    {
                        count++;
                        n_info.index = i;
                        node_info.index = i;
                        j++;
                        if (n_info.event == "insert")
                        {
                            n_info.before = shortNode->data[i];
                            n_info.after = longNode->data[i];
                        }
                        else
                        {
                            n_info.before = longNode->data[i];
                            n_info.after = shortNode->data[i];
                        }
                    }
                    else
                    {
                        check = true;
                        break;
                    }
                }
                if (count > 1)
                {
                    check=true;
                    break;
                }
                j++;
            }
            if (count == 0)
            {
                n_info.index = longNode->data.size()-1;
                node_info.index = longNode->data.size()-1;
                if (n_info.event == "insert")
                {
                    n_info.before = ' ';
                    n_info.after = longNode->data[longNode->data.size()-1];
                    --n_info.index;
                }
                else
                {
                    n_info.before = longNode->data[longNode->data.size()-1];
                    n_info.after = ' ';
                    --node_info.index;
                }
            }
        }
        if (check==true)
        {
            continue;
        }
        node_info.before = n_info.after;
        node_info.after = n_info.before;
        n->addNeighbour(currentNode,n_info);
        currentNode->addNeighbour(n,node_info);
            
    }
}
void Graph::findShortestPath(std::string from, std::string to)
{
    Node* fromNode = nodeList.find(from)->second;
    Node* toNode = nodeList.find(to)->second;

    // CHANGE HERE

    // 1. Create a queue of node pointers
    queue<Node*> queue;
    
    // 2. Push fromNode to the queue
    queue.push(fromNode);
    
    // 3. Create a map where key is a node pointer and value is an int
    // (This map will hold all nodes with their distances to fromNode)
    map<Node*, int> distanceMap;

    // 4. fromNode's distance to fromNode should be = ?
    distanceMap[fromNode] = 0;

    // 5. Add the rest of the nodes' distances to fromNode as infinity
    // (Hint: https://en.cppreference.com/w/cpp/types/numeric_limits)
    for (pair<string,Node*>p : nodeList)
    {
        distanceMap.insert({p.second,numeric_limits<int>::max()});
    }
    
    // 6. Create a map where key is a node pointer and value is a node pointer
    // (This map will hold all nodes with their previous nodes)
    map<Node*, Node*> prevNodeMap;

    // 7. fromNode's previous node should be = ?
    prevNodeMap[fromNode] = nullptr;
    // (Hint: Think of fromNode as the root of a tree and the previous node as its parent)

    while (!queue.empty())
    {
        Node* currentNode = queue.front();

        // 8. Pop currentNode from the queue
        queue.pop();

        // 9. Break the loop if currentNode is what we are looking for
        if (currentNode == toNode)
        {
            break;
        }

        for (pair<Node*,Node::transformation_info> neigh:currentNode->neighbours)
        {
            Node* neighbour = neigh.first;
            if (distanceMap[neighbour] == numeric_limits<int>::max())
            {
                distanceMap[neighbour] = distanceMap[currentNode]+1;
                prevNodeMap[neighbour] = currentNode;
                queue.push(neighbour);
            }
        }
        // 10. Loop neighbors
            // 11. If a neighbor's distance is infinity, it means that we haven't visited it yet, so let's do that
                // 12. Set neighbor's distance
                // 13. Set neighbor's previous node
                // 14. Push neighbor to the queue
    }
    if (distanceMap[toNode] == numeric_limits<int>::max())
    {
        cout << "No sequence of one letter transformations exists!" << endl;
        return;
    }
    // 15. Print a suitable error message if no sequence of one letter transformations exists.
    // (Hint: If we haven't visited toNode yet)
    Node* self = toNode;
    Node* prev = prevNodeMap[self];
    vector<pair<Node*,Node::transformation_info>> pairs;
    while (prev != nullptr)
    {
        pairs.push_back({self,prev->neighbours[self]});
        self = prev;
        prev = prevNodeMap[self];
    }
    cout << fromNode->data << endl;
    for (vector<pair<Node*,Node::transformation_info>>::reverse_iterator it=pairs.rbegin();it!=pairs.rend();it++)
    {
        pair<Node*,Node::transformation_info> pair;
        pair = *it;
        cout << pair.first->data << " (" << pair.second.event << " " ;
        if (pair.second.event == "change")
        {
            cout << pair.second.before << " at position " << pair.second.index+1 << " to " << pair.second.after;
        }
        else if (pair.second.event == "insert")
        {
            cout << pair.second.after << " after position " << pair.second.index+1 ;
        }
        else
            cout << pair.second.before << " at position " << pair.second.index+1 ;
        cout << ")" << endl;
    }
    

}
