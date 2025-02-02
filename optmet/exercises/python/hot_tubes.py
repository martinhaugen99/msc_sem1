from pulp import *

# Define the problem
model = LpProblem("Hot Tub Problem", LpMaximize)

# Define the decision variables
acqua_spas = LpVariable("aqua-spas", lowBound=0, cat="Integer")
hydro_luxes = LpVariable("hydro-luxes", lowBound=0, cat="Integer")

# Define the objective function
model += 350 * acqua_spas + 300 * hydro_luxes, "Total Profit"

# Define the constraints
model += 1 * acqua_spas + 1 * hydro_luxes <= 200, "Pumps Constraint"
model += 9 * acqua_spas + 6 * hydro_luxes <= 1566, "Labor Constraint"
model += 12 * acqua_spas + 16 * hydro_luxes <= 2880, "Tubing Constraint"

# Solve the problem
model.solve()

# Get the results
print(f"Status: {model.status}, {LpStatus[model.status]}")
print(f"Optimal number of Aqua-Spas: {acqua_spas.varValue}")
print(f"Optimal number of Hydro-Luxes: {hydro_luxes.varValue}")
print(f"Maximum profit: {model.objective.value()}")
