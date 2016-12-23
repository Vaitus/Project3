import numpy as np
import matplotlib.pyplot as plt

text1 = r"E:\Users\Vaitus\workspace\Projekt3\elektron1.txt"
text2 = r"E:\Users\Vaitus\workspace\Projekt3\elektron2.txt"
text3 = r"E:\Users\Vaitus\workspace\Projekt3\elektron3.txt"

text4 = r"E:\Users\Vaitus\workspace\Projekt3\ar1.txt"
text5 = r"E:\Users\Vaitus\workspace\Projekt3\ar2.txt"
text6 = r"E:\Users\Vaitus\workspace\Projekt3\ar3.txt"

def fileOpening(text):
    data = []
    with open(text, "r") as f:
        for line in f:
            data.append(float(line.replace(" ", "").replace("\n", "")))
    return data
    f.close()

data1 = fileOpening(text1)
data2 = fileOpening(text2)
data3 = fileOpening(text3)

xAxis = []
for i in range(0, 10001):
    xAxis.append(i)

plt.plot(xAxis, data1, label="$\\Delta$t = 3e-17")
plt.plot(xAxis, data2, label="$\\Delta$t = 2e-3")
plt.plot(xAxis, data3, label="$\\Delta$t = 1e-2")

legend = plt.legend(loc='upper center', shadow=True)
legend.get_frame().set_facecolor('#00FFCC')
plt.savefig('elektron.png')
plt.show()

