from inspect import signature
from lmfit import Parameter, Parameters, minimize, report_fit
import matplotlib.pyplot as plt

def wrap(f):
    res = lambda p, x, y: f(x, y, *[p.value for p in p.values()])
    res.params = list(signature(f).parameters.keys())[2:]
    return res

def fit(f, xs, ys, *args):
    params = Parameters()

    for p in args:
        params.add(p)

    for p in f.params:
        if not params.__contains__(p):
            params.add(p, value = 0)

    fit = minimize(f, params, args=(xs, ys))
    report_fit(fit.params)
    return fit

def plot(f, res, xs, *args, **kwargs):
    plt.plot(xs, f(res.params, xs, 0), *args, **kwargs)

class p(Parameter):
    def __init__(self, name):
        super().__init__(name)
        self.set(value = 0)

    def init(self, x):
        self.set(value = x)
        return self

    def lo(self, x):
        self.set(min = x)
        return self

    def hi(self, x):
        self.set(max = x)
        return self
