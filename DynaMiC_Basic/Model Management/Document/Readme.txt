The 'SHE215.mat' file contains a struct with the topology, configuration, load and other information of the SHE215 feeder.

Option: fileName, delta load flow type;

Topology: fromNode, toNode, length, line configuration;

Configuration: type, line/transformer, R11, R12, R13, R23, R33, X11, X12, X13, X23, X33, B11, B12, B13, B23, B33;

Load: Node, Y/Delta, PQ/I/Z, kW-PhaseA, kVAr-PhaseA, kW-PhaseB, kVAr-PhaseB, kW-PhaseC, kVAr-PhaseC;

Regulator: location of regulators;

Slack: slack node number;

Vpu_slack_phase: voltage phasor of slack node;

Vnom: voltage base;

Switches: location of switches;

Graphic: node, X coordinate; Y coordinate;

NumN: number of node;

NumL: number of line;

NumC: number of customer;

NumZ: number of configuration type;

NumR: number of regulator;

NumS: number of switch;

Nodes_ID: ID of the node;

ZLIN: impedance of the line configuration;

BLIN: susceptance of the line configuration;