# ORGANOIDS
Diffusion Models for Nutrients, Metabolites, &amp; Signaling Factors in 3D Organoids and Tissue Constructs

Instructions for Supplementary Matlab Script

1. Save the "Interface.m" and "Interface.fig" files to the same location, then run the "Interface.m" file in Matlab. 


2. In the user interface that appears after running the script file, choose the shape that best represents the tissue construct and diffusion system.

     For flat sheets or slab-like constructs, diffusion is primarily uni-directional = Choose 1D.

     For cylindrical constructs, diffusion primarily occurs through a round interface = Choose 2D.

     For spherical constructs, diffusion occurs through all directions = Choose 3D.


3. Choose the conditions that best represent the system.

     Choose whether the diffusant molecule is diffusing into or out of the tissue construct.

     Choose whether the diffusant molecule is metabolized (like many nutrients) or not metabolized (like many signaling factors).

     Choose whether the diffusant molecule is of limited abundance (like glucose in media) or of unlimited abundance (like ambient oxygen).


4. Enter the parameters of the system.

     Enter the initial concentration of diffusant molecule at its source at the interface of the tissue construct (in mM, e.g., 10 mM glucose).

     Enter the desired duration of time for analysis (in seconds, e.g., 10,000 s).

     Enter the diffusion coefficient for the type of tissue construct (in mm^2/s).

          Note: generally in hydrogels the diffusion coefficient is around 10^-3 for oxygen, 10^-4 mm2/s for glucose, and 10^-5 mm2/s for proteins [2].

     Enter the average metabolic rate of consumption (f) of the diffusant molecule per cell (in mol/Ls).

          Note: the metabolic rate in the construct f is found by multiplying the metabolic rate per cell (generally within 10^-15 to 10^-19 mol/Ls) times the density of cells in the construct [2]. 

     Enter the thickness of the tissue slab or the radius of the round tissue construct (in mm).

          Note: the maximum thickness or radius can be obtained either through empirical observation or calculated from the metabolic rate [2]

     Enter the total volume of the tissue construct (or simply allow the computer to calculate this value from the prior entry by assuming that the construct is a cube or a sphere) (in mm^3, e.g., 4 mm^3).

     Enter the volume of media in which the tissue construct is cultured (in mm^3, e.g., 5000 mm^3).

5. Click the "Run" box, and after a bit of processing, 3D graph of results will be produced.

     The spatial axis (to the right) represents the thickness or radial depth of the tissue construct.

     The time axis (to the left) represents the length of time after initial starting conditions.

     The vertical axis represents the concentration of the diffusant molecule over time and space.

     The cursor tool at the top of the graph may be used to find exact values at any point.
