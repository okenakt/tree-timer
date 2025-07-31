"""Example 4: Combined use with parallel execution.

Uses add_scope() for sequential stages and add_series() for parallel tasks
via ThreadPoolExecutor.
"""

import time
from concurrent.futures import ThreadPoolExecutor

from tree_timer import TreeTimer


def run_task(timer: TreeTimer) -> None:  # noqa
    with timer:
        time.sleep(0.03)


with TreeTimer() as timer:
    with timer.add_scope("pipeline") as pipeline:
        with pipeline.add_scope("load"):
            time.sleep(0.02)

        steps = pipeline.add_series("parallel_steps", 4)
        with ThreadPoolExecutor() as executor:
            executor.map(run_task, steps)

        with pipeline.add_scope("finalize"):
            time.sleep(0.01)

print(timer)
