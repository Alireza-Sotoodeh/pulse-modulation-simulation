# Pulse Modulation Simulation Project

This repository contains a comprehensive project on **Pulse Modulation Simulation**, including simulations in **Proteus**, **Multisim**, and **MATLAB**, along with handwritten mathematical formulas and a detailed report in Persian. The project aims to demonstrate various pulse modulation techniques, their implementation, and analysis through simulation and theoretical calculations.

## Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
- [Pulse Modulation Techniques](#pulse-modulation-techniques)
  - [Pulse Amplitude Modulation (PAM)](#pulse-amplitude-modulation-pam)
  - [Pulse Width Modulation (PWM)](#pulse-width-modulation-pwm)
  - [Pulse Position Modulation (PPM)](#pulse-position-modulation-ppm)
  - [Pulse Code Modulation (PCM)](#pulse-code-modulation-pcm)
- [Repository Structure](#repository-structure)
- [Tools and Technologies](#tools-and-technologies)
- [Setup and Installation](#setup-and-installation)
- [How to Use](#how-to-use)
- [Simulation Details](#simulation-details)
  - [Proteus Simulations](#proteus-simulations)
  - [Multisim Simulations](#multisim-simulations)
  - [MATLAB Simulations](#matlab-simulations)
- [Mathematical Formulas](#mathematical-formulas)
- [Report](#report)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Project Overview
This project focuses on the simulation and analysis of pulse modulation techniques, including **Pulse Amplitude Modulation (PAM)**, **Pulse Width Modulation (PWM)**, **Pulse Position Modulation (PPM)**, and **Pulse Code Modulation (PCM)**. The simulations are performed using industry-standard tools such as Proteus, Multisim, and MATLAB. Additionally, the project includes handwritten mathematical derivations of the modulation techniques and a detailed Persian report explaining the methodology, results, and conclusions.

The goal is to provide a complete resource for understanding pulse modulation, suitable for students, researchers, and engineers working in signal processing and communication systems.

## Features
- Implementation of pulse modulation techniques (PAM, PWM, PPM, PCM).
- Simulations in Proteus, Multisim, and MATLAB with detailed results.
- Handwritten mathematical formulas explaining the theoretical foundation.
- Comprehensive Persian report summarizing the project.
- Well-organized repository with clear documentation.

## Pulse Modulation Techniques
This section provides an overview of the pulse modulation techniques implemented in this project.

### Pulse Amplitude Modulation (PAM)
PAM is a modulation technique where the amplitude of a series of pulses is varied in proportion to the amplitude of the input analog signal. The pulses are transmitted at regular intervals, and their amplitude carries the information of the input signal. PAM is commonly used as the first step in other modulation schemes, such as PCM.

### Pulse Width Modulation (PWM)
PWM, also known as Pulse Duration Modulation (PDM), involves varying the width of pulses in a pulse train proportional to the amplitude of the input signal. The pulse amplitude and frequency remain constant, but the duty cycle changes. PWM is widely used in applications such as motor control, power delivery, and communication systems.

### Pulse Position Modulation (PPM)
In PPM, the position of each pulse in a pulse train is varied relative to a reference time, based on the amplitude of the input signal. The pulse width and amplitude remain constant, but the timing of the pulses encodes the information. PPM is used in optical communications and remote control systems due to its robustness to noise.

### Pulse Code Modulation (PCM)
PCM is a digital modulation technique where the analog signal is sampled at regular intervals, quantized, and encoded into a binary format. Each sample is represented by a digital code, enabling robust transmission over noisy channels. PCM is the foundation for many digital communication systems, including telephony and audio storage.

## Repository Structure
The repository is organized as follows:
```
pulse-modulation-simulation/
│
├── proteus/                     # Proteus simulation files
│   ├── pam_simulation.DSN       # PAM simulation in Proteus
│   ├── pwm_simulation.DSN       # PWM simulation in Proteus
│   ├── ppm_simulation.DSN       # PPM simulation in Proteus
│   ├── pcm_simulation.DSN       # PCM simulation in Proteus
│
├── multisim/                    # Multisim simulation files
│   ├── pam_simulation.ms14      # PAM simulation in Multisim
│   ├── pwm_simulation.ms14      # PWM simulation in Multisim
│   ├── ppm_simulation.ms14      # PPM simulation in Multisim
│   ├── pcm_simulation.ms14      # PCM simulation in Multisim
│
├── matlab/                      # MATLAB scripts and simulations
│   ├── pam_simulation.m         # MATLAB script for PAM
│   ├── pwm_simulation.m         # MATLAB script for PWM
│   ├── ppm_simulation.m         # MATLAB script for PPM
│   ├── pcm_simulation.m         # MATLAB script for PCM
│
├── formulas/                    # Handwritten mathematical formulas
│   ├── pam_formulas.pdf         # PAM formulas (scanned)
│   ├── pwm_formulas.pdf         # PWM formulas (scanned)
│   ├── ppm_formulas.pdf         # PPM formulas (scanned)
│   ├── pcm_formulas.pdf         # PCM formulas (scanned)
│
├── report/                      # Project report
│   ├── pulse_modulation_report.pdf  # Detailed Persian report
│
└── README.md                    # This file
```

## Tools and Technologies
The following tools were used in this project:
- **Proteus**: For circuit design and simulation of pulse modulation techniques.
- **Multisim**: For additional circuit simulations and validation.
- **MATLAB**: For numerical analysis and visualization of modulation signals.
- **LaTeX/PDF**: For documenting handwritten formulas and the final report.

## Setup and Installation
To explore and run the simulations in this project, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Alireza-Sotoodeh/pulse-modulation-simulation.git
   cd pulse-modulation-simulation
   ```

2. **Install Required Software**:
   - Install **Proteus** (version 8 or higher) for circuit simulations.
   - Install **Multisim** (version 14 or higher) for additional circuit simulations.
   - Install **MATLAB** (version R2020a or higher) for running MATLAB scripts.
   - Ensure a PDF viewer is installed to view the formulas and report.

3. **Open Simulation Files**:
   - Open `.DSN` files in Proteus.
   - Open `.ms14` files in Multisim.
   - Run `.m` files in MATLAB.

4. **View Documentation**:
   - Open `.pdf` files in the `formulas/` and `report/` directories using a PDF viewer.

## How to Use
1. **Explore Simulations**:
   - Navigate to the `proteus/`, `multisim/`, or `matlab/` directories to access simulation files.
   - Run the simulations in their respective software to observe the modulation results.

2. **Review Formulas**:
   - Check the `formulas/` directory for scanned PDFs of handwritten mathematical derivations.

3. **Read the Report**:
   - The `report/` directory contains a detailed Persian report (`pulse_modulation_report.pdf`) explaining the project in depth.

## Simulation Details
### Proteus Simulations
The `proteus/` directory contains circuit designs for PAM, PWM, PPM, and PCM. Each `.DSN` file includes:
- A complete circuit schematic.
- Simulation settings for analyzing modulation outputs.
- Example waveforms for input and output signals.

### Multisim Simulations
The `multisim/` directory includes additional simulations for validation. Each `.ms14` file contains:
- Circuit configurations for PAM, PWM, PPM, and PCM.
- Measurement setups for analyzing signal characteristics.

### MATLAB Simulations
The `matlab/` directory contains scripts for numerical analysis of modulation techniques. Each `.m` file includes:
- Code to generate modulated signals.
- Visualization of input, carrier, and modulated signals.
- Analysis of signal parameters (e.g., amplitude, width, position, or code).

## Mathematical Formulas
The `formulas/` directory includes scanned PDFs of handwritten derivations for:
- **PAM**: Mathematical representation of amplitude modulation.
- **PWM**: Formulas for pulse width variation based on input signal.
- **PPM**: Equations for pulse position shifts relative to a reference.
- **PCM**: Derivations for sampling, quantization, and encoding processes.

These documents provide the theoretical foundation for the simulations and report.

## Report
The `report/` directory contains a comprehensive Persian report (`pulse_modulation_report.pdf`) that includes:
- Introduction to pulse modulation techniques.
- Methodology for simulations in Proteus, Multisim, and MATLAB.
- Analysis of results and comparisons.
- Conclusion and future work suggestions.

## Contributing
Contributions are welcome! If you would like to contribute to this project:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit (`git commit -m "Add feature"`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a pull request.

Please ensure your contributions align with the project's scope and include clear documentation.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
For questions or feedback, feel free to reach out:
- **GitHub**: [Alireza-Sotoodeh](https://github.com/Alireza-Sotoodeh)
- **Email**: ar.sotoodeh@eng.uk.ac.ir

Thank you for exploring the Pulse Modulation Simulation project!
