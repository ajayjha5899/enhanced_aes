# Enhanced AES Implementation
The Advanced Encryption Standard (AES) is the most widely used symmetric block cipher today. The AES block cipher is also mandatory in several industry standards and is used in many commercial systems. Among the commercial standards that include AES are the Internet security standard IPsec, TLS, the Wi-Fi encryption standard IEEE 802.11i, the secure shell network protocol SSH (Secure Shell), almost all internet browsers like Google Chrome, Firefox, etc. and numerous security products around the world. To date, there are no attacks better than brute-force known against AES.

In this repository, we have focused on understanding the underlying steps in the AES encryption algorithm, take a look at the PN sequence based S-box and key generator and finally implemented the algorithm in Verilog and tested the implementation using NIST's AES standard test blocks in ECB mode.

## Repository Sturcture
| Directory |Description  |
|--|--|
| 1_Requirements | Documents detailing requirements and research. |
| 2_Design | Documents specifying designing details. |
| 3_Implementation | Source code of all modules and respective testbench. |
| 4_Tests | Documentation of tests performed. |

## Tools Used
- [Icarus Verilog](http://iverilog.icarus.com/) : Verilog simulation and synthesis tool. 
- [GTK Wave](https://github.com/gtkwave/gtkwave) : Simulation timing diagram plotting tool.
- [VSCode](https://code.visualstudio.com/download) : Code editor. (The best one)
- [StackEdit](https://stackedit.io/) : Online markdown editor.

## Challenges faced
- Implementation of GF(8) multiplication.
- Implementation of encryption-decryption loopback .

## Resources and references
- *[An efficient AES implementation using FPGA with enhanced security features](https://www.sciencedirect.com/science/article/pii/S1018363918302071)*
- *[Understanding Cryptography](https://link.springer.com/book/10.1007/978-3-642-04101-3)* (Chapter 4: The Advanced Encryption Standard)
- *[The Rijndael Block Cipher](https://csrc.nist.gov/csrc/media/projects/cryptographic-standards-and-guidelines/documents/aes-development/rijndael-ammended.pdf)*
- [AES (ECB mode) testbench 128-bit data blocks](https://csrc.nist.gov/projects/cryptographic-algorithm-validation-program/block-ciphers)
