#include<iostream>
#include <vector>
#include <list>
#include <algorithm>
#include <stdexcept>
using namespace std;
const int NUM_OP = 5;//number of operators
const int NUM_ROWS = 3;
const int NUM_COL = 3;
enum Op {//operators 
	SUCK, LEFT, RIGHT, UP, DOWN
};

struct Pos {//we will use this struct to store the position of the vacum cleaner
	int x,y;// x and y can take the values 0,1 and 2.
	Pos (int x1, int y1): x(x1),y(y1){}
	Pos(){}
};

struct Node {
	Node* parent;//pointer to the parent
	Op op_parent;//this is the operator that the father executed for generating this node
	int num_dirt;//number of dirts
	Pos vc_pos;//vacuum cleaner position
	vector<vector<int>> state; //when there is a 0->empty, 1->dirt, 2->vacum cleaner, 3->vacuum cleaner and dirt
	Node( int dirt, const vector<vector<int>>& st,Pos pos):state(st),num_dirt(dirt),vc_pos(pos),parent(NULL) {}
	Node() {};
	bool operator ==(const Node& other) const {// when it is checked if a node is already in the closed or open list it will be only checked if the state matrix is or is not the same as one in the lists.
		return state == other.state;
	}
};

struct DFS {
	Node actual;//actual Node we are about to expand
	list<Node> open;//open list
	list<Node> closed;//closed list
	DFS(Node act) {
	  open.push_back(act);
	}
	void dfs_search() {
		Node aux;
		bool solution = false;// if solution is true meand we will have reached to a final state
		while (!open.empty() && !solution) {
			actual = open.front();
			open.pop_front();
			if (actual.num_dirt == 0) {
				recover_solution(actual);
				solution = true;
			}
			else {
				generate_nodes();// if we have not reached to a solution we expand the actual node
			}
		}
		if (!solution) cout << "SOLUTION NOT FOUND\n";
	}
	void generate_nodes() {
		Node aux;
		closed.push_back(actual);
		if (posible(SUCK)) {
			aux = actual;
			aux.state[actual.vc_pos.x][actual.vc_pos.y] = 2;//now there is no dirt but only the vacuum cleaner in that position
			aux.num_dirt--;
			aux.op_parent = SUCK;
			auto it = std::prev(closed.end());
			aux.parent = &(*it);// we store a pointer to the parent
			if (!in_a_list(aux)) {
				open.push_back(aux);// if the node is not in any list we add it to the open list
			}
		}
		if (posible(LEFT)) {
			aux = actual;
			if (aux.state[actual.vc_pos.x][aux.vc_pos.y] == 2)aux.state[aux.vc_pos.x][aux.vc_pos.y] = 0;//the position in which there is the vacuum clenaer will be now empty
			else aux.state[aux.vc_pos.x][aux.vc_pos.y] = 1;
			aux.vc_pos.y--;
			if (aux.state[aux.vc_pos.x][aux.vc_pos.y] == 1) aux.state[aux.vc_pos.x][aux.vc_pos.y] = 3;// is there was dirt in the actual position of the vacuum cleaner now we have to codify it as there is dirt and the vacuum cleaner
			else aux.state[aux.vc_pos.x][aux.vc_pos.y] = 2;// if not there will be only the vacuum cleaner
			aux.op_parent = LEFT;
			auto it = std::prev(closed.end());
			aux.parent = &(*it);
			if (!in_a_list(aux)) open.push_back(aux);
		}
		if (posible(RIGHT)) {
			aux = actual;
			if (aux.state[actual.vc_pos.x][aux.vc_pos.y] == 2)aux.state[aux.vc_pos.x][aux.vc_pos.y] = 0;
			else aux.state[aux.vc_pos.x][aux.vc_pos.y] = 1;
			aux.vc_pos.y++;
			if (aux.state[aux.vc_pos.x][aux.vc_pos.y] == 1) aux.state[aux.vc_pos.x][aux.vc_pos.y] = 3;
			else aux.state[aux.vc_pos.x][aux.vc_pos.y] = 2;
			aux.op_parent = RIGHT;
			auto it = std::prev(closed.end());
			aux.parent = &(*it);
			if (!in_a_list(aux)) open.push_back(aux);
		}
		if (posible(UP)) {
			aux = actual;
			if (aux.state[aux.vc_pos.x][aux.vc_pos.y] == 1) aux.state[aux.vc_pos.x][aux.vc_pos.y] = 3;
			else aux.state[aux.vc_pos.x][aux.vc_pos.y] = 2;
			aux.vc_pos.x--;
			if (aux.state[aux.vc_pos.x][aux.vc_pos.y] == 1) aux.state[aux.vc_pos.x][aux.vc_pos.y] = 3;
			else aux.state[aux.vc_pos.x][aux.vc_pos.y] = 2;
			aux.op_parent = UP;
			auto it = std::prev(closed.end());
			aux.parent = &(*it);
			if (!in_a_list(aux)) open.push_back(aux);
		}
		if (posible(DOWN)) {
			aux = actual;
			if (aux.state[actual.vc_pos.x][aux.vc_pos.y] == 2)aux.state[aux.vc_pos.x][aux.vc_pos.y] = 0;
			else aux.state[aux.vc_pos.x][aux.vc_pos.y] = 1;
			aux.vc_pos.x++;
			if (aux.state[aux.vc_pos.x][aux.vc_pos.y] == 1) aux.state[aux.vc_pos.x][aux.vc_pos.y] = 3;
			else aux.state[aux.vc_pos.x][aux.vc_pos.y] = 2;
			aux.op_parent = DOWN;
			auto it = std::prev(closed.end());
			aux.parent = &(*it);
			if (!in_a_list(aux)) open.push_back(aux);
		}
	}
  
	bool in_a_list(Node node) {// we check if it's in the open or in the closed list
		auto it1 = find(open.begin(), open.end(), node);
		if (it1 != open.end()) return true;
		auto it2 = find(closed.begin(), closed.end(), node);
		if (it2 != closed.end()) return true;
		return false;
	}

	bool posible(Op oper) {// we check if it is posible executing the operator oper from the actual position of the vacuum clenaner 
		if (oper == LEFT) {
			if (actual.vc_pos.y > 0) return true;
			else return false;
		}
		else if (oper == RIGHT) {
			if (actual.vc_pos.y < NUM_COL - 1) return true;
			else return false;
		}
		else if (oper == UP) {
			if (actual.vc_pos.x > 0) return true;
			else return false;
		}
		else if (oper == DOWN) {
			if (actual.vc_pos.x < NUM_ROWS - 1) return true;
			else return false;
		}
		else {
			if (actual.state[actual.vc_pos.x][actual.vc_pos.y] == 3) return true;//if there is dirt in that position we can suck
			else return false;// if there is no dirt to suck we won't generate other node that is equal as this one
		}
	}

	void recover_solution(Node solution) {// in this function we recover the solution with the help of the pointer to the parent
		cout << "The robot executes as follows:" << endl;
		list<Op> operations;
		while (solution.parent != NULL) {
			operations.push_front(solution.op_parent);
			solution = *solution.parent;
		}
		while (!operations.empty()) {
			decodify(operations.front());
			operations.pop_front();
		}
	}

	void decodify(Op oper) {
		switch (oper)
		{
		case SUCK:
			cout << "SUCK" << endl;
			break;
		case LEFT:
			cout << "LEFT" << endl;
			break;
		case RIGHT:
			cout << "RIGHT" << endl;
			break;
		case UP:
			cout << "UP" << endl;
			break;
		case DOWN:
			cout << "DOWN" << endl;
			break;
		}
	}
};

int main() {
	cout << "Enter the data of the initial state" << endl;
	vector<vector<int>> state(NUM_ROWS, vector<int>(NUM_COL));
	char aux;
	int num_dirt = 0;
	Pos position;//initial position of the vacuum cleaner
		for (int i = 0; i < NUM_ROWS; i++) {
			for (int j = 0; j < NUM_COL; j++) {
				cin >> aux;
				if (aux == '_') state[i][j] = 0;
				else if (aux == '*') {
					state[i][j] = 1;
					num_dirt++;
				}
				else if (aux == 'R') {
					state[i][j] = 2;
					position.x = i;
					position.y = j;
				}
			}
		}

		Node initial_state(num_dirt, state, position);
		DFS search(initial_state);
		search.dfs_search();

}
