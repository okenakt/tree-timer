"""Example 2: Nested scopes with add_scope().

Measures multiple named sequential blocks.
"""

import time

from tree_timer import TreeTimer

with TreeTimer() as timer:
    with timer.add_scope("load_data"):
        time.sleep(0.05)
    with timer.add_scope("process_data"):
        time.sleep(0.08)

print(timer)
