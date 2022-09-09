import numpy as np
from typing import Optional


class model:
    def __init__(self):
        self._coeff = 0

    def train(self, x, y):
        return np.mean(y - x)

    def predict(self, x, y: Optional[np.ndarray] = None):
        return x + self._coeff

    def assess(self, x, y_true):
        y_pred = self.predict(x)
        return y_pred - y_true
