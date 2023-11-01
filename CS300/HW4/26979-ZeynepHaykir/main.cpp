//
//  main.cpp
//  26979-ZeynepHaykir
//  CS300 - HW4 - Word-Graphs
//  Created by Zeynep HAYKIR on 2021-12-12.
//

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include "graph.hpp"

using namespace std;

int main()
{
    /**
     * You will read from a file called words.txt the words that you will use as your database. The
     * words will not be in any particular order and may contain characters such as “-” or
     * apostrophe (‘) – these should not cause any problems.
     *
     * The file words.txt which contains the words of the dictionary will have one word per line.
     * All the letter characters will be small; no capital letters.
     */
    string word_file = "words.txt";
    ifstream input(word_file);
    if (input.fail()){
        cout << "The words.txt file was not found. Exiting." << endl;
        return 1;
    }
    vector<string> vectorOfStr;
    string str;
    while (getline(input, str))
    {
        // Line contains string of length > 0 then save it in vector
        if(str.size() > 0)
            vectorOfStr.push_back(str);
    }
    
    
    string firstword,secondword;
    
    for (int i=0; i< vectorOfStr.size(); i++)
    {
        firstword = vectorOfStr[i];
        cout << firstword << endl;
    }
    //Close The File
    input.close();
    /**
     * Once the file is read and processed,
     * you will then go into a loop that does the following:
     */
    // 1. Create a Graph object
    Graph graph;

    vector<string>::iterator it_;
    // 2. Fill the graph with the words in words.txt
    for (it_=vectorOfStr.begin(); it_!=vectorOfStr.end() ; it_++)
    {
        graph.addNode(*it_);
    }
    while (true)
    {
        cout << "Please enter two words: " ;
        cin >> firstword >> secondword;
        cout << firstword << " " << secondword << endl;
        /**
         * If the first word starts with the character ‘*’ then exit the loop and terminate the
         * program.
         *
         * Hint: String is an array of characters.
         */
        if (firstword[0]=='*')
        {
            exit(0);
        }
        /**
         * Make sure both words are in the list; print an error message if either one is not in
         * the list.
         *
         * Hint: std::find() from "algorithm" standard library (https://en.cppreference.com/w/cpp/algorithm/find).
         * This function returns an iterator. If iterator is equal to .end() it means that
         * database does not contain what we are looking for.
         */
        vector<string>::iterator it = find(vectorOfStr.begin(), vectorOfStr.end(), firstword);
        if (it == vectorOfStr.end())
        {
            cout << "The word does not exist!" << endl;
            continue;
        }
        vector<string>::iterator secondit = find(vectorOfStr.begin(), vectorOfStr.end(), secondword);
        if (secondit == vectorOfStr.end())
        {
            cout << "The word does not exist!" << endl ;
            continue;
        }
        
        
        // 3. Call graph's function to find the shortest path from firstword to secondword
        graph.findShortestPath(firstword, secondword);
    }
    
    
    
    
    return 0;
}
