#include<bits/stdc++.h>
using namespace std;
int const D = 25, L = 8;
int mat[D][D], oldM[D][D];
int const dirR[] = {-1, -1, -1, 0, 0, 1, 1, 1};
int const dirC[] = {-1, 0, 1, -1, 1, -1, 0, 1};
string hexSymbols = "0123456789ABCDEF";

int getNumFromHex(char ch) {
    int num = (int) ch;
    if (num > 60) {
        return num - 55;
    }
    return num - 48;
}

int getState(int r, int c) {
    int ans = 0;
    for (int i = 0; i < L; ++i) {
        ans += oldM[r + dirR[i]][c + dirC[i]];
    }
    if (ans == 3) {
        return 1;
    } else if (ans == 2) {
        return oldM[r][c];
    }
    return 0;
}

void xorTheArrays(vector<int>& bits, int R, int C) {
    int len = bits.size(), matSize = R * C;
    for (int i = 0; i < len; ++i) {
        int matPos = i % matSize;
        int currR = matPos / C, currC = matPos % C;
        bits[i] ^= mat[currR][currC];
    }
}

int main() {
    int n, m, p, k, t;
    scanf("%d %d %d", &n, &m, &p);
    printf("%d\n%d\n%d\n", n, m, p);
    for (int i = 1; i <= p; ++i) {
        int r, c;
        scanf("%d %d", &r, &c);
        printf("%d\n%d\n", r, c);
        r++, c++;
        mat[r][c] = 1;
    }
    scanf("%d %d", &k, &t);
    printf("%d\n%d\n", k, t);
    string message;
    cin >> message;
    for (int iter = 1; iter <= k; ++iter) {
        for (int ir = 1; ir <= n; ++ir) {
            for (int ic = 1; ic <= m; ++ic) {
                oldM[ir][ic] = mat[ir][ic];
            }
        }
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                mat[i][j] = getState(i, j);
            }
        }
    }
    vector<int> bits;
    if (t == 0) {
        cout << message << '\n';
        return 0;
    }
    for (int i = 0; i < (int) message.size(); ++i) {
        int num = message[i];
        for (int j = 7; j >= 0; --j) {
            bits.push_back((num >> j) & 1);
        }
    }
    xorTheArrays(bits, n + 2, m + 2);
    printf("0x");
    int len = bits.size();
    for (int i = 0; i < len; i += 4) {
        int num = 0;
        for (int j = 0; j < 4; ++j) {
            num |= bits[i + j] << (3 - j);
        }
        printf("%c", hexSymbols[num]);
    }
    puts("");
    fflush(0);
    return 0;
}