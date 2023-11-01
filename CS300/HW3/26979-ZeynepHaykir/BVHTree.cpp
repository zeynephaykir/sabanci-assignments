#include "BVHTree.h"

void BVHTree::printNode(std::ostream &out, BVHTreeNode *node, int level) {
	if (root == nullptr) return;
	for (int i = 0; i < level; i++) {
		out << "  ";
	}
	if (!node->isLeaf) {
		out << "+ branch || ";
		node->aabb.printAABB(out);
		out << std::endl;
		printNode(out, node->rightChild, level + 1);
		printNode(out, node->leftChild, level + 1);
	}
	else {
		out << "- ";
		if (node->parent) {
			if (node->parent->rightChild == node)
				out << "R ";
			else
				out << "L ";
		}
		out << "- leaf: " << node->name << " || ";
		node->aabb.printAABB(out);
		out << std::endl;
	}
}
BVHTree::BVHTree()
{
    root = nullptr;
}
BVHTree::~BVHTree()
{
    recursiveDelete(root);
}
void BVHTree::recursiveDelete(BVHTreeNode* node)
{
    if (node == nullptr)
    {
        return;
    }
    recursiveDelete(node->leftChild);
    recursiveDelete(node->rightChild);
    delete node;
}
std::pair<int , BVHTreeNode*> BVHTree::findMinincreaseInTreeSize(BVHTreeNode* node, AABB kare)
{
    if (node->isLeaf)
    {
        return {AABB::unionArea(node->aabb,kare) - node->aabb.getArea(),node};
    }
    int increaseInRightTreeSize = AABB::unionArea(kare,node->rightChild->aabb) - node->rightChild->aabb.getArea();
    int increaseInLeftTreeSize = AABB::unionArea(kare,node->leftChild->aabb) - node->leftChild->aabb.getArea();
    return findMinincreaseInTreeSize(increaseInRightTreeSize < increaseInLeftTreeSize ? node->rightChild:node->leftChild,kare);
}

void BVHTree::addBVHMember(AABB objectArea, std::string name)
{
    BVHTreeNode* newNode = new BVHTreeNode(objectArea, name, true);
    if (!(root))
    {
        root = newNode;
    }
    
    else if(root->leftChild == nullptr)
    {
        BVHTreeNode* oldRoot = root;
        BVHTreeNode* newRoot = new BVHTreeNode(objectArea+root->aabb, "branch", false);
        newRoot->leftChild = newNode;
        newRoot->rightChild = oldRoot;
        newNode->parent = newRoot;
        oldRoot->parent = newRoot;
        root = newRoot;
    }
    else
    {
        BVHTreeNode* existingLeaf = findMinincreaseInTreeSize(root,newNode->aabb).second;
        BVHTreeNode* newBranch = new BVHTreeNode(objectArea+existingLeaf->aabb, "branch", false);
        if (existingLeaf->isLeftChild())
        {
            existingLeaf->parent->leftChild = newBranch;
        }
        else
            existingLeaf->parent->rightChild = newBranch;
        
        newBranch->parent = existingLeaf->parent;
        newBranch->leftChild = newNode;
        newBranch->rightChild = existingLeaf;
        newNode->parent = newBranch;
        existingLeaf->parent = newBranch;
        BVHTreeNode* currentParent = newBranch->parent;
        
        while (!(currentParent==nullptr)){
            currentParent->aabb = currentParent->aabb+ objectArea;
            currentParent = currentParent->parent;
        }   
        
    }
    map.insert({name,newNode});
}
void BVHTree::removeBVHMember(std::string name)
{
    std::unordered_map<std::string, BVHTreeNode *>::iterator it ;
    it = map.find(name) ;
    if (it==map.end())
    {
        return;
    }

    BVHTreeNode* toRemove = it->second;
    if (toRemove==root) // if it is the root
    {
        map.erase(it);
        root = nullptr;
        return;
    }
    
    BVHTreeNode* grandparent = toRemove->parent->parent;
    BVHTreeNode* sibling;
    if (toRemove->isLeftChild())
    {
        sibling = toRemove->parent->rightChild;
    }
    else
        sibling = toRemove->parent->leftChild;
    
    sibling->parent = grandparent;
    
    if (grandparent) // if we have a grandparent (parent is not the root),then destroy the parent and connect the sibling to the grandparent
    {
        if (toRemove->parent->isLeftChild())
        {
            grandparent->leftChild = sibling;
        }
        else
            grandparent->rightChild = sibling;
        while (grandparent!= nullptr)
        {
            grandparent->aabb = grandparent->leftChild->aabb + grandparent->rightChild->aabb;
            grandparent=grandparent->parent;
        }
    }
    /*
    else // if we have no grandparent then the parent is the root and so our sibling becomes the root and has it's parent removed
    {
        
    }
    */
    if (toRemove->parent == root)
    {
        root = sibling;
    }
    
    map.erase(it);
}

void BVHTree::moveBVHMember(std::string name, AABB newLocation)
{
    std::unordered_map<std::string, BVHTreeNode *>::iterator it ;
    it = map.find(name) ;
    if (it==map.end())
    {
        return;
    }

    BVHTreeNode* toMove = it->second;
    BVHTreeNode* parent = toMove->parent;
    if (parent == nullptr)
    {
        toMove->aabb = newLocation;
        return;
    }
    if (AABB::unionArea(parent->aabb, newLocation)==parent->aabb.getArea())
    {
        toMove->aabb = newLocation;
        return;
    }
    removeBVHMember(name);
    addBVHMember(newLocation, name);
}

void BVHTree::collisionCheck(BVHTreeNode* node, AABB object,std::vector<std::string>& collidingObjects)
{
    if (node == nullptr)
    {
        return;
    }
    if (!(node->aabb.collide(object)))
    {
        return;
    }
    if (node->isLeaf)
    {
        collidingObjects.push_back(node->name);
    }
    else
    {
        collisionCheck(node->leftChild, object, collidingObjects);
        collisionCheck(node->rightChild, object, collidingObjects);
    }
}

std::vector<std::string> BVHTree::getCollidingObjects(AABB object)
{
    /*  push the root into vec
        while (!(stack empty)):
            check and see if the node intersects with the object
            if it does
                if it is a leaf node then it is a match for a collision and add it to the list of col.
                if it is a branch node then move down to children (left and right) on to the stack*/
    std::vector<std::string> collidingObjects;
    collisionCheck(root, object, collidingObjects);
    return collidingObjects;
}

std::ostream &operator<<(std::ostream &out, BVHTree &tree) {
	tree.printNode(out, tree.root, 0);
	return out;
}
