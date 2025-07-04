@echo off
setlocal ENABLEDELAYEDEXPANSION

:: === Configuration ===
set PGPASSWORD=123
set PGBENCH_USER=postgres
set PGBENCH_DB=postgres
set PGBENCH_HOST=localhost
set PGBENCH_SCALE=50
set OUTPUT_FILE=pgbench_report.txt

echo ==== PostgreSQL Benchmarking Report > %OUTPUT_FILE%
echo Test Run Date: %DATE% %TIME% >> %OUTPUT_FILE%
echo. >> %OUTPUT_FILE%

:: === Initialization ===
echo [*] Initializing pgbench with scale %PGBENCH_SCALE%...
pgbench -i -s %PGBENCH_SCALE% -U %PGBENCH_USER% -h %PGBENCH_HOST% -d %PGBENCH_DB% >> %OUTPUT_FILE% 2>&1
echo. >> %OUTPUT_FILE%

:: === Test 1: Default TPC-B ===
echo [*] Running Default TPC-B test (10 clients, 2 threads, 60 sec)...
echo Default TPC-B test >> %OUTPUT_FILE%
pgbench -c 10 -j 2 -T 60 -U %PGBENCH_USER% -h %PGBENCH_HOST% -d %PGBENCH_DB% >> %OUTPUT_FILE% 2>&1
echo. >> %OUTPUT_FILE%

:: === Test 2: Read-Only ===
echo [*] Running Read-only test (20 clients, 4 threads, 60 sec)...
echo Read-only test >> %OUTPUT_FILE%
pgbench -S -c 20 -j 4 -T 60 -U %PGBENCH_USER% -h %PGBENCH_HOST% -d %PGBENCH_DB% >> %OUTPUT_FILE% 2>&1
echo. >> %OUTPUT_FILE%

:: === Test 3: Write-Heavy ===
echo [*] Running Write-heavy test (15 clients, 3 threads, 60 sec)...
echo Write-heavy test >> %OUTPUT_FILE%
pgbench -N -c 15 -j 3 -T 60 -U %PGBENCH_USER% -h %PGBENCH_HOST% -d %PGBENCH_DB% >> %OUTPUT_FILE% 2>&1
echo. >> %OUTPUT_FILE%

:: === Test 4: Latency & Progress ===
echo [*] Running latency test with 10s progress report...
echo Latency + Progress report test >> %OUTPUT_FILE%
pgbench -r -P 10 -c 10 -j 2 -T 60 -U %PGBENCH_USER% -h %PGBENCH_HOST% -d %PGBENCH_DB% >> %OUTPUT_FILE% 2>&1
echo. >> %OUTPUT_FILE%

:: === Test 5: High Concurrency ===
echo [*] Running High Concurrency test (100 clients, 10 threads, 60 sec)...
echo High Concurrency test >> %OUTPUT_FILE%
pgbench -c 100 -j 10 -T 60 -U %PGBENCH_USER% -h %PGBENCH_HOST% -d %PGBENCH_DB% >> %OUTPUT_FILE% 2>&1
echo. >> %OUTPUT_FILE%

:: === Test 6: Short Transaction ===
echo [*] Running Single-user short test (1 client, 10,000 txns)...
echo Short transaction test >> %OUTPUT_FILE%
pgbench -t 10000 -c 1 -j 1 -U %PGBENCH_USER% -h %PGBENCH_HOST% -d %PGBENCH_DB% >> %OUTPUT_FILE% 2>&1
echo. >> %OUTPUT_FILE%

echo [✓] All pgbench tests completed. Results saved in %OUTPUT_FILE%.

endlocal
pause
