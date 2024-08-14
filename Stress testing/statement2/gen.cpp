#include <bits/stdc++.h>
using namespace std;
mt19937 rnd(chrono::steady_clock::now().time_since_epoch().count());

const string hexSymbols = "0123456789ABCDEF";
pair<int, int> const TEST_D = {1, 18};
pair<int, int> const TEST_K = {1, 5};
pair<int, int> const STR_LEN = {1, 10};

int genRandomBetween(int a, int b) {
    return a + rnd() % (b - a + 1);
}

string convertStringToHex(string s) {
    string ans = "0x";
    for (char ch : s) {
        int num = (int) ch;
        ans += hexSymbols[num >> 4];
        ans += hexSymbols[num % 16];
    }
    return ans;
}

int main(int argc, char* argv[]) {
    int n = genRandomBetween(TEST_D.first, TEST_D.second);
    int m = genRandomBetween(TEST_D.first, TEST_D.second);
    int k = genRandomBetween(TEST_K.first, TEST_K.second);
    int p = 0, t = strcmp(argv[1], "1") == 0;
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
    printf("%d\n", t);
    string input;
    if (t == 0) {
        int strLen = genRandomBetween(STR_LEN.first, STR_LEN.second);
        for (int i = 0; i < strLen; ++i) {
            input += (char) genRandomBetween(33, 122);
        }
    } else {
        input = "0x";
        int strLen = 2 * genRandomBetween(STR_LEN.first, STR_LEN.second);
        for (int i = 0; i < strLen; ++i) {
            input += hexSymbols[genRandomBetween(0, 15)];
        }
    }
    cout << input << '\n';
    return 0;
}