


columns = ["Name", "Assignment", "Homework", "Project", "Exam"]
students = {
    "John": [91, 89, 88, 87],
    "Annie": [99, 95, 95, 93],
    "Joy": [92, 94, 91, 90]
}

with open ("grades.csv", "w") as file:
    line = ",".join(columns)
    file.write(line + "\n")

    for student, grades in students.items():
        line = student + "," + ",".join(map(str, grades))
        file.write(line + "\n")



def myScores():
    students = dict()

    with open("grades.csv", "r") as file:
        next(file)

        for line in file:
            total = 0
            num_of_grades = 0

            data = line.split(",")
            student = data[0]
            
            for grade in data[1:]:
                total += int(grade)
                num_of_grades += 1

            students[student] = total/num_of_grades

    return students


