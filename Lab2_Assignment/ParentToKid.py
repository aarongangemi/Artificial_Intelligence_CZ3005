from pyswip import Prolog, registerForeign, Atom
import sys
import tkinter as tk
from tkinter import *

prolog = Prolog()
prolog.consult('ParentTalkingToKid.pl')
result = [answer["X"] for answer in prolog.query("ask(X)")]


