
import random
import requests
import time
import tkinter as tk
from tkinter import ttk
from tkinter import messagebox
import subprocess
import re
tempoList = [1, 2, 3, 4, 5, 6, 7, 8, 0]

originlist = [1, 2, 3, 4, 5, 6, 7, 8, 0]

root = tk.Tk()
root.title("9*9 blocks")
root.resizable(0, 0)
root.geometry("700x500")
root.columnconfigure(0, weight=1)
root.columnconfigure(1, weight=1)
root.columnconfigure(2, weight=1)


def shuffle():
    for x in range(9):
        global originlist
        selected = random.choice(originlist)
        tempoList[x] = int(selected)
        originlist.remove(selected)
    originlist = [1, 2, 3, 4, 5, 6, 7, 8, 0]
    square1 = ttk.Label(root, text=tempoList[0], font=("Helvetica", 24))
    square2 = ttk.Label(root, text=tempoList[1], font=("Helvetica", 24))
    square3 = ttk.Label(root, text=tempoList[2], font=("Helvetica", 24))
    square4 = ttk.Label(root, text=tempoList[3], font=("Helvetica", 24))
    square5 = ttk.Label(root, text=tempoList[4], font=("Helvetica", 24))
    square6 = ttk.Label(root, text=tempoList[5], font=("Helvetica", 24))
    square7 = ttk.Label(root, text=tempoList[6], font=("Helvetica", 24))
    square8 = ttk.Label(root, text=tempoList[7], font=("Helvetica", 24))
    square9 = ttk.Label(root, text=tempoList[8], font=("Helvetica", 24))
    square1.grid(column=0, row=0, sticky=tk.NW, padx=45, pady=45)
    square2.grid(column=1, row=0, sticky=tk.N, padx=45, pady=45)
    square3.grid(column=2, row=0, sticky=tk.NE, padx=45, pady=45)
    square4.grid(column=0, row=1, sticky=tk.W, padx=45, pady=45)
    square5.grid(column=1, row=1, sticky=tk.NS, padx=45, pady=45)
    square6.grid(column=2, row=1, sticky=tk.E, padx=45, pady=45)
    square7.grid(column=0, row=2, sticky=tk.SW, padx=45, pady=45)
    square8.grid(column=1, row=2, sticky=tk.S, padx=45, pady=45)
    square9.grid(column=2, row=2, sticky=tk.SE, padx=45, pady=45)
    solveButton.grid(column=0, row=3, sticky=tk.S,
                     padx=45, pady=45, ipadx=5, ipady=5)
    resetButton.grid(column=2, row=3, sticky=tk.S,
                     padx=45, pady=45, ipadx=5, ipady=5)
    root.update_idletasks()


def removeSquare(k):
    if k == "square1":
        return 0
    else:
        if k == "square2":
            return 1
        else:
            if k == "square3":
                return 2
            else:
                if k == "square4":
                    return 3
                else:
                    if k == "square5":
                        return 4
                    else:
                        if k == "square6":
                            return 5
                        else:
                            if k == "square7":
                                return 6
                            else:
                                if k == "square8":
                                    return 7
                                else:
                                    if k == "square9":
                                        return 8

def execu():
    
    data = {'domain': open('domain.pddl', 'r').read(),
            'problem': open('problem.pddl', 'r').read()}
    resp = requests.post('http://solver.planning.domains/solve',verify=False, json=data).json()

    with open('result.txt', 'w') as f:
        try:
            f.write('\n'.join([act['name'] for act in resp['result']['plan']]))
        except:
            messagebox.showwarning("error", "no solution")
    #return_code = subprocess.call("./itSIMPLE4.0-beta4/myPlanners/mips-xxl  -o /home/kuzie/Desktop/PDDL/99/domain.pddl -f /home/kuzie/Desktop/PDDL/99/problem.pddl > result.txt", shell=True)
    with open('result.txt', 'r') as file:
        data = file.readlines()
        #match = re.search(r'\d+',(data[len(data)-1]))
        #if match:
        #    numberOfSteps = match.group()
        #else:
        #    print("no solution")
        #    exit()
        #for i in range(len(data)-2-int(numberOfSteps),len(data)-2):
        print(len(data))
        for i in range(len(data)):
            data[i] = re.sub(r"[^a-zA-Z0-9]"," ",data[i])
            squareList = data[i].split(" ")
            temp = tempoList[removeSquare(squareList[4])]
            tempoList[removeSquare(squareList[4])] = tempoList[removeSquare(squareList[5])]
            tempoList[removeSquare(squareList[5])] = temp
            print(squareList[4]+" "+squareList[5])
           
            square1 = ttk.Label(root, text=tempoList[0], borderwidth=3,font=("Helvetica", 24))
            square2 = ttk.Label(root, text=tempoList[1], font=("Helvetica", 24))
            square3 = ttk.Label(root, text=tempoList[2], font=("Helvetica", 24))
            square4 = ttk.Label(root, text=tempoList[3], font=("Helvetica", 24))
            square5 = ttk.Label(root, text=tempoList[4], font=("Helvetica", 24))
            square6 = ttk.Label(root, text=tempoList[5], font=("Helvetica", 24))
            square7 = ttk.Label(root, text=tempoList[6], font=("Helvetica", 24))
            square8 = ttk.Label(root, text=tempoList[7], font=("Helvetica", 24))
            square9 = ttk.Label(root, text=tempoList[8], font=("Helvetica", 24))
            square1.grid(column=0, row=0, sticky=tk.NW, padx=45, pady=45)
            square2.grid(column=1, row=0, sticky=tk.N, padx=45, pady=45)
            square3.grid(column=2, row=0, sticky=tk.NE, padx=45, pady=45)
            square4.grid(column=0, row=1, sticky=tk.W, padx=45, pady=45)
            square5.grid(column=1, row=1, sticky=tk.NS, padx=45, pady=45)
            square6.grid(column=2, row=1, sticky=tk.E, padx=45, pady=45)
            square7.grid(column=0, row=2, sticky=tk.SW, padx=45, pady=45)
            square8.grid(column=1, row=2, sticky=tk.S, padx=45, pady=45)
            square9.grid(column=2, row=2, sticky=tk.SE, padx=45, pady=45)
            solveButton.grid(column=0, row=3, sticky=tk.S,
                            padx=45, pady=45, ipadx=5, ipady=5)
            resetButton.grid(column=2, row=3, sticky=tk.S,
                            padx=45, pady=45, ipadx=5, ipady=5)  
            root.update()  
            time.sleep(1)

def FromIntToWord(k):
    if k == 1:
        return "one"
    else:
        if k == 2:
            return "two"
        else:
            if k == 3:
                return "three"
            else:
                if k == 4:
                    return "four"
                else:
                    if k == 5:
                        return "five"
                    else:
                        if k == 6:
                            return "six"
                        else:
                            if k == 7:
                                return "seven"
                            else:
                                if k == 8:
                                    return "eight"
                                else:
                                    if k == 0:
                                        return "space"


def changeProblemFile():
    with open('problem.pddl', 'r') as file:
        data = file.readlines()
    data[21] = '    (at square1 ' + FromIntToWord(tempoList[0]) + ')(at square2 ' + FromIntToWord(tempoList[1]) + ')(at square3 ' + FromIntToWord(tempoList[2]) + ')(at square4 ' + \
        FromIntToWord(tempoList[3])+')(at square5 '+FromIntToWord(tempoList[4])+')(at square6 '+FromIntToWord(tempoList[5])+')(at square7 ' + FromIntToWord(tempoList[6])+')(at square8 '+FromIntToWord(tempoList[7]) + ')(at square9 '+FromIntToWord(tempoList[8]) + ')\n'
    with open('problem.pddl', 'w') as file:
        file.writelines(data)


def resetcomm():
    shuffle()
    changeProblemFile()


square1 = ttk.Label(root, text=tempoList[0], font=("Helvetica", 24))
square2 = ttk.Label(root, text=tempoList[1], font=("Helvetica", 24))
square3 = ttk.Label(root, text=tempoList[2], font=("Helvetica", 24))
square4 = ttk.Label(root, text=tempoList[3], font=("Helvetica", 24))
square5 = ttk.Label(root, text=tempoList[4], font=("Helvetica", 24))
square6 = ttk.Label(root, text=tempoList[5], font=("Helvetica", 24))
square7 = ttk.Label(root, text=tempoList[6], font=("Helvetica", 24))
square8 = ttk.Label(root, text=tempoList[7], font=("Helvetica", 24))
square9 = ttk.Label(root, text=tempoList[8], font=("Helvetica", 24))
solveButton = ttk.Button(root, text="solve",command=execu)
resetButton = ttk.Button(root, text="reset", command=resetcomm)


square1.grid(column=0, row=0, sticky=tk.NW, padx=45, pady=45)
square2.grid(column=1, row=0, sticky=tk.N, padx=45, pady=45)
square3.grid(column=2, row=0, sticky=tk.NE, padx=45, pady=45)
square4.grid(column=0, row=1, sticky=tk.W, padx=45, pady=45)
square5.grid(column=1, row=1, sticky=tk.NS, padx=45, pady=45)
square6.grid(column=2, row=1, sticky=tk.E, padx=45, pady=45)
square7.grid(column=0, row=2, sticky=tk.SW, padx=45, pady=45)
square8.grid(column=1, row=2, sticky=tk.S, padx=45, pady=45)
square9.grid(column=2, row=2, sticky=tk.SE, padx=45, pady=45)
solveButton.grid(column=0, row=3, sticky=tk.S,
                 padx=45, pady=45, ipadx=5, ipady=5)
resetButton.grid(column=2, row=3, sticky=tk.S,
                 padx=45, pady=45, ipadx=5, ipady=5)
root.mainloop()
