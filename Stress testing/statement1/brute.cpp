#include<bits/stdc++.h>
using namespace std;
int const D = 25, L = 8;
int mat[D][D], oldM[D][D];
int const dirR[] = {-1, -1, -1, 0, 0, 1, 1, 1};
int const dirC[] = {-1, 0, 1, -1, 1, -1, 0, 1};

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

int main() {
    int n, m, p, k;
    scanf("%d %d %d", &n, &m, &p);
    for (int i = 1; i <= p; ++i) {
        int r, c;
        scanf("%d %d", &r, &c);
        r++, c++;
        mat[r][c] = 1;
    }
    scanf("%d", &k);
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
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= m; ++j) {
            printf("%d ", mat[i][j]);
        }
        puts("");
    }
}
