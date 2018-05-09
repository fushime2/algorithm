// O(n^2)
using Dist = double;
const VMAX = 1010;
Dist cost[VMAX][VMAX];
vector<Dist> dijkstra(int s) {
    vector<Dist> d(n, INF); d[s] = 0;
    vector<int> used(n, 0);
    while (1) {
        int v = -1;
        for (int to = 0; to < n; to++) if (!used[to] && (v == -1 || d[to] < d[v])) v = to;
        if (v == -1) break;
        used[v] = 1;
        for (int to = 0; to < n; to++) {
            Dist nd = d[v] + cost[v][to];
            if (nd < d[to]) d[to] = nd;
        }
    }
    return d;
}

// O(|E| log |V|)
using Dist = ll; using Vertex = int;
using Pair = pair<Dist, Vertex>;
struct edge { Vertex to; Dist cost; };
using Graph = vector<vector<edge>>;
vector<Dist> dijkstra(const Graph& G, Vertex s) {
    priority_queue<Pair, vector<Pair>, greater<Pair>> pq;
    vector<Dist> d(N, INFLL); d[s] = 0;
    pq.push(Pair(0, s));
    while (pq.size()) {
        Pair p = pq.top(); pq.pop();
        Vertex v = p.second;
        if (d[v] < p.first) continue;
        for (const edge& e : G[v]) {
            Dist nd = d[v] + e.cost;
            if (d[e.to] > nd) {
                d[e.to] = nd;
                pq.push(Pair(d[e.to], e.to));
            }
        }
    }
    return d;
}