#include <iostream>
#include <chrono>
#include <random>
#include <string>
#include <vector>
using namespace std;
mt19937 rnd(chrono::steady_clock::now().time_since_epoch().count());

pair<int, int> const TEST_D = {1, 18};
pair<int, int> const TEST_K = {1, 5};

int genRandomBetween(int a, int b) {
    return a + rnd() % (b - a + 1);
}

int main() {
    int n = genRandomBetween(TEST_D.first, TEST_D.second);
    int m = genRandomBetween(TEST_D.first, TEST_D.second);
    int k = genRandomBetween(TEST_K.first, TEST_K.second);
    int p = 0;
    vector<pair<int, int>> pairs;
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            int elem = genRandomBetween(0, 1);
            p += elem;
            if (elem) {
                pairs.push_back({i, j});
            }
        }
    }
    printf("%d\n%d\n%d\n", n, m, p);
    for (pair<int, int> currP : pairs) {
        printf("%d\n%d\n", currP.first, currP.second);
    }
    printf("%d\n", k);
    return 0;
}