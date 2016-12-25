from plistlib import Data

import numpy as np
import plotly.offline as py
import plotly.graph_objs as go
from pylab import *

text1 = r"E:\Users\Vaitus\workspace\Projekt3\elektron1.txt"
text2 = r"E:\Users\Vaitus\workspace\Projekt3\elektron2.txt"
text3 = r"E:\Users\Vaitus\workspace\Projekt3\elektron3.txt"
text4 = r"E:\Users\Vaitus\workspace\Projekt3\elektron4.txt"

text5 = r"E:\Users\Vaitus\workspace\Projekt3\ar1.txt"
text6 = r"E:\Users\Vaitus\workspace\Projekt3\ar2.txt"
text7 = r"E:\Users\Vaitus\workspace\Projekt3\ar3.txt"
text8 = r"E:\Users\Vaitus\workspace\Projekt3\ar4.txt"


def makePlot(data1, data2, data3, data4, name, velocity):
    xAxis = np.arange(0,10001)

    trace0 = go.Scatter(
        x=xAxis,
        y=data1,
        name="Δt = 3e-13"
    )
    trace1 = go.Scatter(
        x=xAxis,
        y=data2,
        name="Δt = 3e-10"
    )
    trace2 = go.Scatter(
        x=xAxis,
        y=data3,
        name="Δt = 3e-3"
    )
    trace3 = go.Scatter(
        x=xAxis,
        y=data4,
        name="Δt = 1e-2"
    )
    data = [trace0, trace1, trace2, trace3]
    layout = dict(title=name + ' s počáteční rychlostí '+str(velocity), xaxis=dict(title = 'počet průchodů'), yaxis = dict(title = 'rozdíl energie'))

    fig = dict(data=data, layout=layout)
    py.plot(fig, filename=name+"_"+str(velocity))


data1 = genfromtxt(text1)
data2 = genfromtxt(text2)
data3 = genfromtxt(text3)
data4 = genfromtxt(text4)

makePlot(data1, data2, data3, data4, 'elektron', 10000)

data1 = genfromtxt(text5)
data2 = genfromtxt(text6)
data3 = genfromtxt(text7)
data4 = genfromtxt(text8)

makePlot(data1, data2, data3, data4, 'argon', 10000)
"""
xAxis = []
for i in range(0, 10001):
    xAxis.append(i)
"""
