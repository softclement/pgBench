:: Example: Default TPC-B Test with Output to File and Screen
echo [*] Running Default TPC-B test (10 clients, 2 threads, 60 sec)...
echo Default TPC-B test >> %OUTPUT_FILE%
powershell -Command "pgbench -c 10 -j 2 -T 60 -U %PGBENCH_USER% -h %PGBENCH_HOST% -d %PGBENCH_DB% 2>&1 | Tee-Object -FilePath '%OUTPUT_FILE%' -Append"
echo. >> %OUTPUT_FILE%
