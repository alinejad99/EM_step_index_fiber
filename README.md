# EM_step_index_fiber

Optical Fiber Simulation
This repository contains a Python code for simulating the behavior of single-mode optical fibers with step-index refractive profiles. Optical fibers are cylindrical dielectric waveguides with a higher refractive index in the core, causing light to be trapped within the core due to total internal reflection.

Optical fibers can generally be classified into two types:
1.Step-Index Fiber (SI): In this type, the refractive index changes abruptly from the core (n1) to the cladding (n2).
2.Gradual-Index Fiber (GI): In this type, the refractive index changes gradually from the core to the cladding.

This project focuses on the electromagnetic analysis of Step-Index Optical Fibers (SI) and aims to calculate its propagation modes and the maximum single-mode frequency.

For simplicity, we assume that the cladding extends to infinity, which is a reasonable approximation since the non-propagating fields outside the core do not significantly affect the analysis. The optical fiber parameters are defined as follows:
Δ = 1 - (n2^2 / n1^2), where n1 > n2. Δ is the fractional refractive index difference.
V-parameter (V) = k0 * a * sqrt(n1^2 - n2^2), where a is the core radius, k0 is the wave vector in free space, and n1 and n2 are the refractive indices of the core and cladding, respectively.
We solve Maxwell's equations inside and outside the core to obtain the propagation modes. The governing equations are as follows:

Inside the core:
∇²E + n²(ω) * k0² * E = 0

Outside the core:
∂²Ez/∂ρ² + (1/ρ) * ∂Ez/∂ρ + (1/ρ²) * ∂²Ez/∂φ² + ∂²Ez/∂z² + n²(ω) * k0² * Ez = 0
Where n(ρ, z) is the refractive index distribution inside the core.

The modes are characterized by the field distributions of the electric (Ez) and magnetic (Hz) components in the axial (z) direction.

Simulation Parameters:
Core radius (a): 9.1 µm
Free-space wavelength (λ₀): 1.55 µm
Core refractive index (n₁): 1.45
Fractional refractive index difference (Δ): 6.8966 × 10⁻⁴
Cladding radius (b): 10a
Air cladding region: Radius 1.2 times the core radius around the fiber.

How to Run the Simulation:
Clone this repository to your local machine.
Install the required Python libraries (ciptO package).
Run the simulation code using the vaW module.
