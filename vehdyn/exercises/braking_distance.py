import numpy as np

# define constants
m = 1500  # mass of the vehicle (kg)
m_r = 98.4  # mass of the rotational components (kg)
m_t = m + m_r  # total mass (kg)
f_v = 0.01  # rolling resistance coefficient
g = 9.81  # acceleration due to gravity (m/s^2)
rho = 1.225  # air density (kg/m^3)
a = 2  # frontal area (m^2)
c_x = 0.26  # drag coefficient

def calculate_braking_distance(initial_velocity, mass, gravity=9.81, rolling_coefficient=0.01):
    """
    Calculate the braking distance of a vehicle considering only rolling resistance.
    
    Parameters:
    - initial_velocity: Initial velocity of the vehicle in m/s
    - mass: Mass of the vehicle in kg
    - gravity: Acceleration due to gravity in m/s^2 (default: 9.81)
    - rolling_coefficient: Coefficient of rolling resistance (default: 0.01)
    
    Returns:
    - Braking distance in meters
    """
    # Calculate the force of rolling resistance
    rolling_resistance = rolling_coefficient * mass * gravity
    
    # Calculate the deceleration due to rolling resistance
    deceleration = rolling_resistance / mass
    
    # Calculate the braking distance using the equation: d = v^2 / (2 * a)
    braking_distance = (initial_velocity ** 2) / (2 * deceleration)
    
    return braking_distance

# Example usage
if __name__ == "__main__":
    velocity = 20  # m/s
    vehicle_mass = 1500  # kg
    
    distance = calculate_braking_distance(velocity, vehicle_mass)
    print(f"Braking distance: {distance:.2f} meters")
