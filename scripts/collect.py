import os
import sys
from math import log10
from subprocess import run

here = os.path.join(os.path.dirname(__file__))
hub_stress_test = os.path.join(here, "hub-stress-test.py")


def active_counts(total_count, limit=None):
    active_count = 0
    yield active_count
    if total_count == 0:
        return

    batches = [1, 2, 5]
    multiplier = 10 ** max([round(log10(total_count)) - 2, 0])
    if limit is None:
        limit = total_count
    else:
        limit = min([total_count, limit])
    while active_count < limit:
        for n in batches:
            active_count = n * multiplier
            if active_count >= limit:
                yield limit
                return

            yield active_count
            if active_count == limit:
                return
        multiplier *= 10


def main():
    run([sys.executable, hub_stress_test, "purge"], check=True)
    for total_count in [0, 10, 100, 200, 500, 1000, 2000, 5000, 10000]:
        print(total_count, list(active_counts(total_count, limit=1000)))
        for active_count in active_counts(total_count, limit=1000):
            print(f"Running test with {active_count}/{total_count}")
            log_file = f"{total_count:05}-{active_count:05}.txt"
            p = run(
                [
                    sys.executable,
                    hub_stress_test,
                    "--log-to-file",
                    log_file,
                    "user-stress-test",
                    "-t",
                    str(total_count),
                    "-c",
                    str(active_count),
                    "-b",
                    "20",
                    "--keep",
                ],
            )
            if p.returncode:
                print("Failed!")
                with open(log_file) as f:
                    sys.stderr.write(f.read())
                sys.exit(1)
        run([sys.executable, hub_stress_test, "purge"], check=True)


if __name__ == "__main__":
    main()
