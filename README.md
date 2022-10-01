# aquila-net
This repository contains the source code of a RISC-V SoC with an embedded TCP/IP hardware network stack. This work is published at the 30th IFIP/IEEE International Conference on Very Large Scale Integration and System-on-Chip (VLSI-SOC), 2022. A draft of the manuscript is available [here](docs/aquila-net.pdf).

# About the RISC-V core
Note that the source code of the RISC-V processor in this repository is based on a slightly older version of the [Aquila project](https://github.com/eisl-nctu/aquila). The Aquila cores used in the HW TCP/IP SoC and the SW LwIP SoC are also slightly different.  We will upgrade, condense, and merge the various versions of the Aquila cores in the near future (promises, promises, ... ;).

# Creation of the complete Vivado workspaces of Aquila
To create the complete Vivado workspace for the Aquila SoC, you can use the build.tcl script in each source code directory. Simply download the source tree to a local directory, then run the following command under a DOS or Linux console:

```
<<Vivado Installation directory>>/bin/vivado -mode batch -source build.tcl
```

The created project workspace will be in the directory aquila_kc705/. The workspace does not use the Vivado IP Integrator as in the Aquila project. As a results, there will be slight timing vialation and clock-domain-crossing (CDC) methodlogy warnings when you synthesize the circuit. These warnings does not affect the execution of the HW-SW system. Such issues can be resolved if the AXI Interconnects are used for CDC, which would be trivial if IP integrator are used. Yet another promises: we will revised our CDC modules and resolve the timing violations without resorting to the AXI interconnet IPs in future releases.

# Contact Info
Embedded Intelligent Systems Lab (EISL)
Department of Computer Science
National Yang Ming Chiao Tung University
Hsinchu, Taiwan

eisl.nctu-at-gmail
