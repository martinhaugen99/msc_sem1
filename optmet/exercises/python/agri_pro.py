from pulp import *

# define the problem
model = LpProblem("A Blending Problem", LpMinimize)

# define the decision variables
feed_1 = LpVariable("Feed 1", lowBound=0, cat="Integer")
feed_2 = LpVariable("Feed 2", lowBound=0, cat="Integer")
feed_3 = LpVariable("Feed 3", lowBound=0, cat="Integer")
feed_4 = LpVariable("Feed 4", lowBound=0, cat="Integer")

# define the objective function
model += 0.25 * feed_1 + 0.3 * feed_2 + 0.32 * feed_3 + 0.15 * feed_4

# variable for storing the sum
sum = 1 * feed_1 + 1 * feed_2 + 1 * feed_3 + 1 * feed_4

# define the constraints
model += sum >= 8000, "Total order"
model += 0.3 * feed_1 + 0.05 * feed_2 + 0.2 * feed_3 + 0.1 * feed_4 >= 0.2 * sum, "corn constraint"
model += 0.1 * feed_1 + 0.3 * feed_2 + 0.15 * feed_3 + 0.1 * feed_4 >= 0.15 * sum, "grain constraint"
model += 0.2 * feed_1 + 0.15 * feed_2 + 0.2 * feed_3 + 0.1 * feed_4 >= 0.15 * sum, "mineral constraint"

# solve the problem
model.solve()

# get the results
print(f"Status: {model.status}, {LpStatus[model.status]}")
print(f"Optimal number of feed 1: {feed_1.varValue}")
print(f"Optimal number of feed 2: {feed_2.varValue}")
print(f"Optimal number of feed 3: {feed_3.varValue}")
print(f"Optimal number of feed 4: {feed_4.varValue}")
print(f"Minimum cost: {value(model.objective)}")