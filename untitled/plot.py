from plistlib import Data

import numpy as np
import plotly.offline as py
import plotly.graph_objs as go
from pylab import *

text = r"E:\Users\Vaitus\workspace\Projekt3\elektron"

text5 = r"E:\Users\Vaitus\workspace\Projekt3\argon"

def makePlot(data1, name, velocity):
    xAxis = np.arange(0,1000001)
    trace = []

    for i in range(0,4):
        trace1 = go.Scatter(
            x=xAxis,
            y=data1[i],
            name="Δt ="+str(i*2 +1)
        )
        trace.append(trace1)
    data = [trace[i] for i in range(0,4)]

    layout = dict(title=name + ' s počáteční rychlostí '+str(velocity), xaxis=dict(title = 'počet průchodů'), yaxis = dict(title = 'relativní rozdíl energie'))

    fig = dict(data=data, layout=layout)
    py.plot(fig, filename=name+"_"+str(velocity))

with open (text + str(1) +r".txt", "r") as myfile:
    velocity = int(float(myfile.readline()))

data1 = []
for i in range(0,4):
    data1.append(genfromtxt(text + str((i*2)+1) + r".txt", usecols=2, skip_header=1))

makePlot(data1, 'elektron', velocity)