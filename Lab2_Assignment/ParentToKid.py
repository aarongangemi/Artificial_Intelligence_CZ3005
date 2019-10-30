from pyswip import Prolog
from tkinter import*
import tkinter as tk
win = tk.Tk()
window = tk.Canvas(win, width=500, height=400)
window.pack()


def solutions():
    prolog = Prolog()
    prolog.consult('ParentTalkingToKid.pl')
    for solution in prolog.query("ask(X)"):
        print(solution["X"])


buttonX = tk.Button(win, text='Start', command=solutions)
window.create_window(150, 150, window=buttonX)


win.mainloop()







