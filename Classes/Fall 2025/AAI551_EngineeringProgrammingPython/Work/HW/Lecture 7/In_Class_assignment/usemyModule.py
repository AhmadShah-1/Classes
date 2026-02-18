import myModule
import matplotlib.pyplot as plt

data = myModule.myScores()
students = []
averages = []

for student, avg in data.items():
    students.append(student)
    averages.append(avg)
    print(student + " " + str(avg))



plt.bar(students, averages)
plt.xlabel('Students')
plt.ylabel("Average Grade")
plt.title("Students and Average Grade")
plt.show()