# Statistical Validation Framework for Automotive Vehicle Simulations using Uncertainty Learning
  
This framework enables statistical validation for automotive vehicle simulations in large application areas using uncertainty learning (VVUQ_Framework\@VVUQFramework_Main). With the  framework it is possible to flexibly validate every single simulation result of every individual application parameter configuration. It is focused on complex total vehicle simulations with a large number of changing parameters. The corresponding publicaiton for this framework is [1] and includes detailed information. The aim of this framework is to estimate the reliability of a model and each single simulation result depending on arbitrary parameter configurations of a large application domain. 

<div align="center">
<img src="Utilities/Graphics/ValidationApplicationDomain.png" height="200" align="center">
<\div>

<div align="left">
Therefore the model and result reliability of several validation parameter configurations must be estimated with multiple validation experiments forming the validation domain v. Based on the knowledge about the reliability from the validation domain the model and result reliability in the application domain can be predicted through inter- and extrapolation. The framework can be concluded as follows:
<\div>

<div align="center">
<img src="Utilities/Graphics/Method_-_GraphicalAbstract.png" height="600" align="center">
<\div>

<div align="left">
In this repository the model uncertainty of a smart for two estimating the consumption of the WLTC Class2 is calculated for ten parameter configurations using real measurements. The the air resistance, tyreparameters, and the mass of the vehicle are varied. they form the validaiton domain (VVUQ_Framework\@VVUQDomain_Main).
<\div>

<div align="center">
<img src="Utilities/Graphics/ValidationDomain.png" height="300" class="center">
<\div>

<div align="left">
Based on those validaiton points, the model reliability of new application parameter configurations are predictet with multidimesnional linear regression and applying an additional prediction confidence intervall. We call this part uncertainty learning (VVUQ_Framework\@VUCLearning_Main).
<\div>

<div align="center">
<center><p><img src="Utilities/Graphics/PredictedUncertainty.png" height="400" class="center"></p></center>

<div align="left">
For validation of the framework two example application parameter configurations are calculated once with the prediction intervall and once with additional validation measurements. Both model uncertainties can be compared (VVUQ_Framework\@VVUQDomain_Main, VVUQ_Framework\@VVUQSystem_Main). 
<\div>

<div align="center">
<img src="Utilities/Graphics/PredictedvVSRealUncertainty.png" height="300" class="center">

<div align="left">
Finally all results of the validation and application domain are plotted. Additionally the trained linear regression model is plottet showing the model uncertainty of potential application parameter configurations depending on the three parameters mass, air resistance and tyre. This framework is modular so that the input measurement data, the model itself, and the uncertainty learning parameters can be adapted. 
<\div>



  
## Getting Started

To get started after downloading the repository matlab has to be opened. The repository must be in the Matlab path. To start the a simulation run the script "Run_VVUQ_Framework.m". The script opens the longitudinal simulation model SmartFortwo, Parameterize it, run it and show the results.

  
### Prerequisites
To run the code Matlab 2020b or newer is required. Matlab can be downloaded [here](https://de.mathworks.com/downloads/web_downloads/). Additionally the repository needs to be downloaded at [VVUQ-Framework](https://github.com/TUMFTM/VVUQ-Framework) 
  
### Installing
After the repository is downloaded at  [VVUQ-Framework](https://github.com/TUMFTM/VVUQ-Framework) it needs to be unpacked in a folder of choice. 
  

  
### Running the Model/Code

To run the code Matlab must be started. Browse to the folder where the repository was unpacked and add the folder to the Matlab Path. By running the script "Run_VVUQ_Framework.m" the simulation starts. To run the script, type following command in the command line:
  
```
\>> Run_VVUQ_Framework
```
Because the running the Framework takes a long time some evaluation results are already stored in the folder "VVUQ_Framework\Results_VVUQ".
  
## Contributing and Support
  
For contributing to the code please contact [danquah@ftm.mw.tum.de](danquah@ftm.mw.tum.de).
  
## Versioning
V0.1 Initial Commit
  
  
## Authors
Benedikt Danquah, Markus Lienkamp, Johannes Rühm, Marius Kirchgeorg, Yasin Meral, Akhmadjon Islambekov.

## Acknowledgement
The Authors want to thank research associates of the Institute of Automotive Engineering, who reviewed and gave advise for the component library.


  
## License
This project is licensed under the LGPL License - see the LICENSE.md file for details

## Sources


[1]	B. Danquah, S. Riedmaier, Y. Meral, and M. Lienkamp, “Statistical validation framework for automotive vehicle simulations in large application areas using uncertainty learning,” Reliability Engineering & System Safety, in work 2021.

[[2]](https://www.researchgate.net/profile/Benedikt_Danquah) Benedikt Danquah, Alexander Koch, Tony Weiß, Markus Lienkamp, Modular, Open Source Simulation Approach: Application to Design and Analyze Electric Vehicles, in fourteenth International Conference on Ecological Vehicles and Renewable Energies, Monaco, 2019.
  

 


