# Quarter Car Model

## simulation 1:

### components:

- zero force source
- mass(two port)
- connector
- spring
- damper
- connector
- mass(two port)
- springdamper
- xvcl01
- piecewise linear signal component

### values:

**mass 1:**
m = 300
theta = -90

**spring:**
springrate = 15 000
spring force = 3220

**damper:**
no change

**mass 2:**
m = 30
theta = -90

**springdamper:**
spring rate = 180 000
damper rating = 0

**xvlc01:**
no change

**piecewise linear signal:**
stages = 2
dur stage 1 = 0.1 s
output start stage 2 = 0.05
output at end of stage 2 = 0.05
dur stage 2 = 1e+06

### simulation:

- change displacement of mass 1 => body displacement
- displacement of mass 2 => wheel displacement

**visualize:**
- click on mass 1 => drag and drop body displacement to screen
- click on mass 2 => drag and drop wheel displacement into the same graph
- drag signal component to the same graph as well


## simulation 2:

### components:

### values:

### simulation:

