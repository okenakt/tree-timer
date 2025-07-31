"""Example 1: Simple use.

Measures the total time of a single block.
"""

import time

from tree_timer import TreeTimer

with TreeTimer() as timer:
    time.sleep(0.1)

print(timer)
