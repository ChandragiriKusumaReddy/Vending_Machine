# Vending_Machine
Verilog code for a vending machine that can take only two types of coins of denomination 1 and 2 in any order. It delivers only one product that is priced Rs.4. On receiving Rs.4 the product is delivered by asserting an output x=1 which otherwise remains 0 and extra coin will not be returned. If no coin is dropped for 6 seconds then the internally reset back to initial reset state. There are two sensors to sence the denomination of the coins that given binary output as shown in the below table. The clock frequency is 1Khz.

##Table
![Table](https://github.com/user-attachments/assets/2224484b-9f7a-4be3-8fd1-15b916546d8d)
##State Daigram
![statedaigram](statedaigram.jpeg)
