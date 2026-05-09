# Hardware

**Read this before** planning local ML/inference work, choosing model sizes, deciding what fits in memory, or recommending hardware-bound tradeoffs.

MacBook Pro (Mac16,5) — Apple M4 Max, maximum spec (except storage).

| Component | Spec |
|-----------|------|
| **CPU** | M4 Max — 16 cores (12P + 4E) |
| **GPU** | 40-core Apple GPU, Metal 4 |
| **Neural Engine** | 16-core |
| **Memory** | 128 GB unified (546 GB/s bandwidth) |
| **Storage** | 2 TB APFS SSD |
| **Display** | 16" Liquid Retina XDR, 3456×2234 |
| **OS** | macOS 26 (Tahoe) arm64 |

## Implications for local ML/inference

- 128 GB unified memory can hold ~60B parameter models (Q4 quantised) entirely in memory — no GPU offloading needed since CPU and GPU share the same RAM.
- 546 GB/s memory bandwidth makes token generation fast for local LLMs.
- 40 GPU cores accelerate matrix operations (embedding generation, inference).
- For embedding workloads (~1M vectors at 768d): brute-force cosine search is feasible in-memory (~3 GB). sqlite-vec or HNSW index for sub-millisecond KNN.
