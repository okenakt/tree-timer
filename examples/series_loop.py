"""Example 3: Loop timing with add_series().

Measures multiple steps in a for-loop using add_series().
"""

import time

from tree_timer import TreeTimer

with TreeTimer() as timer:
    steps = timer.add_series("steps", 3)
    for step in steps:
        with step:
            time.sleep(0.03)

print(timer)
