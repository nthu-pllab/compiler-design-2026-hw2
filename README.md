# CS340400 HW2 — Parser

## Repository Structure

```
compiler-design-2026-hw2/
├── docker-compose.yml
├── src/
│   ├── scanner.l       ← YOUR WORK GOES HERE
│   ├── parser.y        ← YOUR WORK GOES HERE
│   └── Makefile        ← do not modify
├── testcases/
│   ├── answers/        ← golden reference outputs
│   ├── array_decl_wo_init.txt
│   ├── expr_1.txt
│   └── ...
└── scripts/
    ├── run_test.sh         ← run all testcases (docker)
    ├── run_parser.sh       ← run your parser (docker)
    ├── run_golden.sh       ← run golden parser (docker)
    └── local_run_test.sh   ← run all testcases (local, no docker)
```

---

## Path A — Develop with Docker (Recommended)

Docker gives you access to `golden_parser`, the reference binary, so you can compare your output directly.

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) or Docker Engine + Compose

### Setup

```bash
docker pull compilerdesign/compiler-design-2026-hw2
```

### Workflow

Edit `src/scanner.l` and `src/parser.y`, then:

**Run all testcases and diff against golden:**
```bash
./scripts/run_test.sh
```

**Run a single testcase:**
```bash
./scripts/run_test.sh array_decl_wo_init
```

**Debug mode — see your output vs golden side by side:**
```bash
./scripts/run_test.sh debug array_decl_wo_init
```

**Run your parser interactively:**
```bash
./scripts/run_parser.sh < testcases/array_decl_wo_init.txt
```

**Run the golden parser interactively:**
```bash
./scripts/run_golden.sh < testcases/array_decl_wo_init.txt
```

**Diff your output against golden:**
```bash
diff <(./scripts/run_parser.sh < testcases/array_decl_wo_init.txt) <(./scripts/run_golden.sh < testcases/array_decl_wo_init.txt)
```

**Drop into a shell inside the container:**
```bash
docker compose run --rm hw2 bash
```

Inside the container you can compile and test manually:
```bash
# compile
cp /hw2/src/scanner.l /hw2/build/
cp /hw2/src/parser.y /hw2/build/
make -C /hw2/build

# run your parser
/hw2/build/parser < /hw2/testcases/array_decl_wo_init.txt

# diff against golden
diff <(/hw2/build/parser < /hw2/testcases/array_decl_wo_init.txt) <(golden_parser < /hw2/testcases/array_decl_wo_init.txt)
```

**Add your own testcases:**

Place any `.txt` file under `testcases/` and it will be picked up automatically by `run_test.sh` and diffed against `golden_parser`.

---

## Path B — Develop Locally (No Docker)

If you have `flex` and `byacc` and `gcc` installed locally, you can develop without Docker. The golden reference outputs are pre-generated in `testcases/answers/` for diffing.

### Prerequisites

```bash
# Ubuntu / Debian
sudo apt install flex byacc gcc make

# macOS
brew install flex byacc
```

### Workflow

Edit `src/scanner.l` and `src/parser.y`, then:

**Run all testcases and diff against pre-generated answers:**
```bash
./scripts/local_run_test.sh
```

**Run a single testcase:**
```bash
./scripts/local_run_test.sh array_decl_wo_init
```

**Debug mode — see your output vs golden answer side by side:**
```bash
./scripts/local_run_test.sh debug array_decl_wo_init
```

> **Note:** Local development diffs against pre-generated answer files in `testcases/answers/`. The grading server always uses the live `golden_parser` binary. If you suspect a discrepancy, use Path A to verify.

---

## Submission

Submit only `src/scanner.l` and `src/parser.y` to the course platform. Do not modify `src/Makefile`.
